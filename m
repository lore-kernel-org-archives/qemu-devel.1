Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414AC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AEBE2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AEBE2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYx2-0000Fh-EX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoq-0007dg-QL; Wed, 30 Sep 2020 05:54:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46822 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYog-0004Pc-V1; Wed, 30 Sep 2020 05:54:40 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 46A20F9395786ACA8D87;
 Wed, 30 Sep 2020 17:54:27 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:16 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 08/14] m68k/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:15 +0800
Message-ID: <20200930095321.2006-9-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

I found that there are many spelling errors in the comments of qemu/target/m68k.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/m68k/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3fc67aa..133a404 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -438,7 +438,7 @@ static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
 }
 
 /*
- * Handle a base + index + displacement effective addresss.
+ * Handle a base + index + displacement effective address.
  * A NULL_QREG base means pc-relative.
  */
 static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
@@ -1696,7 +1696,7 @@ static void bcd_add(TCGv dest, TCGv src)
 
     /*
      * t1 = (src + 0x066) + dest + X
-     *    = result with some possible exceding 0x6
+     *    = result with some possible exceeding 0x6
      */
 
     t0 = tcg_const_i32(0x066);
@@ -1706,7 +1706,7 @@ static void bcd_add(TCGv dest, TCGv src)
     tcg_gen_add_i32(t1, t0, dest);
     tcg_gen_add_i32(t1, t1, QREG_CC_X);
 
-    /* we will remove exceding 0x6 where there is no carry */
+    /* we will remove exceeding 0x6 where there is no carry */
 
     /*
      * t0 = (src + 0x0066) ^ dest
@@ -1736,7 +1736,7 @@ static void bcd_add(TCGv dest, TCGv src)
     tcg_temp_free(t0);
 
     /*
-     * remove the exceding 0x6
+     * remove the exceeding 0x6
      * for digits that have not generated a carry
      */
 
@@ -2638,7 +2638,7 @@ DISAS_INSN(negx)
     gen_flush_flags(s); /* compute old Z */
 
     /*
-     * Perform substract with borrow.
+     * Perform subtract with borrow.
      * (X, N) =  -(src + X);
      */
 
@@ -2653,7 +2653,7 @@ DISAS_INSN(negx)
     /*
      * Compute signed-overflow for negation.  The normal formula for
      * subtraction is (res ^ src) & (src ^ dest), but with dest==0
-     * this simplies to res & src.
+     * this simplifies to res & src.
      */
 
     tcg_gen_and_i32(QREG_CC_V, QREG_CC_N, src);
@@ -3159,7 +3159,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
     gen_flush_flags(s); /* compute old Z */
 
     /*
-     * Perform substract with borrow.
+     * Perform subtract with borrow.
      * (X, N) = dest - (src + X);
      */
 
@@ -3169,7 +3169,7 @@ static inline void gen_subx(DisasContext *s, TCGv src, TCGv dest, int opsize)
     gen_ext(QREG_CC_N, QREG_CC_N, opsize, 1);
     tcg_gen_andi_i32(QREG_CC_X, QREG_CC_X, 1);
 
-    /* Compute signed-overflow for substract.  */
+    /* Compute signed-overflow for subtract.  */
 
     tcg_gen_xor_i32(QREG_CC_V, QREG_CC_N, dest);
     tcg_gen_xor_i32(tmp, dest, src);
-- 
2.26.2.windows.1


