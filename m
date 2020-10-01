Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B9C47425
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36E2208C7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4ojbtCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36E2208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Ms-0006Wt-Li
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Kh-0003zb-5h
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Ke-00048r-Ik
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lv4WLDxnJrkoZQBcscmISvfcvYSoSChdT3SRgd724Yc=;
 b=S4ojbtCH8mNjvGd0GJfZ/lsLtAqoTcgR9i7glepWy0NggzZ9Yd3NGs4oDkgN6KoZ96njeG
 5bVR5FLqOvixURyvd9a5yxmzR0T7munii/rDODIhSX1cnFEwsInesyTaDqGdNrrjWOTO+i
 AJLFqBVwQjQjA+ANlGJwG0wEgo1o8Oo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-MXJyYmrfOgesPyWk9BAuow-1; Thu, 01 Oct 2020 13:25:23 -0400
X-MC-Unique: MXJyYmrfOgesPyWk9BAuow-1
Received: by mail-wr1-f70.google.com with SMTP id b7so2333622wrn.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lv4WLDxnJrkoZQBcscmISvfcvYSoSChdT3SRgd724Yc=;
 b=oRc3WWV085/dTPRPdlXmgbsFhDt+1lDHXr98W0IPoM425a36DqjFwlGZL9WPSDg/X9
 HOqi4T93XW46LdWYHIGHrhfhJwlU3CVSvkW6FUYGIpE+4sv9z5cewyUxHXLKpY1fUnHC
 aRE2XeQvJ5w+xTMb1c3q8AHrAg7Yn3kmKQwwag3Tr1qC7Fvth0/+M99jwa205hj/tgrH
 cTSZxRTYwdi2b+jomzaexdjuCJe40fGRW3fj/BaWXHkK5rWU0eqHPn8yY7vuHkHVNbJT
 bOE/cyxavhtXnvAhH2ONF0YtpwHukYv7ypf6y2ohdEaRGUSfu0ZHAjl37/w49dcCBHbl
 SGiw==
X-Gm-Message-State: AOAM531CEbu3uTL0r2fMFgc9MhCWKb671UXpFQXWtJja3V1j0kfnq1SP
 TKSEDobMbVF1fKwvI6hLIB/5GFu+GePS4V8F2QRDs11cVvA1PYHqxe7Up78MKrYtMUqSWsfIddw
 zeM36iDgwt6s9/Y8=
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr1095969wmt.189.1601573121843; 
 Thu, 01 Oct 2020 10:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8EiCPF2RTHwLfVIznuGhrjHqtAqJ6D72AoU53KJgHIX7ZN7MXBehfvtde1YgEg4frs25cuw==
X-Received: by 2002:a1c:2d86:: with SMTP id t128mr1095952wmt.189.1601573121638; 
 Thu, 01 Oct 2020 10:25:21 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a15sm10873449wrn.3.2020.10.01.10.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:25:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 00/16] hw: Let DMA/PCI API take MemTxAttrs argument
 and propagate MemTxResult
Date: Thu,  1 Oct 2020 19:25:03 +0200
Message-Id: <20201001172519.1620782-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a respin of:

"dma: Let the DMA API take MemTxAttrs argument and propagate MemTxResult"
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html

and:
"pci: Let PCI DMA API functions propagate a MemTxResult"
https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg02048.html

(resent using correct git-profile).

The DMA API propagates MemTxResult:
- MEMTX_OK,
- MEMTX_device_ERROR,
- MEMTX_DECODE_ERROR.

Let the PCI DMA API propagate them, as they are
clearer than an undocumented 'int'.

Klaus Jensen (1):
  pci: pass along the return value of dma_memory_rw

Philippe Mathieu-Daudé (15):
  docs/devel/loads-stores: Add regexp for DMA functions
  dma: Document address_space_map/address_space_unmap() prototypes
  dma: Let dma_memory_set() propagate MemTxResult
  dma: Let dma_memory_rw() propagate MemTxResult
  dma: Let dma_memory_read() propagate MemTxResult
  dma: Let dma_memory_write() propagate MemTxResult
  dma: Let dma_memory_valid() take MemTxAttrs argument
  dma: Let dma_memory_set() take MemTxAttrs argument
  dma: Let dma_memory_rw_relaxed() take MemTxAttrs argument
  dma: Let dma_memory_rw() take MemTxAttrs argument
  dma: Let dma_memory_read/write() take MemTxAttrs argument
  dma: Let dma_memory_map() take MemTxAttrs argument
  pci: Let pci_dma_rw() propagate MemTxResult
  pci: Let pci_dma_read() propagate MemTxResult
  pci: Let pci_dma_write() propagate MemTxResult

 docs/devel/loads-stores.rst   |   2 +
 include/hw/pci/pci.h          |  57 +++++++++++--
 include/hw/ppc/spapr_vio.h    |  11 ++-
 include/sysemu/dma.h          | 155 +++++++++++++++++++++++++++-------
 dma-helpers.c                 |  16 ++--
 hw/arm/musicpal.c             |  13 +--
 hw/arm/smmu-common.c          |   3 +-
 hw/arm/smmuv3.c               |  14 +--
 hw/core/generic-loader.c      |   3 +-
 hw/display/virtio-gpu.c       |   8 +-
 hw/dma/pl330.c                |  12 ++-
 hw/dma/sparc32_dma.c          |  16 ++--
 hw/dma/xlnx-zynq-devcfg.c     |   6 +-
 hw/dma/xlnx_dpdma.c           |  10 ++-
 hw/hyperv/vmbus.c             |   8 +-
 hw/i386/amd_iommu.c           |  16 ++--
 hw/i386/intel_iommu.c         |  28 +++---
 hw/ide/ahci.c                 |   9 +-
 hw/ide/macio.c                |   2 +-
 hw/intc/spapr_xive.c          |   3 +-
 hw/intc/xive.c                |   7 +-
 hw/misc/bcm2835_property.c    |   3 +-
 hw/misc/macio/mac_dbdma.c     |  10 ++-
 hw/net/allwinner-sun8i-emac.c |  21 +++--
 hw/net/ftgmac100.c            |  25 ++++--
 hw/net/imx_fec.c              |  32 ++++---
 hw/nvram/fw_cfg.c             |  12 ++-
 hw/pci-host/pnv_phb3.c        |   5 +-
 hw/pci-host/pnv_phb3_msi.c    |   9 +-
 hw/pci-host/pnv_phb4.c        |   7 +-
 hw/sd/allwinner-sdhost.c      |  14 +--
 hw/sd/sdhci.c                 |  35 +++++---
 hw/usb/hcd-dwc2.c             |   8 +-
 hw/usb/hcd-ehci.c             |   6 +-
 hw/usb/hcd-ohci.c             |  28 +++---
 hw/usb/hcd-xhci.c             |  18 ++--
 hw/usb/libhw.c                |   3 +-
 hw/virtio/virtio.c            |   6 +-
 38 files changed, 439 insertions(+), 202 deletions(-)

-- 
2.26.2


