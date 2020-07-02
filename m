Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F324C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4900820675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtrPRx+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4900820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxPf-0001bd-Gn
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxMX-0003eU-L2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:26:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqxMW-0007b4-1X
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593689199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JfM6OLCt1Oz7J160Bs1Wy7L5auM7Ow31HfnQNnRNMNo=;
 b=AtrPRx+wCQmH/hp2rK8z1f/W39/lDn09YX3ySCsmXnNZJvwxCQHJ4zCNm6nFWQ4le886fy
 Aff3vKoEFemSvcsR/DhdJ6onUFZNfU+JJtrhNK9QIgPbURPmGhP5xQv+8WJUjX7jeyoA+z
 5KepjCtW338ol78dp4ydlECA2Yk3KsY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-BOhwQo22MA-5zl4PhhLA2A-1; Thu, 02 Jul 2020 07:26:37 -0400
X-MC-Unique: BOhwQo22MA-5zl4PhhLA2A-1
Received: by mail-wm1-f72.google.com with SMTP id g187so28342765wme.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JfM6OLCt1Oz7J160Bs1Wy7L5auM7Ow31HfnQNnRNMNo=;
 b=cwXN7qRQgVRV7+jHONrpwttTXEwiUgrqskj3pqi+hHMDPXB+8YhlGsyUYCRyZm/CeL
 OfqnjZEj6lpzXUueMK4cbMqd2QHo3+kmeojcYcd/alGrxOs56y0WKxpfWq8/t2tJJ99Q
 i1jLjpoxK078magrc9qsDPoAwLkFJ5wFpR6f7G9fSUYQcR/I/J8QTkWzd9+ka5oVpMDN
 /PaVJ61ViX4DQUfEAizCB9FIjuveCdoB/j1nFFbDuxrPfR4UeBavaIWxm44Bu5us/d+C
 Zwp3XstTdFrb6KRlh7rqlRQMKkCLsAFBrVTfP9Te1dGqWwOT65D0A1n/zN2kNP0S/F1G
 M1dA==
X-Gm-Message-State: AOAM532XK44Y/aqFxAcuZ/XZx1tnrHEo5mKiVAJBNBp+F25tNAmnH43d
 X6l1q/1i+xH9N07mFWDCBmmcFBNjhjmhDZHoKeXAH3JJA1lfENBKjf85xupPDuGLdl1qmb5oMv5
 JwfWYJmJXcyUO/Gk=
X-Received: by 2002:adf:e88b:: with SMTP id d11mr21403384wrm.378.1593689196627; 
 Thu, 02 Jul 2020 04:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVv0p8fjJlZB/6dkfAX+cGUpWJJ7KMRhh3pofEy0BXAm5PMTCy6uKjzf20yAsW4Vdk0dm9NQ==
X-Received: by 2002:adf:e88b:: with SMTP id d11mr21403375wrm.378.1593689196434; 
 Thu, 02 Jul 2020 04:26:36 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id c25sm9890047wml.46.2020.07.02.04.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:26:35 -0700 (PDT)
Date: Thu, 2 Jul 2020 07:26:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v7 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
Message-ID: <20200702072623-mutt-send-email-mst@kernel.org>
References: <20200629070404.10969-1-eric.auger@redhat.com>
 <20200629070404.10969-6-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629070404.10969-6-eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, jean-philippe@linaro.org, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 09:04:04AM +0200, Eric Auger wrote:
> At the moment the virtio-iommu translates MSI transactions.
> This behavior is inherited from ARM SMMU. The virt machine
> code knows where the guest MSI doorbells are so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest will not map MSIs through the IOMMU and those
> transactions will be simply bypassed.
> 
> Depending on which MSI controller is in use (ITS or GICV2M),
> we declare either:
> - the ITS interrupt translation space (ITS_base + 0x10000),
>   containing the GITS_TRANSLATOR or
> - The GICV2M single frame, containing the MSI_SETSP_NS register.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

This needs ARM ACK.

> ---
> v5 -> v6:
> - do not hardcode doorbell base and size
> - removed Jean's R-b
> 
> v3 -> v4:
> - use ':' as separators
> 
> v2 -> v3:
> - Add a new value to VirtMSIControllerType
> 
> v1 -> v2:
> - Test which MSI controller is instantiated
> - If GICV2M is in use, declare its doorbell as an MSI doorbell too
> ---
>  include/hw/arm/virt.h |  7 +++++++
>  hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 31878ddc72..a18b6b397b 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -96,6 +96,12 @@ typedef enum VirtIOMMUType {
>      VIRT_IOMMU_VIRTIO,
>  } VirtIOMMUType;
>  
> +typedef enum VirtMSIControllerType {
> +    VIRT_MSI_CTRL_NONE,
> +    VIRT_MSI_CTRL_GICV2M,
> +    VIRT_MSI_CTRL_ITS,
> +} VirtMSIControllerType;
> +
>  typedef enum VirtGICType {
>      VIRT_GIC_VERSION_MAX,
>      VIRT_GIC_VERSION_HOST,
> @@ -136,6 +142,7 @@ typedef struct {
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;
> +    VirtMSIControllerType msi_controller;
>      uint16_t virtio_iommu_bdf;
>      struct arm_boot_info bootinfo;
>      MemMapEntry *memmap;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index cd0834ce7f..eb4344cf6e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -602,6 +602,7 @@ static void create_its(VirtMachineState *vms)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
>  
>      fdt_add_its_gic_node(vms);
> +    vms->msi_controller = VIRT_MSI_CTRL_ITS;
>  }
>  
>  static void create_v2m(VirtMachineState *vms)
> @@ -622,6 +623,7 @@ static void create_v2m(VirtMachineState *vms)
>      }
>  
>      fdt_add_v2m_gic_node(vms);
> +    vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>  }
>  
>  static void create_gic(VirtMachineState *vms)
> @@ -2200,8 +2202,36 @@ out:
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        hwaddr db_start = 0, db_end = 0;
> +        char *resv_prop_str;
> +
> +        switch (vms->msi_controller) {
> +        case VIRT_MSI_CTRL_NONE:
> +            return;
> +        case VIRT_MSI_CTRL_ITS:
> +            /* GITS_TRANSLATER page */
> +            db_start = base_memmap[VIRT_GIC_ITS].base + 0x10000;
> +            db_end = base_memmap[VIRT_GIC_ITS].base +
> +                     base_memmap[VIRT_GIC_ITS].size - 1;
> +            break;
> +        case VIRT_MSI_CTRL_GICV2M:
> +            /* MSI_SETSPI_NS page */
> +            db_start = base_memmap[VIRT_GIC_V2M].base;
> +            db_end = db_start + base_memmap[VIRT_GIC_V2M].size - 1;
> +            break;
> +        }
> +        resv_prop_str = g_strdup_printf("0x%"PRIx64":0x%"PRIx64":%u",
> +                                        db_start, db_end,
> +                                        VIRTIO_IOMMU_RESV_MEM_T_MSI);
> +
> +        qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +        qdev_prop_set_string(dev, "reserved-regions[0]", resv_prop_str);
> +        g_free(resv_prop_str);
>      }
>  }
>  
> -- 
> 2.20.1


