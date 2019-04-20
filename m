Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F92CC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5780B20833
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 14:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="kyvqRbox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5780B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHrQx-0004jO-LI
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 10:57:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrNi-0002CZ-Sk
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL6-00019W-3A
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:36 -0400
Received: from m12-13.163.com ([220.181.12.13]:58461)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHrL5-00018V-0M
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 10:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=lgkdDMul6cYmcPejZ/
	UePeaPFgmTCIP83JKHfVUUsqY=; b=kyvqRbox3EZxQNuPmuCchOwtfyFf4Vpg0r
	a4gDyAH1HtCHqrt/QbOKrwUJGPuPydf/jLUyCNuSfiovJ/anVDuTRdiRCwzpuCCX
	a6WFDmg7lCAx+eWbj2qjsZsXrov5I0b8pwPzRI/d2WPKAE7neI3dwAtxOF1nho8s
	SO9XE2fr0=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp9 (Coremail) with SMTP id DcCowABXKKbvMbtc5Pi_Ag--.9861S5;
	Sat, 20 Apr 2019 22:51:33 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Sat, 20 Apr 2019 07:51:20 -0700
Message-Id: <20190420145120.122847-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420145120.122847-1-liq3ea@163.com>
References: <20190420145120.122847-1-liq3ea@163.com>
X-CM-TRANSID: DcCowABXKKbvMbtc5Pi_Ag--.9861S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF43CF1UGr48KryDXF1rXrb_yoW8CrW7p3
	45Grn3XF4FgFyfJ34Yyw4DXrn5GrnxtFWrK348CrsY9ay5WFs7CryDC34I9ryxWrySyr13
	uFZYgF43uF4IvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7TmfUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBWcbVaD0UGUEwAAsy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.13
Subject: [Qemu-devel] [PATCH 3/3] edu: uses uint64_t in dma operation
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
Message-ID: <20190420145120.XmapHpDHI6QkskbZGy__I19ckdXKSCoJmOK81jV4l-M@z>

The dma related variable is dma_addr_t, it is uint64_t in
x64 platform. Change these usage from uint32_to uint64_t to
avoid trancation.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/misc/edu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 4018dddcb8..b93a679adf 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -98,23 +98,23 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
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
+    hw_error("EDU: DMA range 0x%.8lx-0x%.8lx out of bounds (0x%.8lx-0x%.8lx)!",
             addr, end1 - 1, start, end2 - 1);
 }
 
@@ -139,13 +139,13 @@ static void edu_dma_timer(void *opaque)
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



