Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0740BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE47206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE47206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEZi-0001ip-GG
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXw-0006fE-15
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25272
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXt-0006CR-Ed
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:39 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-cVJQuMAxMfS4wna-CYfL4Q-1; Fri, 04 Sep 2020 12:26:33 -0400
X-MC-Unique: cVJQuMAxMfS4wna-CYfL4Q-1
Received: by mail-wr1-f69.google.com with SMTP id l9so355558wrq.20
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7MorJJURQDaDxlrOa/frWqZVpJ+3nafUOrcrW8fCBG4=;
 b=QNDpSks5vhsVJaWbwUpqgzWHRL6Q9To3yK5XCW61LzSLw3xRtKrOnrnSBi1QnZ6N11
 Wpw1NAjoL4i3LfBv7lUZMGH30uU9AxQRcZNzMhfLnVLNUHyOF/eO6Xwef4tNktZ/7xfg
 EOY0zxXlsdlJiMlzDY/WoSVglhGNUNzVMKyt7+QJkTosDWJzzBTOoASve6cEnRYvKzYm
 3zY2T3J4d3PAeLkWJH+g+fYiELoCoJ3RG30QJwVCfGeVRFzd2Jkiqp0nJYLbQ5XWlbBF
 NLY2P3Q3sBPyPcV4ukRZUZeTPSrG2lHwd+aERdj9iSjWPNuDQ28vdn/Vl7RXNjgBzHxz
 pCIw==
X-Gm-Message-State: AOAM532MD2Z/MIFcMQM2PW9+lxQ1hslt6JHJmAiAD0/iFNZDMElU2Z5Z
 7ziETMuko7Gh3Yyg+GKIvSPJWrMuSv0IODkHyOTFe1IDZ7114rZuDnR3VAIp4TEWu785uTf4m34
 gKzWJrah9vzKhbdk=
X-Received: by 2002:adf:e481:: with SMTP id i1mr8266608wrm.391.1599236792191; 
 Fri, 04 Sep 2020 09:26:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEmzW5SG4fPJA2/5E/8QGbSX+oqPle12+QfopfydhbnVfctVEgyenq+cJq2upGf1MgIzQ0Mw==
X-Received: by 2002:adf:e481:: with SMTP id i1mr8266589wrm.391.1599236792006; 
 Fri, 04 Sep 2020 09:26:32 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q18sm12412399wre.78.2020.09.04.09.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:26:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] pci: Let pci_dma_read() propagate MemTxResult
Date: Fri,  4 Sep 2020 18:26:19 +0200
Message-Id: <20200904162620.657726-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904162620.657726-1-philmd@redhat.com>
References: <20200904162620.657726-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
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
index a85b0bc3c44..bb57525dffd 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -806,8 +806,20 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                          dir, MEMTXATTRS_UNSPECIFIED);
 }
 
-static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-                               void *buf, dma_addr_t len)
+/**
+ * pci_dma_read: Read from an address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).  Called within RCU critical section.
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
+                                       void *buf, dma_addr_t len)
 {
     return pci_dma_rw(dev, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
-- 
2.26.2


