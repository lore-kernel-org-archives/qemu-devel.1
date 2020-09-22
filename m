Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C484C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B30C239E5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeCnANBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B30C239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcBS-0000yU-35
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKc7R-0005mN-G0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:49:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKc7P-000399-Mk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDQeJdHtO9KKiU5gOx4KTLWOTYyHCvaG0zPgbwdT5eQ=;
 b=CeCnANBTM8Zg8p7qTEM2CVm745y9gtbCpb+KXWOx4VukldvwpgL7JKKE4FnCaY9I3jD3nu
 kzD6u8mbnISfSKWXXaFbyIcFoXemg/5/DcIm8HE3pDyhQXe5mwoTrY3Ye4KzIRJSd3F9Du
 Mft7+Ci7aUF6D1uo4SSD80wW7wz46pE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Kl64qFh0N52hOg7Handu7w-1; Tue, 22 Sep 2020 02:49:36 -0400
X-MC-Unique: Kl64qFh0N52hOg7Handu7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D10B41868409
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:49:35 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6615E78803;
 Tue, 22 Sep 2020 06:49:31 +0000 (UTC)
Date: Tue, 22 Sep 2020 08:49:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 22/24] i440fx: Register i440FX-pcihost properties as
 class properties
Message-ID: <20200922084930.185fdcc0@redhat.com>
In-Reply-To: <20200921221045.699690-23-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-23-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 18:10:43 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/pci-host/i440fx.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 93c62235ca7..4454ba06621 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -212,22 +212,6 @@ static void i440fx_pcihost_initfn(Object *obj)
>                            "pci-conf-idx", 4);
>      memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
>                            "pci-conf-data", 4);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> -                        i440fx_pcihost_get_pci_hole_start,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> -                        i440fx_pcihost_get_pci_hole_end,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> -                        i440fx_pcihost_get_pci_hole64_start,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> -                        i440fx_pcihost_get_pci_hole64_end,
> -                        NULL, NULL, NULL);
>  }
>  
>  static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
> @@ -403,6 +387,22 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
>      device_class_set_props(dc, i440fx_props);
>      /* Reason: needs to be wired up by pc_init1 */
>      dc->user_creatable = false;
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> +                              i440fx_pcihost_get_pci_hole_start,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> +                              i440fx_pcihost_get_pci_hole_end,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> +                              i440fx_pcihost_get_pci_hole64_start,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> +                              i440fx_pcihost_get_pci_hole64_end,
> +                              NULL, NULL, NULL);
>  }
>  
>  static const TypeInfo i440fx_pcihost_info = {


