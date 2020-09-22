Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA2AC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9476D208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ5r5uFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9476D208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKbzF-0000Cq-FM
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKby8-0008CJ-7X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKby4-0001xV-2I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600756799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d7At3WKMgVEYVUefvIbYjReA4ONmGt+j/y5G386jCeQ=;
 b=QJ5r5uFNGx0crRWV2He9yNZqDzTpdO55t2h+fXUxktJAun7ADN/cQpr1/w4N834txNt4ta
 0WGod3M8fwLmxwDQTSf86D/KU5h7XCEO1kzQP9b+LN03+a26/hyfG5pvJbu3s9w1DeUF4w
 A6dkR9UANsV5XctBSKe6i2K/68dcxFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-R5lE_y0vPkif_OupCjpVqg-1; Tue, 22 Sep 2020 02:39:57 -0400
X-MC-Unique: R5lE_y0vPkif_OupCjpVqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EFFB801F9A
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 06:39:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10DB878826;
 Tue, 22 Sep 2020 06:39:54 +0000 (UTC)
Date: Tue, 22 Sep 2020 08:39:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 20/24] machine: Register "memory-backend" as class property
Message-ID: <20200922083954.62e4455c@redhat.com>
In-Reply-To: <20200921221045.699690-21-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-21-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

On Mon, 21 Sep 2020 18:10:41 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: qemu-devel@nongnu.org

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/core/machine.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index ea26d612374..675ca6d651c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -874,6 +874,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
>          machine_get_memory_encryption, machine_set_memory_encryption);
>      object_class_property_set_description(oc, "memory-encryption",
>          "Set memory encryption object to use");
> +
> +    object_class_property_add_str(oc, "memory-backend",
> +                                  machine_get_memdev, machine_set_memdev);
> +    object_class_property_set_description(oc, "memory-backend",
> +                                          "Set RAM backend"
> +                                          "Valid value is ID of hostmem based backend");
>  }
>  
>  static void machine_class_base_init(ObjectClass *oc, void *data)
> @@ -925,12 +931,6 @@ static void machine_initfn(Object *obj)
>                                          "Table (HMAT)");
>      }
>  
> -    object_property_add_str(obj, "memory-backend",
> -                            machine_get_memdev, machine_set_memdev);
> -    object_property_set_description(obj, "memory-backend",
> -                                    "Set RAM backend"
> -                                    "Valid value is ID of hostmem based backend");
> -
>      /* Register notifier when init is done for sysbus sanity checks */
>      ms->sysbus_notifier.notify = machine_init_notify;
>      qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);


