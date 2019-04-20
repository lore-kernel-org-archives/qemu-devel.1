Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A6C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB3220854
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 16:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="B3IEMdO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB3220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHsfc-0005zt-0O
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 12:16:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdr-0004st-5r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdo-0001vE-Az
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:02 -0400
Received: from m12-13.163.com ([220.181.12.13]:43634)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHsdk-0001qd-AW
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 12:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=r3Jtft8lSmafyHvM/Q
	IfK3f6RiL1dgUnclr6+lM0mBM=; b=B3IEMdO3a0MwLoe5xqRDrCw704vRWs38+5
	Y0DXK2m896fDbz5QbWmXUEqPQvr3OzAzOEqT2ccyWs7BCohUFssDpP0hzyYuuDpi
	6IBI14W3V4JKbfwD6LPSR+vz1QR9Myi/96SrZVrWqlHI1wiJT//KKpcht48lxQ0z
	XeyV2X25U=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowAAXzKN4RbtcjaXHAg--.9660S5;
	Sun, 21 Apr 2019 00:14:53 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 09:14:46 -0700
Message-Id: <20190420161446.2274-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420161446.2274-1-liq3ea@163.com>
References: <20190420161446.2274-1-liq3ea@163.com>
X-CM-TRANSID: DcCowAAXzKN4RbtcjaXHAg--.9660S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43CF1UGr48tw15Zr43Wrg_yoW8Zr1Dp3
	45Grn3XF4FgFyfJryjyw4DXFn5Grn8JFWrK3y8CwsY9ayrWFs7CFyUC3429ryxWryIvr1f
	uFZYqF43uF42vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j52-nUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFAucbVaD0UJ5bwAAs+
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH v2 3/3] edu: uses uint64_t in dma operation
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420161446.w3DagdrrqMftBwfR_Qflq5gSJxLau7hC1DNJHbDWmtM@z>

The dma related variable is dma_addr_t, it is uint64_t in
x64 platform. Change these usage from uint32_to uint64_t to
avoid trancation.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change since v1:
Fix format compile error on Windows

 hw/misc/edu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 4018dddcb8..f4a6d5f1c5 100644
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
+static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t start,
                 uint32_t size2)
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



