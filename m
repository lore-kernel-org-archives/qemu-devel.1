Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF7DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEFD20795
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFD20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEYZ-0007Xy-01
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXo-0006TW-W2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEEXn-000699-DU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:26:32 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-4OPIJM8qNEy0AEx2SmMTzA-1; Fri, 04 Sep 2020 12:26:28 -0400
X-MC-Unique: 4OPIJM8qNEy0AEx2SmMTzA-1
Received: by mail-wm1-f71.google.com with SMTP id k12so3542771wmj.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wXvwYiip7p7tr6VahU3IzlJqr2MIhqKzvAFhb09t7Wc=;
 b=g+rMUnwQfaHsY17Lcg5NSk/+gAwJUR63f85QgjSL4p4yTeoA3sJr5Quubr7+qJ7X+h
 5PbWYyMjU+kzf4ghYthTDS0/fNgqPiMwlEQfSiF7UOk0Y/Owr3r7qKSUlu0RIO00LsVm
 uOmVyyQtj7HXyjm2rlEuigtM+H16dQV1WVhkuUm0wMWKw1JIOg+mgWxJE7dIFXOiaHtj
 tCWHR9r2kQV5j7zu+8FIxwAExv16lFtQQeg+zWHYMMlDWNXcf4KCzeLO1RRaiSFK4qf5
 OPVcYNApQOlnY4ntApENeaNVqP+FejkwgfBS08dxAcIG0Xa4KF4oQSnBrkm/jqxO7WLo
 F27A==
X-Gm-Message-State: AOAM531uzWXxbl2RV1JMZoXbqwus84oQqF/zplLDB3CEcDfT9XeBKLO3
 1QEnqbGh1jRioJ01lObXoNXYrQKb0HGVOj1dSLsKqH4LhxZTDq28fCJ33ttT4UaNFdU3sT/iRsD
 7RM+5Q9WMWDDTuNg=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr8263695wmn.27.1599236787558; 
 Fri, 04 Sep 2020 09:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUsp0xJqmCy006SprbsF9JgUATGpxhSGRLPQa/+NYA5r3qfG6M5mpK4u3M+q/ff54XBgFZxg==
X-Received: by 2002:a1c:2781:: with SMTP id n123mr8263670wmn.27.1599236787342; 
 Fri, 04 Sep 2020 09:26:27 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id d6sm12157101wrq.67.2020.09.04.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 09:26:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] pci: Let pci_dma_rw() propagate MemTxResult
Date: Fri,  4 Sep 2020 18:26:18 +0200
Message-Id: <20200904162620.657726-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904162620.657726-1-philmd@redhat.com>
References: <20200904162620.657726-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
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

dma_memory_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a221dfb3b08..a85b0bc3c44 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -785,8 +785,22 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
     return &dev->bus_master_as;
 }
 
-static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
-                             void *buf, dma_addr_t len, DMADirection dir)
+/**
+ * pci_dma_rw: Read from or write to an address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @dir: indicates the transfer direction
+ */
+static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
+                                     void *buf, dma_addr_t len,
+                                     DMADirection dir)
 {
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
                          dir, MEMTXATTRS_UNSPECIFIED);
-- 
2.26.2


