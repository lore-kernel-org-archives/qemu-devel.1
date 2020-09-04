Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB94C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80E3A206E7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXEi1kMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E3A206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDvA-0002xX-Ig
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDtS-0000QP-Om
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:44:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31657
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEDtQ-0007Oe-QF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599234287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g1F57r74saSn+8lv2kyxtVMUYEXy6WA3Nk2z6wkeOh8=;
 b=LXEi1kMC6Y58WptiQKOCV6Tlvih/ee8tfLucavCCs8pq8LthFo9ZVFca2Nhs7DxMdlEQpN
 ax0ocbHhZd9WlM/D7FWlNjGtKJmI1u5Niq+6JSOiFgzSDDDHe241Fty5PpgTH4LbZX1Wr3
 Nb6dzabTyJ40pN6PRyuOHvrmyETuhic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-x1wJU3DvNDihi3c9z2R-YQ-1; Fri, 04 Sep 2020 11:44:44 -0400
X-MC-Unique: x1wJU3DvNDihi3c9z2R-YQ-1
Received: by mail-wm1-f70.google.com with SMTP id z1so2342001wmk.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g1F57r74saSn+8lv2kyxtVMUYEXy6WA3Nk2z6wkeOh8=;
 b=CQx93tpFH6lXLKhXvvlX6t4pRdpYxfH++fBCkIxBUzNCngMWhJzBhV/qV7d6YNc7+3
 SAGqFMygtVNm2M0BP3rCo3ijYSRSp1aDz9yZFW94vo1VGg0W4I5D/s1AlcpVEHfeGbay
 uRt29mK7McKi2D6SMx38RSmvczq5nDPTAXbi6Ie9RbTlGBCakhLgYCccMuJcDPW3bGWy
 oMkFctEVLvADokXRBSwE7zI4TQ9rzGeiKWNMS5r33blsG61roDtPswbPWlzRcZwg6VWK
 Hkpdr3yZohHzRofc07FpxfeZPG7CKPXZqvw+sxtgD6If8CfQ0QcojM9wLg9/Bl4n0oRp
 9L8w==
X-Gm-Message-State: AOAM532HSV/wesW7r0nVD+i/YrL6hUQTFEgktwfzIf0D7CBaOjphohEV
 neHD9TxZ7rpVAsogqUXNszw8Rmu65pV+boKt+qoDo/IF5HCSci+gFPvhMEnlmh2hzsfOoLSXIfa
 8WyQvRy+V1A0cy+Q=
X-Received: by 2002:adf:e407:: with SMTP id g7mr8122161wrm.349.1599234283017; 
 Fri, 04 Sep 2020 08:44:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+ut36PUobyCYkj6dPdh3OXABSVf0r43fgGRQ77pHeTQnD+Wt+1Dnx6EgHfLprRaracwSz4Q==
X-Received: by 2002:adf:e407:: with SMTP id g7mr8122128wrm.349.1599234282832; 
 Fri, 04 Sep 2020 08:44:42 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v2sm13178874wrn.44.2020.09.04.08.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:44:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 00/13] dma: Let the DMA API take MemTxAttrs argument and
 propagate MemTxResult
Date: Fri,  4 Sep 2020 17:44:26 +0200
Message-Id: <20200904154439.643272-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Salvaging cleanups patches from the RFC series "Forbid DMA write
accesses to MMIO regions" [*], propagating MemTxResult and
adding documentation.

[*] https://www.mail-archive.com/qemu-block@nongnu.org/msg72924.html

Klaus Jensen (1):
  pci: pass along the return value of dma_memory_rw

Philippe Mathieu-Daudé (12):
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

 docs/devel/loads-stores.rst   |   2 +
 include/hw/pci/pci.h          |   7 +-
 include/hw/ppc/spapr_vio.h    |  11 ++-
 include/sysemu/dma.h          | 156 +++++++++++++++++++++++++++-------
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
 hw/usb/libhw.c                |   3 +-
 hw/virtio/virtio.c            |   6 +-
 37 files changed, 385 insertions(+), 189 deletions(-)

-- 
2.26.2


