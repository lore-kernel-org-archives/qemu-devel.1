Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A5C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659DF2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659DF2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ1v-0006WS-Iq
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYp1-0007sm-Lk; Wed, 30 Sep 2020 05:54:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49976 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYon-0004QU-6k; Wed, 30 Sep 2020 05:54:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 96FD6E9574FEB3C54B7C;
 Wed, 30 Sep 2020 17:54:34 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:25 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 14/14] target/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:21 +0800
Message-ID: <20200930095321.2006-15-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhaolichang <zhaolichang@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/openrisc/cpu.h        | 2 +-
 target/sparc/asi.h           | 2 +-
 target/unicore32/translate.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index bd42faf..8ca8605 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -291,7 +291,7 @@ typedef struct CPUOpenRISCState {
     int is_counting;
 
     uint32_t picmr;         /* Interrupt mask register */
-    uint32_t picsr;         /* Interrupt contrl register*/
+    uint32_t picsr;         /* Interrupt control register*/
 #endif
     void *irq[32];          /* Interrupt irq input */
 } CPUOpenRISCState;
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index bb58735..4e9f1d5 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -231,7 +231,7 @@
 #define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
 #define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
 #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
+#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
 #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
 #define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
 #define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index d4b06df..2e91b05 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -119,7 +119,7 @@ static void load_reg_var(DisasContext *s, TCGv var, int reg)
 {
     if (reg == 31) {
         uint32_t addr;
-        /* normaly, since we updated PC */
+        /* normally, since we updated PC */
         addr = (long)s->pc;
         tcg_gen_movi_i32(var, addr);
     } else {
-- 
2.26.2.windows.1


