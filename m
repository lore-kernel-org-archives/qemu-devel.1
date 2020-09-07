Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF52C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCA6206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 06:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL5p/AcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCA6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFB5m-0005Or-Dh
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 02:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kFB4D-000306-AI; Mon, 07 Sep 2020 02:55:53 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kFB4B-0006ys-Pz; Mon, 07 Sep 2020 02:55:53 -0400
Received: by mail-lj1-x241.google.com with SMTP id u21so4534974ljl.6;
 Sun, 06 Sep 2020 23:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gNVbujbP6MQjPSDILsNbSrJDUNfYd9Ct/2Hk5mIgR9Y=;
 b=QL5p/AcAo5anMjK+BH6HF1rLkxqg34d1n93AbMB8M31PBp2LidT58ouf4kk1J4uJP5
 8fXlOOhHcV2krwCcw2JFArFJFdp0ZCOtRm0RgAPljb91RqlFfqOrBs9kUASXk9ZWsrUF
 GF98GC52PXMNRzXl67y4nmOj2fK5rU8mjeN3pfn36hjnDmgf6YhNx9aAgkc3q0r4tVlw
 e/9o2zhmUTuosJcUGbjV3d5lt+vgKvWSfRbh4rVVxIVcmbLMxUt3LN70KregRyVP2ZBP
 U+ZOpChnzHadypwDPLInAgTmNbCtZoQQ8uPish7ugctuZYc1Tg5pvB7WtcHjfof0pLNZ
 IZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gNVbujbP6MQjPSDILsNbSrJDUNfYd9Ct/2Hk5mIgR9Y=;
 b=mGqpLWvHYKODJvEgXGMQ9HscVo9Fuq8PTJY9J6yOWSIWoTgeiP+pZt0/OwjUFoCBuj
 mDyWo8CiMAG3xG9IQSG5hCsxckBdKcNIxYWCaFGLW3o4BG9IpyjhJNN4GEUrM+MNW4rK
 UN224Faz4gfTUfdGHquF11+resK/XER3kB+PCthvEdW+mQeTgSJgdoUq3orhhEHQlG7d
 /wAkUMnc1EAiC3zBilvp6isC3posT+z2YlI+57YJeh05CK8Qb0qrubgR+HnbfhpE3Q8v
 KsXMBy5GkE5v9NZbUdajk86+LNTn/HgXDYMsaTam2nh/2iQJt2Na7da7VtrFMVMmLRZf
 nmsA==
X-Gm-Message-State: AOAM532aRa2amQl4Te+l6oNGSHkoP2sjGPD9CYIvZZI/to3dN1WxpvXC
 kX0dbLXA7Ma5ICLwEtNf1s0=
X-Google-Smtp-Source: ABdhPJzoJkkXMEsQ5garROVu+Z1xlQ0JNGX+AXcDrADg/PFWTlDnEowyXz01XPC7b3Q0KtTTZNI8ww==
X-Received: by 2002:a2e:99c7:: with SMTP id l7mr9684995ljj.425.1599461748881; 
 Sun, 06 Sep 2020 23:55:48 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a27sm6253213ljp.7.2020.09.06.23.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 23:55:47 -0700 (PDT)
Date: Mon, 7 Sep 2020 08:55:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 00/13] dma: Let the DMA API take MemTxAttrs argument and
 propagate MemTxResult
Message-ID: <20200907065547.GZ2954729@toto>
References: <20200904154439.643272-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904154439.643272-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=2.633, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 05:44:26PM +0200, Philippe Mathieu-Daudé wrote:
> Salvaging cleanups patches from the RFC series "Forbid DMA write
> accesses to MMIO regions" [*], propagating MemTxResult and
> adding documentation.
> 
> [*] https://www.mail-archive.com/qemu-block@nongnu.org/msg72924.html

On the whole series:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Klaus Jensen (1):
>   pci: pass along the return value of dma_memory_rw
> 
> Philippe Mathieu-Daudé (12):
>   docs/devel/loads-stores: Add regexp for DMA functions
>   dma: Document address_space_map/address_space_unmap() prototypes
>   dma: Let dma_memory_set() propagate MemTxResult
>   dma: Let dma_memory_rw() propagate MemTxResult
>   dma: Let dma_memory_read() propagate MemTxResult
>   dma: Let dma_memory_write() propagate MemTxResult
>   dma: Let dma_memory_valid() take MemTxAttrs argument
>   dma: Let dma_memory_set() take MemTxAttrs argument
>   dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
>   dma: Let dma_memory_rw() take MemTxAttrs argument
>   dma: Let dma_memory_read/write() take MemTxAttrs argument
>   dma: Let dma_memory_map() take MemTxAttrs argument
> 
>  docs/devel/loads-stores.rst   |   2 +
>  include/hw/pci/pci.h          |   7 +-
>  include/hw/ppc/spapr_vio.h    |  11 ++-
>  include/sysemu/dma.h          | 156 +++++++++++++++++++++++++++-------
>  dma-helpers.c                 |  16 ++--
>  hw/arm/musicpal.c             |  13 +--
>  hw/arm/smmu-common.c          |   3 +-
>  hw/arm/smmuv3.c               |  14 +--
>  hw/core/generic-loader.c      |   3 +-
>  hw/display/virtio-gpu.c       |   8 +-
>  hw/dma/pl330.c                |  12 ++-
>  hw/dma/sparc32_dma.c          |  16 ++--
>  hw/dma/xlnx-zynq-devcfg.c     |   6 +-
>  hw/dma/xlnx_dpdma.c           |  10 ++-
>  hw/hyperv/vmbus.c             |   8 +-
>  hw/i386/amd_iommu.c           |  16 ++--
>  hw/i386/intel_iommu.c         |  28 +++---
>  hw/ide/ahci.c                 |   9 +-
>  hw/ide/macio.c                |   2 +-
>  hw/intc/spapr_xive.c          |   3 +-
>  hw/intc/xive.c                |   7 +-
>  hw/misc/bcm2835_property.c    |   3 +-
>  hw/misc/macio/mac_dbdma.c     |  10 ++-
>  hw/net/allwinner-sun8i-emac.c |  21 +++--
>  hw/net/ftgmac100.c            |  25 ++++--
>  hw/net/imx_fec.c              |  32 ++++---
>  hw/nvram/fw_cfg.c             |  12 ++-
>  hw/pci-host/pnv_phb3.c        |   5 +-
>  hw/pci-host/pnv_phb3_msi.c    |   9 +-
>  hw/pci-host/pnv_phb4.c        |   7 +-
>  hw/sd/allwinner-sdhost.c      |  14 +--
>  hw/sd/sdhci.c                 |  35 +++++---
>  hw/usb/hcd-dwc2.c             |   8 +-
>  hw/usb/hcd-ehci.c             |   6 +-
>  hw/usb/hcd-ohci.c             |  28 +++---
>  hw/usb/libhw.c                |   3 +-
>  hw/virtio/virtio.c            |   6 +-
>  37 files changed, 385 insertions(+), 189 deletions(-)
> 
> -- 
> 2.26.2
> 

