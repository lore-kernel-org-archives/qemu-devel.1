Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2DC33CB1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 13:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A2E206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 13:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A2E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ict.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itB3A-0000ca-Kl
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 08:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangzhiying@ict.ac.cn>) id 1it8CQ-0002Cs-Vq
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 05:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangzhiying@ict.ac.cn>) id 1it8CP-0006fu-Lw
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 05:52:58 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:36882 helo=cstnet.cn)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <jiangzhiying@ict.ac.cn>) id 1it8CP-0006bT-3K
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 05:52:57 -0500
Received: from localhost.localdomain (unknown [111.196.189.80])
 by APP-01 (Coremail) with SMTP id qwCowADn7Zn+NCRe_nvKFw--.318S2;
 Sun, 19 Jan 2020 18:52:46 +0800 (CST)
From: jiangzhiying@ict.ac.cn
To: qemu-devel@nongnu.org
Subject: [PATCH] riscv: Fix defination of csr operations
Date: Sun, 19 Jan 2020 18:52:45 +0800
Message-Id: <20200119105245.5860-1-jiangzhiying@ict.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowADn7Zn+NCRe_nvKFw--.318S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4rAFyUJFW3ZrWkZFy5Jwb_yoWfJFb_Wr
 4vgF9Y9ry7Wa9Fvayku348tr1xZr1vgay2ga1xKr45G345WrZxGw1kXrn3XrWYvr4xG34f
 Ca4Iqa9xKay2yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb7AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l42xK82IY
 c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
 vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XyCJUUUUU==
X-Originating-IP: [111.196.189.80]
X-CM-SenderInfo: xmld0w52kl5x1qj6xunwoduhdfq/
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 159.226.251.21
X-Mailman-Approved-At: Sun, 19 Jan 2020 08:54:49 -0500
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
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com,
 Ian Jiang <ianjiang.ict@gmail.com>, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ian Jiang <ianjiang.ict@gmail.com>

There is a mistake in defining CSR operations for pmpcfg registers.
This patch fixes the bug.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f0b1..e07b5267be 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -948,7 +948,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SATP] =                { smode, read_satp,        write_satp        },
 
     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
+    [CSR_PMPCFG0  ... CSR_PMPCFG3] =  { pmp,   read_pmpcfg,  write_pmpcfg   },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr, write_pmpaddr  },
 
     /* Performance Counters */
-- 
2.17.1


