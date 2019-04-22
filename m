Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B76C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E200B20685
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 14:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PgiY9KHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E200B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIZxg-0000c0-To
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 10:30:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZwG-0007oA-4j
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgr-0005L0-8k
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:02 -0400
Received: from m12-12.163.com ([220.181.12.12]:59099)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hIZgq-0005KQ-N3
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=nQoqn/+2UWQM9V3Ss/
	BbafTfJ2pjBYmf2/7+vVlg1QY=; b=PgiY9KHRLJmHcLrUlMs7YVFzl7fPqTNX/V
	y++oU1siE0qaDHal2BH8Rj++h57b3zifDkKrdQsSCDM4CtWQU2yqkkSgXgkU/2dp
	yuZMkbMblwieb+PR6Sqba2j2NRJWvIdgZAGt6BhP3vYr+eFneSoXqzpgnEHBJ2rP
	E3tvuZxy4=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp8 (Coremail) with SMTP id DMCowACXUzO0y71cvQ2cBg--.39054S5;
	Mon, 22 Apr 2019 22:12:10 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: jslaby@suse.cz,
	pbonzini@redhat.com
Date: Mon, 22 Apr 2019 07:11:56 -0700
Message-Id: <20190422141156.15746-4-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422141156.15746-1-liq3ea@163.com>
References: <20190422141156.15746-1-liq3ea@163.com>
X-CM-TRANSID: DMCowACXUzO0y71cvQ2cBg--.39054S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF45WF15KFWxuryrur4kZwb_yoW8ZF13p3
	45Grs3XF4FgFyfJryUAw4DXF1rGrn5tFWrK3yUCrsY9ayrWFs7CFyUA342vrWxWryIvF13
	uFZYvF43uF4xZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOJ5rUUUUU=
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiKRqebVXlqxQejgAAsf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.12
Subject: [Qemu-devel] [PATCH v3 3/3] edu: uses uint64_t in dma operation
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
Cc: philmd@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
	Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422141156.eZ_zcAgN_xCzzC9kKZ9ho-9liuSeJ7p5KSTHB4QKXXg@z>

The dma related variable dma.dst/src/cnt is dma_addr_t, it is
uint64_t in x64 platform. Change these usage from uint32_to
uint64_t to avoid trancation in edu_dma_timer.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
---
 hw/misc/edu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 33de05141f..401ada74af 100644
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



