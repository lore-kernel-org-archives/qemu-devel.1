Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350FDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3C020767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fya4NOVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3C020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn7i-0000aT-ME
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn6f-0007Pm-6v
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:08:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53936
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn6d-0005kN-7t
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nG2s8AHRR5bOS7oq0qn6KiPTbjmIW7pPorQg3LvZR9Y=;
 b=Fya4NOVBqHni9RbjXTu+Luz/CmD0rJXpRhX4VnJ1e6ilEr2NYNDEVVxPdlvd9Q/KZpOq1w
 nVcnaOxu32p2u6YFxxBGxZMEzXrKufV7GS6fWp047g6uu1KISs5eY5u5jLBNeMTFQruQyX
 oi2CRjFhZgXi82TUuNq38dW9CY9srzM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-TAfBhA8uNW2K7lJjIAf0Wg-1; Thu, 03 Sep 2020 07:08:36 -0400
X-MC-Unique: TAfBhA8uNW2K7lJjIAf0Wg-1
Received: by mail-wm1-f69.google.com with SMTP id b73so854408wmb.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nG2s8AHRR5bOS7oq0qn6KiPTbjmIW7pPorQg3LvZR9Y=;
 b=F6idu2v5BXvBP9ehA0YpNKYAJ484j2NPoO2sn97PIDqaLESXGjYBRnSiPl8bYnfdWE
 PAM3+I/lWxoax7snI8R1dOUCvBOELbcQA2+GecQsqvDY7oIuLGsEZiJwdX+ZmtYiqMsn
 Rwjjc8pj7dlYuVmOjkBRyxhmI+DaBS0TNI8pNL1wCjxtYrnKD37tmbzM+S8bQWw079Sq
 N1869aMoM0aWQhoH1U/7cma2Sixmbptw+IUAGkROpSv96tGpzMoroEjCedkr/Fo1q8Ky
 Uc7VEzvECXBajAzgQrZ7KKQ1jeLA/VIEM1FRmjXs1Qb+DL4kx/jaC2JRJICEYci3134G
 ZcBQ==
X-Gm-Message-State: AOAM533d/8J2ZN5bpWXUjuc7sMaCji8qNBblg0W9rHsgjT8/tVEYHjro
 pUA8LBUmE53Ty9wrJUNqdaAUHwV+4XWMU3Qv7LTl0hNeDQ6RwODAnn8/8VXVDJaqBlc596r3dPy
 A+S9/OUcHAz8NDmA=
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr1934893wrw.426.1599131315166; 
 Thu, 03 Sep 2020 04:08:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuV7U8H91eTm8NU7JOPlHJRzJwjZZhmOcLlLKGufYuyRv1dJCaqT2C+ccL55hEqQRhRPKwKg==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr1934826wrw.426.1599131314768; 
 Thu, 03 Sep 2020 04:08:34 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g18sm4113486wru.27.2020.09.03.04.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:08:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
Date: Thu,  3 Sep 2020 13:08:19 +0200
Message-Id: <20200903110831.353476-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I'm not suppose to work on this but I couldn't sleep so kept
wondering about this problem the whole night and eventually
woke up to write this quickly, so comments are scarce, sorry.

The first part is obvious anyway, simply pass MemTxAttrs argument.

The main patch is:
"exec/memattrs: Introduce MemTxAttrs::direct_access field".
This way we can restrict accesses to ROM/RAM by setting the
'direct_access' field. Illegal accesses return MEMTX_BUS_ERROR.

Next patch restrict PCI DMA accesses by setting the direct_access
field.

Finally we add an assertion for any DMA write access to indirect
memory to kill a class of bug recently found by Alexander while
fuzzing.

Regards,

Phil.

Klaus Jensen (1):
  pci: pass along the return value of dma_memory_rw

Philippe Mathieu-Daudé (11):
  dma: Let dma_memory_valid() take MemTxAttrs argument
  dma: Let dma_memory_set() take MemTxAttrs argument
  dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
  dma: Let dma_memory_rw() take MemTxAttrs argument
  dma: Let dma_memory_read/write() take MemTxAttrs argument
  dma: Let dma_memory_map() take MemTxAttrs argument
  docs/devel/loads-stores: Add regexp for DMA functions
  dma: Let load/store DMA functions take MemTxAttrs argument
  exec/memattrs: Introduce MemTxAttrs::direct_access field
  hw/pci: Only allow PCI slave devices to write to direct memory
  dma: Assert when device writes to indirect memory (such MMIO regions)

 docs/devel/loads-stores.rst   |  2 ++
 include/exec/memattrs.h       |  3 ++
 include/hw/pci/pci.h          | 21 ++++++++++---
 include/hw/ppc/spapr_vio.h    | 26 +++++++++------
 include/sysemu/dma.h          | 59 +++++++++++++++++++++--------------
 dma-helpers.c                 | 12 ++++---
 exec.c                        |  8 +++++
 hw/arm/musicpal.c             | 13 ++++----
 hw/arm/smmu-common.c          |  3 +-
 hw/arm/smmuv3.c               | 14 ++++++---
 hw/core/generic-loader.c      |  3 +-
 hw/display/virtio-gpu.c       |  8 +++--
 hw/dma/pl330.c                | 12 ++++---
 hw/dma/sparc32_dma.c          | 16 ++++++----
 hw/dma/xlnx-zynq-devcfg.c     |  6 ++--
 hw/dma/xlnx_dpdma.c           | 10 +++---
 hw/hyperv/vmbus.c             |  8 +++--
 hw/i386/amd_iommu.c           | 16 +++++-----
 hw/i386/intel_iommu.c         | 28 ++++++++++-------
 hw/ide/ahci.c                 |  9 ++++--
 hw/ide/macio.c                |  2 +-
 hw/intc/pnv_xive.c            |  7 +++--
 hw/intc/spapr_xive.c          |  3 +-
 hw/intc/xive.c                |  7 +++--
 hw/misc/bcm2835_property.c    |  3 +-
 hw/misc/macio/mac_dbdma.c     | 10 +++---
 hw/net/allwinner-sun8i-emac.c | 21 ++++++++-----
 hw/net/ftgmac100.c            | 25 +++++++++------
 hw/net/imx_fec.c              | 32 ++++++++++++-------
 hw/nvram/fw_cfg.c             | 16 ++++++----
 hw/pci-host/pnv_phb3.c        |  5 +--
 hw/pci-host/pnv_phb3_msi.c    |  9 ++++--
 hw/pci-host/pnv_phb4.c        |  7 +++--
 hw/sd/allwinner-sdhost.c      | 14 +++++----
 hw/sd/sdhci.c                 | 35 +++++++++++++--------
 hw/usb/hcd-dwc2.c             |  8 ++---
 hw/usb/hcd-ehci.c             |  6 ++--
 hw/usb/hcd-ohci.c             | 28 ++++++++++-------
 hw/usb/libhw.c                |  3 +-
 hw/virtio/virtio.c            |  6 ++--
 trace-events                  |  1 +
 41 files changed, 334 insertions(+), 191 deletions(-)

-- 
2.26.2


