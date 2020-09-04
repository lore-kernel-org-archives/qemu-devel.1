Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0341EC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBCE206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBCE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEYl-00082i-K2
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXy-0006jA-4N
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXw-0006E2-KF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:41 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-_HiUvyFyNJqDWPlxJn9QwA-1; Fri, 04 Sep 2020 12:26:38 -0400
X-MC-Unique: _HiUvyFyNJqDWPlxJn9QwA-1
Received: by mail-wm1-f69.google.com with SMTP id m25so2380826wmi.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GdvdfUi8dGdv0X8iaMX8T8wTAWC4cqEFs01+jCQjKC4=;
 b=X1Zp5ZCV8LuVeJVYK5RRjddLJDgoIe8z8CucacXLSopZseeh9K//I46Bn8DCHSnMdI
 nDzAp9VqSOc3HyHOWnXHJ1VldzXWugm/BVhF7H+P1HmPC2lkaM6SiogELDWnUsRe2EXY
 RzyW4HVMPUz+zPcaSTPYES3f9D/6F6E0TNqIMXKdsTSdvymVpIZ3GGOR9dBvU50AmoxY
 Zg0ye6idfTvce8lXOv2RLk92muDp51oENf1a8Ij+hA7w1mC5+PnTIReuODILa5FqMkYH
 ZVZPSLq3Q8BxhvL2NXLOuN1qTjOcjbzq6N1Q7/zNIAIxPOYbYWad6l3/cPIfQJD2Sg8o
 xgKQ==
X-Gm-Message-State: AOAM532yDsAgYsJqOp2FjCx48zDuJxS6lng1X9l/n+mXZbYgSGigWr20
 9g6bFzrAGwgLtvIf2B33Ji0pg02CdBzDYZkalNEe32mE+X+sczD9zDOyeqon/MRX3YbyWiI1AVt
 66csM7jUVqLGli30=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr5323041wmc.154.1599236796732; 
 Fri, 04 Sep 2020 09:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Qj9qQ2RsQJL+8y+3agMRElI17bTJ7XjUIbySjwHTCX/9+uTnZDOkfoFuyP6BiiHl1SuKXQ==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr5323027wmc.154.1599236796567; 
 Fri, 04 Sep 2020 09:26:36 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 189sm12479473wmb.3.2020.09.04.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:26:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] pci: Let pci_dma_write() propagate MemTxResult
Date: Fri,  4 Sep 2020 18:26:20 +0200
Message-Id: <20200904162620.657726-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904162620.657726-1-philmd@redhat.com>
References: <20200904162620.657726-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pci_dma_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index bb57525dffd..76826e240a9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -824,8 +824,20 @@ static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
     return pci_dma_rw(dev, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int pci_dma_write(PCIDevice *dev, dma_addr_t addr,
-                                const void *buf, dma_addr_t len)
+/**
+ * pci_dma_write: Write to address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
+                                        const void *buf, dma_addr_t len)
 {
     return pci_dma_rw(dev, addr, (void *) buf, len, DMA_DIRECTION_FROM_DEVICE);
 }
-- 
2.26.2


