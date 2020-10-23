Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49559C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD65E208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQmMPMbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD65E208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1iA-0007p9-NF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW1gs-0006gS-5r
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW1gq-0007yU-Ez
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603477283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6rN1ivDhG0GBRtCj5g1td6cnY2bemZXiCNueIy2C0s=;
 b=ZQmMPMbMC8JgekzKKOiXKtxcvbcA00AofVq8xoDJosY58DTY4D5Xsy23E8cICq5YYEhDxP
 Mwb1p+O7QvmXnw1OXKpHeLapPkufmJWxZPSFI60ytdfB6/D3/SOkOBpxHUrDJ2D+Nqmhr1
 aYlRD4RXuAxoOzwNB/+un41Li2vH2CM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-GHCB5oSpNbe9BddCc5SbPg-1; Fri, 23 Oct 2020 14:21:21 -0400
X-MC-Unique: GHCB5oSpNbe9BddCc5SbPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 714401018F64
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 18:21:20 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4F7F55793;
 Fri, 23 Oct 2020 18:21:18 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:21:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 11/24] tmp421: Register properties as class properties
Message-ID: <20201023202117.067fcbbe@redhat.com>
In-Reply-To: <20200921221045.699690-12-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-12-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 18:10:32 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Cc: qemu-devel@nongnu.org
> ---
>  hw/misc/tmp421.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
> index 212d6e0e831..1c19a3a9713 100644
> --- a/hw/misc/tmp421.c
> +++ b/hw/misc/tmp421.c
> @@ -340,22 +340,6 @@ static void tmp421_realize(DeviceState *dev, Error **errp)
>      tmp421_reset(&s->i2c);
>  }
>  
> -static void tmp421_initfn(Object *obj)
> -{
> -    object_property_add(obj, "temperature0", "int",
> -                        tmp421_get_temperature,
> -                        tmp421_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature1", "int",
> -                        tmp421_get_temperature,
> -                        tmp421_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature2", "int",
> -                        tmp421_get_temperature,
> -                        tmp421_set_temperature, NULL, NULL);
> -    object_property_add(obj, "temperature3", "int",
> -                        tmp421_get_temperature,
> -                        tmp421_set_temperature, NULL, NULL);
> -}
> -
>  static void tmp421_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -368,6 +352,19 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
>      k->send = tmp421_tx;
>      dc->vmsd = &vmstate_tmp421;
>      sc->dev = (DeviceInfo *) data;
> +
> +    object_class_property_add(klass, "temperature0", "int",
> +                              tmp421_get_temperature,
> +                              tmp421_set_temperature, NULL, NULL);
> +    object_class_property_add(klass, "temperature1", "int",
> +                              tmp421_get_temperature,
> +                              tmp421_set_temperature, NULL, NULL);
> +    object_class_property_add(klass, "temperature2", "int",
> +                              tmp421_get_temperature,
> +                              tmp421_set_temperature, NULL, NULL);
> +    object_class_property_add(klass, "temperature3", "int",
> +                              tmp421_get_temperature,
> +                              tmp421_set_temperature, NULL, NULL);
>  }
>  
>  static const TypeInfo tmp421_info = {
> @@ -375,7 +372,6 @@ static const TypeInfo tmp421_info = {
>      .parent        = TYPE_I2C_SLAVE,
>      .instance_size = sizeof(TMP421State),
>      .class_size    = sizeof(TMP421Class),
> -    .instance_init = tmp421_initfn,
>      .abstract      = true,
>  };
>  


