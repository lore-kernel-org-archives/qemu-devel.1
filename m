Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D58C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A15B208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 14:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgWRDJDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A15B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc8u7-00033f-Rq
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jc8tX-0002X8-OF
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:43:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jc8tW-0003x5-RM
 for qemu-devel@nongnu.org; Fri, 22 May 2020 10:43:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id u12so5261029wmd.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MzXM9ZTSVhAGl1xhNJfU6hscjoth3y+knm1AH12KcsM=;
 b=pgWRDJDfRcoJuttcwyI+yTrDi+pUBuIYkag0yzfHfVJRDe7+ItmXheyjCsci/z0fTf
 6NMtSBP4Qn/0g9Sf4qdYCFuIanCsaELFi6AMw54xNnBBrbpnypnoCYrR6AulzUwVnGBL
 GSGFzZBx4o51lxomAvJIhcrNuw3BfeXGFSuCb3xKHI8xhyu+z+rZ063/hdTBpgYfM9qS
 NDLJKpcjnSGdGMvU3dIi4LFOiFV2EodTVFb4y7OMQWomNErTg7kREQqsLOtY7U9M25VB
 EUfXzF/0ulbFJh8wxKLOHkqwWgKlCnD4KQeAdd/LRtnY2ZQ0H7WpThTSyyOY260aXpug
 AFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MzXM9ZTSVhAGl1xhNJfU6hscjoth3y+knm1AH12KcsM=;
 b=SCRnqL1IeR4vSZXLrDASwJlOPlS8MhqzeqHz3pIxGTO2WEGUc7GvB+BzSEk4rm6vLF
 BTO8H1Q3wWIrCBTCl1XeMyF0nzxnYJOxmDrHRfBJ7VdSDPtKTky62MMHGDDMeeS1TNMI
 TJMa1+JPobRmIwY9wpXlB8IN3UGxewicgsJCE+PjIediidZeFVL8JD387VgPLmQWwVjG
 aX7JzF2Frb4jcAxv4vzpRgZ3UQ3MsMQRX1GjKNxbeibVfHl7yT+D8nRdi+T+iW2t43+X
 dT4BrxogpxPNlJ4QQS15Xshs7K7skkddskHjBFe9H5iPlTD7/nmeR09DjLMnlXEVTI8F
 JLxQ==
X-Gm-Message-State: AOAM532QJ5XS3nQ0KqvJNy4ZHm/p+o0BvHQNhFrH1hvcu2dKu6/L5SoO
 a+Hspv7/T8JFxeZml10cMsibbw==
X-Google-Smtp-Source: ABdhPJwJIoGx3WbJsxwRXXSoySBvl82ysTudo0Do5Fujrx5b19YvDSz3ZTa3LlxNruWsRK65Q0lp7A==
X-Received: by 2002:a1c:96d8:: with SMTP id y207mr6574623wmd.167.1590158608911; 
 Fri, 22 May 2020 07:43:28 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id x5sm10154315wro.12.2020.05.22.07.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 07:43:27 -0700 (PDT)
Date: Fri, 22 May 2020 16:43:17 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
Message-ID: <20200522144317.GB3453945@myrica>
References: <20200508173057.32215-1-eric.auger@redhat.com>
 <20200508173057.32215-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508173057.32215-6-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 08, 2020 at 07:30:57PM +0200, Eric Auger wrote:
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
> 
> ---
> 
> v1 -> v2:
> - Test which MSI controller is instantiated
> - If GICV2M is in use, declare its doorbell as an MSI doorbell too
> ---
>  include/hw/arm/virt.h |  6 ++++++
>  hw/arm/virt.c         | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 6d67ace76e..ad20cb6e15 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -96,6 +96,11 @@ typedef enum VirtIOMMUType {
>      VIRT_IOMMU_VIRTIO,
>  } VirtIOMMUType;
>  
> +typedef enum VirtMSIControllerType {
> +    VIRT_GICV2M,
> +    VIRT_ITS,
> +} VirtMSIControllerType;

I think you need a third value for msi_controller == 0. If I instantiate a
GICv3 without ITS at the moment the V2M region gets reserved. Not a big
deal since MSIs aren't supported at all in this case, but it would be
cleaner to skip any reservation.

Thanks,
Jean

> +
>  typedef enum VirtGICType {
>      VIRT_GIC_VERSION_MAX,
>      VIRT_GIC_VERSION_HOST,
> @@ -135,6 +140,7 @@ typedef struct {
>      OnOffAuto acpi;
>      VirtGICType gic_version;
>      VirtIOMMUType iommu;
> +    VirtMSIControllerType msi_controller;
>      uint16_t virtio_iommu_bdf;
>      struct arm_boot_info bootinfo;
>      MemMapEntry *memmap;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 634db0cfe9..d2dd07885b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -602,6 +602,7 @@ static void create_its(VirtMachineState *vms)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
>  
>      fdt_add_its_gic_node(vms);
> +    vms->msi_controller = VIRT_ITS;
>  }
>  
>  static void create_v2m(VirtMachineState *vms)
> @@ -622,6 +623,7 @@ static void create_v2m(VirtMachineState *vms)
>      }
>  
>      fdt_add_v2m_gic_node(vms);
> +    vms->msi_controller = VIRT_GICV2M;
>  }
>  
>  static void create_gic(VirtMachineState *vms)
> @@ -2136,8 +2138,24 @@ out:
>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
> +
> +        if (vms->msi_controller == VIRT_ITS) {
> +            /* GITS_TRANSLATER page */
> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +            qdev_prop_set_string(dev, "reserved-regions[0]",
> +                                 "0x8090000, 0x809FFFF, 1");
> +        } else if (vms->msi_controller == VIRT_GICV2M) {
> +            /* MSI_SETSPI_NS page */
> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +            qdev_prop_set_string(dev, "reserved-regions[0]",
> +                                 "0x8020000, 0x8020FFF, 1");
> +        }
>      }
>  }
>  
> -- 
> 2.20.1
> 

