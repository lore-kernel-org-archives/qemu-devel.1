Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B07C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2FB724182
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmCnD6Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FB724182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbpy-0000K2-TF
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVbpD-0008M1-Hg
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVbpA-0005pw-9Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603377855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itWsw17N9hqvHUQwKhjiGBUQpO08ZxS7rnBjSOLq4fw=;
 b=PmCnD6RbVHO6Tc3kLtfYpogtqlfMW6/H3z+xB7JWG3fQMfa9Qlweo8BZDsV05STJE7LkRr
 p9wsk5r8DinqFRhiY8jfeVHsuh5Tc5I3gtEtaPFI798D4WifuhRVMKNOmFZEobvbmZsQb9
 /D6jjww8c3VCTFJLsZk0s+3eRRT3qbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-T_e08U1FNdOvg3P8GGgf7A-1; Thu, 22 Oct 2020 10:44:13 -0400
X-MC-Unique: T_e08U1FNdOvg3P8GGgf7A-1
Received: by mail-wr1-f69.google.com with SMTP id f11so706924wro.15
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 07:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=itWsw17N9hqvHUQwKhjiGBUQpO08ZxS7rnBjSOLq4fw=;
 b=UEQXZxuqSwZviTLvJsMLaJbjeKSEm+Uxtq8dKCL3n5xTEXVcUj0stmfwpw+X7KCJwi
 vaeqBJ9vUrje8kNGatMP4SL3Dkln+vD8lZ8jNStA7+2KQvi2NhtLeO6PQMsHYvVsJ6+0
 6ghjj2PUz+EW4KbB9bSimhnaUbJIIKPEmL7nOACfget+T8TaZ6wh9dOD//u6Ur20NRLc
 aUqX4JUdlbhDAK+XhZ2xBnJwQXn08GPLZbhoMUI36B8ejXLoH+PLU4nUS0+BqABppOSm
 J/99PvtpaI2VNHoK+6Xjh+hxmccCsMusSNuRHFYq3ee4OA9Nwm9HyZLLbyz4dN+AIfLB
 MFig==
X-Gm-Message-State: AOAM5338yMAJwoMDNOup13gzaAsZpanAHtp91jMx0PuyqN06HC2qCE9Z
 uAfoUHcLvbrhJVT1wUD9vfRwRzSo/zlZFOdL2r2Ww+dGbinxzBQLdTpMrRQooqAiszGz8YomzVy
 brVl5WCpbXaggpDg=
X-Received: by 2002:adf:f101:: with SMTP id r1mr3335933wro.392.1603377851189; 
 Thu, 22 Oct 2020 07:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF+pcUcuU+blaiVqEJW6QEYQSAB/XfGwN6VuuemYfagvRov3TPn6M98uuAi0WRh0pZKR2n/Q==
X-Received: by 2002:adf:f101:: with SMTP id r1mr3335912wro.392.1603377851013; 
 Thu, 22 Oct 2020 07:44:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z191sm4010258wme.30.2020.10.22.07.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 07:44:10 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 00/16] hw: Let DMA/PCI API take MemTxAttrs
 argument and propagate MemTxResult
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20201001172519.1620782-1-philmd@redhat.com>
Message-ID: <e25101fd-5a14-13ff-6e5b-d46b780a8ca5@redhat.com>
Date: Thu, 22 Oct 2020 16:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201001172519.1620782-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 10/1/20 7:25 PM, Philippe Mathieu-Daudé wrote:
> This is a respin of:
> 
> "dma: Let the DMA API take MemTxAttrs argument and propagate MemTxResult"
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
> 
> and:
> "pci: Let PCI DMA API functions propagate a MemTxResult"
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html
> 
> (resent using correct git-profile).
> 
> The DMA API propagates MemTxResult:
> - MEMTX_OK,
> - MEMTX_device_ERROR,
> - MEMTX_DECODE_ERROR.
> 
> Let the PCI DMA API propagate them, as they are
> clearer than an undocumented 'int'.
> 
> Klaus Jensen (1):
>    pci: pass along the return value of dma_memory_rw
> 
> Philippe Mathieu-Daudé (15):
>    docs/devel/loads-stores: Add regexp for DMA functions
>    dma: Document address_space_map/address_space_unmap() prototypes
>    dma: Let dma_memory_set() propagate MemTxResult
>    dma: Let dma_memory_rw() propagate MemTxResult
>    dma: Let dma_memory_read() propagate MemTxResult
>    dma: Let dma_memory_write() propagate MemTxResult
>    dma: Let dma_memory_valid() take MemTxAttrs argument
>    dma: Let dma_memory_set() take MemTxAttrs argument
>    dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
>    dma: Let dma_memory_rw() take MemTxAttrs argument
>    dma: Let dma_memory_read/write() take MemTxAttrs argument
>    dma: Let dma_memory_map() take MemTxAttrs argument
>    pci: Let pci_dma_rw() propagate MemTxResult
>    pci: Let pci_dma_read() propagate MemTxResult
>    pci: Let pci_dma_write() propagate MemTxResult
> 
>   docs/devel/loads-stores.rst   |   2 +
>   include/hw/pci/pci.h          |  57 +++++++++++--
>   include/hw/ppc/spapr_vio.h    |  11 ++-
>   include/sysemu/dma.h          | 155 +++++++++++++++++++++++++++-------
>   dma-helpers.c                 |  16 ++--
>   hw/arm/musicpal.c             |  13 +--
>   hw/arm/smmu-common.c          |   3 +-
>   hw/arm/smmuv3.c               |  14 +--
>   hw/core/generic-loader.c      |   3 +-
>   hw/display/virtio-gpu.c       |   8 +-
>   hw/dma/pl330.c                |  12 ++-
>   hw/dma/sparc32_dma.c          |  16 ++--
>   hw/dma/xlnx-zynq-devcfg.c     |   6 +-
>   hw/dma/xlnx_dpdma.c           |  10 ++-
>   hw/hyperv/vmbus.c             |   8 +-
>   hw/i386/amd_iommu.c           |  16 ++--
>   hw/i386/intel_iommu.c         |  28 +++---
>   hw/ide/ahci.c                 |   9 +-
>   hw/ide/macio.c                |   2 +-
>   hw/intc/spapr_xive.c          |   3 +-
>   hw/intc/xive.c                |   7 +-
>   hw/misc/bcm2835_property.c    |   3 +-
>   hw/misc/macio/mac_dbdma.c     |  10 ++-
>   hw/net/allwinner-sun8i-emac.c |  21 +++--
>   hw/net/ftgmac100.c            |  25 ++++--
>   hw/net/imx_fec.c              |  32 ++++---
>   hw/nvram/fw_cfg.c             |  12 ++-
>   hw/pci-host/pnv_phb3.c        |   5 +-
>   hw/pci-host/pnv_phb3_msi.c    |   9 +-
>   hw/pci-host/pnv_phb4.c        |   7 +-
>   hw/sd/allwinner-sdhost.c      |  14 +--
>   hw/sd/sdhci.c                 |  35 +++++---
>   hw/usb/hcd-dwc2.c             |   8 +-
>   hw/usb/hcd-ehci.c             |   6 +-
>   hw/usb/hcd-ohci.c             |  28 +++---
>   hw/usb/hcd-xhci.c             |  18 ++--
>   hw/usb/libhw.c                |   3 +-
>   hw/virtio/virtio.c            |   6 +-
>   38 files changed, 439 insertions(+), 202 deletions(-)
> 


