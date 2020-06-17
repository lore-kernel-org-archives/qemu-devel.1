Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C720BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BA92078D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfEnXo0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BA92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlUEi-0001M8-RW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 05:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUDs-0000fW-GZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:19:08 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1jlUDp-0004P2-EW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 05:19:08 -0400
Received: by mail-ed1-x542.google.com with SMTP id x25so1354937edr.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=av6R9ayZL9WdcrzKT4i7dDrzpzLAavW93Q2B21s9tcY=;
 b=BfEnXo0d7Z1baF9+oRBKAs9KEof9MHEZ7/y80p6QSuZJu5Zh+BFUgkVoiRNB4EYdib
 p9WaKZI9UZQ+kD38vgsoAEUpza0AcAOkoQJLb5rh1wwcMS1U6wX0tl28IFHSJQpnsgHw
 Gd1p5X11uSIF7L8+d3jG76hY0YgFGzr0E0IcoQ60c16+UGqNeebTvSFczVHMzwlv/dOc
 6ASJPwHkM5nV8sftH8xosOqwaWqmTHC3KFbJlabqw/3lkKWNMmKj3eMfdhS/S0SDhTEC
 E/q7/bveB0YyXx360Hu1gM/U4e59qYCux50RKkpgCv+4MHQhO+OBSmlXd0rbDI7gf9Zo
 l2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=av6R9ayZL9WdcrzKT4i7dDrzpzLAavW93Q2B21s9tcY=;
 b=ucv9W2dH+UAFaZUZ4gCtLHqQujYbK6JFMeyhzP9ChS2gnnOb55otmLl57NEU7EFVgJ
 Hxs72iBdqfLFMIMKMzzITuoO0SB/zm1rRgrV3pDkkyICX9g43YzYat1HklxvWc6iBf2F
 NCfBqGU0Eu/OhVl2iYpqDp2yjZ+AHtugwxibgSe+SpfLD/KsWNqMuavO69Cs9m4UVhaP
 zld3ErBgg7eH7iLs7iDoSahswWgNMZGRDCYJbkmcDfhi89K8O2fxqzWw8r6j5KW3eQQS
 WHHHBAWCyHsKilCrhOTp4K+56Bu82vr946/CT9QuvmHIMtX/+fmjotJ8P6KdIFl09CE5
 JQkQ==
X-Gm-Message-State: AOAM530zTBBcmKU7AJTq+jsvbVlp5hfK2/TWUuOMyz91JQS+s0XWJRgp
 Sdahl3NqrPe7iS+B/ak2Ydqecw==
X-Google-Smtp-Source: ABdhPJy3xuZs1U5Ls/m/syrAr+vGniAvtAcRou4mYHrR9rpL+etsCebvwJ1mxsWCwTwrYznKIP330Q==
X-Received: by 2002:aa7:de08:: with SMTP id h8mr6177790edv.164.1592385543933; 
 Wed, 17 Jun 2020 02:19:03 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id o27sm12927210ejc.95.2020.06.17.02.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 02:19:03 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:18:53 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v3 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
Message-ID: <20200617091853.GC871763@myrica>
References: <20200611151209.22547-1-eric.auger@redhat.com>
 <20200611151209.22547-6-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611151209.22547-6-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=jean-philippe@linaro.org; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 11, 2020 at 05:12:09PM +0200, Eric Auger wrote:
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

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
> v2 -> v3:
> - Add a new value to VirtMSIControllerType
> 
> v1 -> v2:
> - Test which MSI controller is instantiated
> - If GICV2M is in use, declare its doorbell as an MSI doorbell too
> ---
>  include/hw/arm/virt.h |  7 +++++++
>  hw/arm/virt.c         | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
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
> index 37462a6f78..451b150459 100644
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
> @@ -2149,8 +2151,24 @@ out:
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
> +        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
> +            /* GITS_TRANSLATER page */
> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +            qdev_prop_set_string(dev, "reserved-regions[0]",
> +                                 "0x8090000, 0x809FFFF, 1");
> +        } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
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

