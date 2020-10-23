Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A34C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9AD20853
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PA9ynki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9AD20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW1oZ-0004OU-R9
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 14:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW1lX-0001ms-R6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW1lT-0000AJ-P9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 14:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603477570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cWxhWBNOTr9nQOGGNr1g6wS5W2yBd07sYHZza77yOg=;
 b=PA9ynki5LH7tcxzMeSaLU4wO7PlN/J72JYjn0c7rGQvANXadPuFcOe/eG5kHwW9YT8hyF4
 9sLg6ghsDBItkNrvcMqlURdwLFgt1hExGv6KBjWJ7d1S8GO+/WYu31t83kkOaw+GOkF2ot
 ZdhC3bdsjgQvYVCZoFuTkPqKvhyY1BA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-doiJAT2xMeqHeZFUKPvXfQ-1; Fri, 23 Oct 2020 14:26:08 -0400
X-MC-Unique: doiJAT2xMeqHeZFUKPvXfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC941084C91;
 Fri, 23 Oct 2020 18:26:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 360D95C1CF;
 Fri, 23 Oct 2020 18:26:04 +0000 (UTC)
Date: Fri, 23 Oct 2020 20:26:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 15/24] arm/virt: Register most properties as class
 properties
Message-ID: <20201023202603.351fedee@redhat.com>
In-Reply-To: <20200921221045.699690-16-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-16-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 18:10:36 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/arm/virt.c | 76 +++++++++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index acf9bfbecea..d1ab660fa60 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2443,6 +2443,47 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>          NULL, NULL);
>      object_class_property_set_description(oc, "acpi",
>          "Enable ACPI");
> +    object_class_property_add_bool(oc, "secure", virt_get_secure,
> +                                   virt_set_secure);
> +    object_class_property_set_description(oc, "secure",
> +                                                "Set on/off to enable/disable the ARM "
> +                                                "Security Extensions (TrustZone)");
> +
> +    object_class_property_add_bool(oc, "virtualization", virt_get_virt,
> +                                   virt_set_virt);
> +    object_class_property_set_description(oc, "virtualization",
> +                                          "Set on/off to enable/disable emulating a "
> +                                          "guest CPU which implements the ARM "
> +                                          "Virtualization Extensions");
> +
> +    object_class_property_add_bool(oc, "highmem", virt_get_highmem,
> +                                   virt_set_highmem);
> +    object_class_property_set_description(oc, "highmem",
> +                                          "Set on/off to enable/disable using "
> +                                          "physical address space above 32 bits");
> +
> +    object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
> +                                  virt_set_gic_version);
> +    object_class_property_set_description(oc, "gic-version",
> +                                          "Set GIC version. "
> +                                          "Valid values are 2, 3, host and max");
> +
> +    object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
> +    object_class_property_set_description(oc, "iommu",
> +                                          "Set the IOMMU type. "
> +                                          "Valid values are none and smmuv3");
> +
> +    object_class_property_add_bool(oc, "ras", virt_get_ras,
> +                                   virt_set_ras);
> +    object_class_property_set_description(oc, "ras",
> +                                          "Set on/off to enable/disable reporting host memory errors "
> +                                          "to a KVM guest using ACPI and guest external abort exceptions");
> +
> +    object_class_property_add_bool(oc, "mte", virt_get_mte, virt_set_mte);
> +    object_class_property_set_description(oc, "mte",
> +                                          "Set on/off to enable/disable emulating a "
> +                                          "guest CPU which implements the ARM "
> +                                          "Memory Tagging Extension");
>  }
>  
>  static void virt_instance_init(Object *obj)
> @@ -2455,34 +2496,13 @@ static void virt_instance_init(Object *obj)
>       * boot UEFI blobs which assume no TrustZone support.
>       */
>      vms->secure = false;
> -    object_property_add_bool(obj, "secure", virt_get_secure,
> -                             virt_set_secure);
> -    object_property_set_description(obj, "secure",
> -                                    "Set on/off to enable/disable the ARM "
> -                                    "Security Extensions (TrustZone)");
>  
>      /* EL2 is also disabled by default, for similar reasons */
>      vms->virt = false;
> -    object_property_add_bool(obj, "virtualization", virt_get_virt,
> -                             virt_set_virt);
> -    object_property_set_description(obj, "virtualization",
> -                                    "Set on/off to enable/disable emulating a "
> -                                    "guest CPU which implements the ARM "
> -                                    "Virtualization Extensions");
>  
>      /* High memory is enabled by default */
>      vms->highmem = true;
> -    object_property_add_bool(obj, "highmem", virt_get_highmem,
> -                             virt_set_highmem);
> -    object_property_set_description(obj, "highmem",
> -                                    "Set on/off to enable/disable using "
> -                                    "physical address space above 32 bits");
>      vms->gic_version = VIRT_GIC_VERSION_NOSEL;
> -    object_property_add_str(obj, "gic-version", virt_get_gic_version,
> -                        virt_set_gic_version);
> -    object_property_set_description(obj, "gic-version",
> -                                    "Set GIC version. "
> -                                    "Valid values are 2, 3, host and max");
>  
>      vms->highmem_ecam = !vmc->no_highmem_ecam;
>  
> @@ -2500,26 +2520,12 @@ static void virt_instance_init(Object *obj)
>  
>      /* Default disallows iommu instantiation */
>      vms->iommu = VIRT_IOMMU_NONE;
> -    object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu);
> -    object_property_set_description(obj, "iommu",
> -                                    "Set the IOMMU type. "
> -                                    "Valid values are none and smmuv3");
>  
>      /* Default disallows RAS instantiation */
>      vms->ras = false;
> -    object_property_add_bool(obj, "ras", virt_get_ras,
> -                             virt_set_ras);
> -    object_property_set_description(obj, "ras",
> -                                    "Set on/off to enable/disable reporting host memory errors "
> -                                    "to a KVM guest using ACPI and guest external abort exceptions");
>  
>      /* MTE is disabled by default.  */
>      vms->mte = false;
> -    object_property_add_bool(obj, "mte", virt_get_mte, virt_set_mte);
> -    object_property_set_description(obj, "mte",
> -                                    "Set on/off to enable/disable emulating a "
> -                                    "guest CPU which implements the ARM "
> -                                    "Memory Tagging Extension");
>  
>      vms->irqmap = a15irqmap;
>  


