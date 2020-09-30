Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F78C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5EA2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5EA2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYvZ-0006ta-Dp
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYos-0007hJ-Ae; Wed, 30 Sep 2020 05:54:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49778 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYoh-0004Pp-7V; Wed, 30 Sep 2020 05:54:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CD1CBE1047232C6D5E8F;
 Wed, 30 Sep 2020 17:54:28 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:23 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 12/14] arm/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:19 +0800
Message-ID: <20200930095321.2006-13-zhaolichang@huawei.com>
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

I found that there are many spelling errors in the comments of qemu/target/arm.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/arm/cpu.h           | 2 +-
 target/arm/helper.c        | 4 ++--
 target/arm/m_helper.c      | 2 +-
 target/arm/translate-a64.c | 4 ++--
 target/arm/translate-sve.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61..996308b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2067,7 +2067,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
     return aa64;
 }
 
-/* Function for determing whether guest cp register reads and writes should
+/* Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
  * operating in AArch32 state, the NS-bit determines whether the secure
  * instance of a cp register should be used. When EL3 is AArch64 (or if
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88bd9dd..9292e16 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1867,7 +1867,7 @@ static void pmevtyper_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
      * pmevtyper_rawwrite is called between a pair of pmu_op_start and
      * pmu_op_finish calls when loading saved state for a migration. Because
      * we're potentially updating the type of event here, the value written to
-     * c14_pmevcntr_delta by the preceeding pmu_op_start call may be for a
+     * c14_pmevcntr_delta by the preceding pmu_op_start call may be for a
      * different counter type. Therefore, we need to set this value to the
      * current count for the counter type we're writing so that pmu_op_finish
      * has the correct count for its calculation.
@@ -12214,7 +12214,7 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
             } else {
                 memattr = 0x44;  /* Normal, NC, No */
             }
-            cacheattrs->shareability = 2; /* outer sharable */
+            cacheattrs->shareability = 2; /* outer shareable */
         } else {
             memattr = 0x00;      /* Device, nGnRnE */
         }
diff --git a/target/arm/m_helper.c b/target/arm/m_helper.c
index 0364542..1e8080d 100644
--- a/target/arm/m_helper.c
+++ b/target/arm/m_helper.c
@@ -158,7 +158,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
      *  R: 0 because unpriv and A flag not set
      *  SRVALID: 0 because NS
      *  MRVALID: 0 because unpriv and A flag not set
-     *  SREGION: 0 becaus SRVALID is 0
+     *  SREGION: 0 because SRVALID is 0
      *  MREGION: 0 because MRVALID is 0
      */
     return 0;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808..5451f02 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -160,7 +160,7 @@ void gen_a64_set_pc_im(uint64_t val)
  *  + for EL2 and EL3 there is only one TBI bit, and if it is set
  *    then the address is zero-extended, clearing bits [63:56]
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
- *    and TBI1 controls addressses with bit 55 == 1.
+ *    and TBI1 controls addresses with bit 55 == 1.
  *    If the appropriate TBI bit is set for the address then
  *    the address is sign-extended from bit 55 into bits [63:56]
  *
@@ -1964,7 +1964,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     }
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
-         * A write to any coprocessor regiser that ends a TB
+         * A write to any coprocessor register that ends a TB
          * must rebuild the hflags for the next TB.
          */
         TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b6..4e8a1c7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1528,7 +1528,7 @@ static bool trans_PNEXT(DisasContext *s, arg_rr_esz *a)
 
 /* Perform an inline saturating addition of a 32-bit value within
  * a 64-bit register.  The second operand is known to be positive,
- * which halves the comparisions we must perform to bound the result.
+ * which halves the comparisons we must perform to bound the result.
  */
 static void do_sat_addsub_32(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
 {
-- 
2.26.2.windows.1


