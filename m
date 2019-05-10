Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D803C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9EF62070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="gvgXbDqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EF62070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8m5-0004wG-25
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:53:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hP8d1-0004c7-KR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hP8cz-0002U4-KH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:44:11 -0400
Received: from m12-13.163.com ([220.181.12.13]:46185)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hP8cw-0002S2-1x
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=bD784GuXCTHvAqf9FL
	z4k1N7zeMg3+JJ22MHAx8bcDQ=; b=gvgXbDqQJ88U/EfOciI8Ua4IWLZPhNd0Ws
	PiNDCS75OV/F8BM7HN3MKYyOoigE6MKf8r01SYMNcJca9oC24nYTPbybMlGWlzwt
	qLqMez8wumAWg7X9wsN7arm1rFQ4jyC055wQJwlMHp2c234AN0DyogFa1YXOxbmu
	93cAp1/oc=
Received: from localhost.localdomain (unknown [183.159.64.133])
	by smtp9 (Coremail) with SMTP id DcCowAB3fTFLqtVcVYWnCg--.3399S5;
	Sat, 11 May 2019 00:44:02 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: pbonzini@redhat.com,
	jslaby@suse.cz
Date: Fri, 10 May 2019 09:43:49 -0700
Message-Id: <20190510164349.81507-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510164349.81507-1-liq3ea@163.com>
References: <20190510164349.81507-1-liq3ea@163.com>
X-CM-TRANSID: DcCowAB3fTFLqtVcVYWnCg--.3399S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF45WF15KFWxury7Xr1UKFg_yoW8ZFW5p3
	45Grn3XF4FgFyfJry5Aw4DXr1rGrn5tF4rK3y8CrsY9ayrXFs7CFyUJ3429rWxW34Ivr13
	uFZYqF43uF4xZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4wZ7UUUUU=
X-Originating-IP: [183.159.64.133]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBKwbVaD0qDHjwAAs0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH v4 3/3] edu: uses uint64_t in dma operation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: liq3ea@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org,
	Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The dma related variable dma.dst/src/cnt is dma_addr_t, it is
uint64_t in x64 platform. Change these usage from uint32_to
uint64_t to avoid trancation in edu_dma_timer.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v3:
Change 'size2' para of 'edu_check_range' to 64-bits.

 hw/misc/edu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 33de05141f..19e5545e2c 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static bool within(uint32_t addr, uint32_t start, uint32_t end)
+static bool within(uint64_t addr, uint64_t start, uint64_t end)
 {
     return start <= addr && addr < end;
 }
 
-static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t start,
-                uint32_t size2)
+static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
+                uint64_t size2)
 {
-    uint32_t end1 = addr + size1;
-    uint32_t end2 = start + size2;
+    uint64_t end1 = addr + size1;
+    uint64_t end2 = start + size2;
 
     if (within(addr, start, end2) &&
             end1 > addr && within(end1, start, end2)) {
         return;
     }
 
-    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds (0x%.8x-0x%.8x)!",
+    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
+             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
             addr, end1 - 1, start, end2 - 1);
 }
 
@@ -139,13 +140,13 @@ static void edu_dma_timer(void *opaque)
     }
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
-        uint32_t dst = edu->dma.dst;
+        uint64_t dst = edu->dma.dst;
         edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
         dst -= DMA_START;
         pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
                 edu->dma_buf + dst, edu->dma.cnt);
     } else {
-        uint32_t src = edu->dma.src;
+        uint64_t src = edu->dma.src;
         edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
         src -= DMA_START;
         pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-- 
2.17.1



