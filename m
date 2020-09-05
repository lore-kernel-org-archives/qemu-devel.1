Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B99C433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 02:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD5C20791
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 02:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfFEjNWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD5C20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kENwQ-00035W-MV
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 22:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kENvi-0002N5-Aq; Fri, 04 Sep 2020 22:27:50 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kENvg-0007Dv-Aq; Fri, 04 Sep 2020 22:27:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id y5so7625731otg.5;
 Fri, 04 Sep 2020 19:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pIqXPWzEOKzHDs5Nz4uO72iaOnUBj32g/mhjpRg5X1s=;
 b=hfFEjNWKlFLJtGdaxxk+EZG083glFXdLxawR+KLw87Oc6Alrummb74EOLtSnuCFmhn
 n9r/uUMYmTpcByVES5pCb5Ax4OevlDBR8jhMxSx0BEmmeWqrLMKdVI6wx9QL2PUgchuX
 Ji+8ii8mzCLgepfXYDkwZ2bYcFyaNp2ipD2fU1VAjCOhAMD4Zi+Huw8oB+9yNgEWeiXf
 gvssBKcSJlMzFoWgKl3D579KJLOZZewitERbNcaU0UCcC1CG0QcbLAuyseo4C11LXGvX
 fEHuYw+jCIecJkuBvDbcqXPs4VLz9RrNQ4OQ4bUWzOb6NIOus8OyXZ2NoKngofpdk1bR
 b+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pIqXPWzEOKzHDs5Nz4uO72iaOnUBj32g/mhjpRg5X1s=;
 b=q8m+rSetlcVV3V+iEIutU0/rVExdom87jMucz/KQ67eZF2hg/JMmBB4Mp6j2fKN70D
 O1yqH6/SSSqurgUHS8Z138M13QeeYYUFdME2cKW4tnS5M9dqlZ7HVXLlQNW7YjOdqD7H
 uXXQ+ViQVJ2wCHB+BGzt2qgUvVX4VrDOsO7GZqEWEeyy+kfhey3RE+dDRitWyXmJo502
 Cx3hTsDx2ohak413X0f3R/A238kXtVypmOzrpCNlnfoCo58/N0M0k3u/MgUXYBqDqaKm
 MGOusde41PFHO1i820Rlp7M+/eAFoWLCwi/sWmQ60NvjobaS1D0f+vq50kMHqyY0nU/o
 7SUQ==
X-Gm-Message-State: AOAM53190wZaQoWEJO2d0qE4EZKbEP7bF7oWqxY/Nda/uz5eId8XizYE
 4CDHJuoQj7U6pQRbrLX1F8YSTv7fGLuHbwVzPOo=
X-Google-Smtp-Source: ABdhPJwSr5PKD8p+5oE6O0whUEARoFPT5PKeg28fine29GuaRThlkvLtzAIvbWxRP9Eb0P7j5kpQ4ZL7oJ7gIQniL+A=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr7313290ote.181.1599272866075; 
 Fri, 04 Sep 2020 19:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200903110831.353476-1-philmd@redhat.com>
In-Reply-To: <20200903110831.353476-1-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 5 Sep 2020 10:27:09 +0800
Message-ID: <CAKXe6S+v4z_PYbZ6MMzEZk7Q0Qc+q9tzL+a8918U_-XR=aj7RA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Qemu Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Laszlo Ersek <lersek@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Tony Nguyen <tony.nguyen@bt.com>, Prasad J Pandit <pjp@fedoraproject.org>,
 Alexander Bulekov <alxndr@bu.edu>, Andrew Jeffery <andrew@aj.id.au>,
 Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=883=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:09=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> I'm not suppose to work on this but I couldn't sleep so kept
> wondering about this problem the whole night and eventually
> woke up to write this quickly, so comments are scarce, sorry.
>
> The first part is obvious anyway, simply pass MemTxAttrs argument.
>
> The main patch is:
> "exec/memattrs: Introduce MemTxAttrs::direct_access field".
> This way we can restrict accesses to ROM/RAM by setting the
> 'direct_access' field. Illegal accesses return MEMTX_BUS_ERROR.
>
> Next patch restrict PCI DMA accesses by setting the direct_access
> field.
>
> Finally we add an assertion for any DMA write access to indirect
> memory to kill a class of bug recently found by Alexander while
> fuzzing.
>

Hi Philippe,

I have reviewed your patches.
Your patch just deny the DMA write to MMIO for PCI device.

1. The DMA write to MMIO is allowed for P2P. Unconditionally deny
is not right I think. Maybe we can add some flag for the device as property
so the device can indicate whether it supports DMA to MMIO.
But this method needs define we should apply the restrict to
DMA to MMIO initiator or target. If the target, we need to find the
target PCI device.

2. I think the MMIO read maybe also suffers the reentrant issue If the
MMIO read handler
does complicated work.

3. As your patch just consider the PCI case. This reentrant is quite
complicated if we consider
the no-PCI the qemu_irq cases. I agree to address the PCI cases first.

Thanks,
Li Qiang



> Regards,
>
> Phil.
>
> Klaus Jensen (1):
>   pci: pass along the return value of dma_memory_rw
>
> Philippe Mathieu-Daud=C3=A9 (11):
>   dma: Let dma_memory_valid() take MemTxAttrs argument
>   dma: Let dma_memory_set() take MemTxAttrs argument
>   dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
>   dma: Let dma_memory_rw() take MemTxAttrs argument
>   dma: Let dma_memory_read/write() take MemTxAttrs argument
>   dma: Let dma_memory_map() take MemTxAttrs argument
>   docs/devel/loads-stores: Add regexp for DMA functions
>   dma: Let load/store DMA functions take MemTxAttrs argument
>   exec/memattrs: Introduce MemTxAttrs::direct_access field
>   hw/pci: Only allow PCI slave devices to write to direct memory
>   dma: Assert when device writes to indirect memory (such MMIO regions)
>
>  docs/devel/loads-stores.rst   |  2 ++
>  include/exec/memattrs.h       |  3 ++
>  include/hw/pci/pci.h          | 21 ++++++++++---
>  include/hw/ppc/spapr_vio.h    | 26 +++++++++------
>  include/sysemu/dma.h          | 59 +++++++++++++++++++++--------------
>  dma-helpers.c                 | 12 ++++---
>  exec.c                        |  8 +++++
>  hw/arm/musicpal.c             | 13 ++++----
>  hw/arm/smmu-common.c          |  3 +-
>  hw/arm/smmuv3.c               | 14 ++++++---
>  hw/core/generic-loader.c      |  3 +-
>  hw/display/virtio-gpu.c       |  8 +++--
>  hw/dma/pl330.c                | 12 ++++---
>  hw/dma/sparc32_dma.c          | 16 ++++++----
>  hw/dma/xlnx-zynq-devcfg.c     |  6 ++--
>  hw/dma/xlnx_dpdma.c           | 10 +++---
>  hw/hyperv/vmbus.c             |  8 +++--
>  hw/i386/amd_iommu.c           | 16 +++++-----
>  hw/i386/intel_iommu.c         | 28 ++++++++++-------
>  hw/ide/ahci.c                 |  9 ++++--
>  hw/ide/macio.c                |  2 +-
>  hw/intc/pnv_xive.c            |  7 +++--
>  hw/intc/spapr_xive.c          |  3 +-
>  hw/intc/xive.c                |  7 +++--
>  hw/misc/bcm2835_property.c    |  3 +-
>  hw/misc/macio/mac_dbdma.c     | 10 +++---
>  hw/net/allwinner-sun8i-emac.c | 21 ++++++++-----
>  hw/net/ftgmac100.c            | 25 +++++++++------
>  hw/net/imx_fec.c              | 32 ++++++++++++-------
>  hw/nvram/fw_cfg.c             | 16 ++++++----
>  hw/pci-host/pnv_phb3.c        |  5 +--
>  hw/pci-host/pnv_phb3_msi.c    |  9 ++++--
>  hw/pci-host/pnv_phb4.c        |  7 +++--
>  hw/sd/allwinner-sdhost.c      | 14 +++++----
>  hw/sd/sdhci.c                 | 35 +++++++++++++--------
>  hw/usb/hcd-dwc2.c             |  8 ++---
>  hw/usb/hcd-ehci.c             |  6 ++--
>  hw/usb/hcd-ohci.c             | 28 ++++++++++-------
>  hw/usb/libhw.c                |  3 +-
>  hw/virtio/virtio.c            |  6 ++--
>  trace-events                  |  1 +
>  41 files changed, 334 insertions(+), 191 deletions(-)
>
> --
> 2.26.2
>
>

