Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2A6C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6991D2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6991D2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYvq-000724-EF
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYom-0007T1-Mm; Wed, 30 Sep 2020 05:54:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5160 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kNYob-0004PA-WB; Wed, 30 Sep 2020 05:54:36 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 948395D73FB726842576;
 Wed, 30 Sep 2020 17:54:22 +0800 (CST)
Received: from localhost (10.174.185.186) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:54:14 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH RFC 07/14] s390x/: fix some comment spelling errors
Date: Wed, 30 Sep 2020 17:53:14 +0800
Message-ID: <20200930095321.2006-8-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20200930095321.2006-1-zhaolichang@huawei.com>
References: <20200930095321.2006-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.186]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
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

I found that there are many spelling errors in the comments of qemu/target/s390x.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
---
 target/s390x/cpu_models.h       | 4 ++--
 target/s390x/excp_helper.c      | 2 +-
 target/s390x/fpu_helper.c       | 2 +-
 target/s390x/insn-data.def      | 2 +-
 target/s390x/misc_helper.c      | 2 +-
 target/s390x/translate.c        | 4 ++--
 target/s390x/translate_vx.c.inc | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 74d1f87..15c0f0d 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -24,13 +24,13 @@ struct S390CPUDef {
     uint8_t gen;            /* hw generation identification */
     uint16_t type;          /* cpu type identification */
     uint8_t ec_ga;          /* EC GA version (on which also the BC is based) */
-    uint8_t mha_pow;        /* Maximum Host Adress Power, mha = 2^pow-1 */
+    uint8_t mha_pow;        /* Maximum Host Address Power, mha = 2^pow-1 */
     uint32_t hmfai;         /* hypervisor-managed facilities */
     /* base/min features, must never be changed between QEMU versions */
     S390FeatBitmap base_feat;
     /* used to init base_feat from generated data */
     S390FeatInit base_init;
-    /* deafault features, QEMU version specific */
+    /* default features, QEMU version specific */
     S390FeatBitmap default_feat;
     /* used to init default_feat from generated data */
     S390FeatInit default_init;
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 3b58d10..9644a67 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -538,7 +538,7 @@ try_deliver:
         /* don't trigger a cpu_loop_exit(), use an interrupt instead */
         cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
     } else if (cs->halted) {
-        /* unhalt if we had a WAIT PSW somehwere in our injection chain */
+        /* unhalt if we had a WAIT PSW somewhere in our injection chain */
         s390_cpu_unhalt(cpu);
     }
 }
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index f155bc0..3e609b7 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -89,7 +89,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
     /*
      * invalid/divbyzero cannot coexist with other conditions.
      * overflow/underflow however can coexist with inexact, we have to
-     * handle it separatly.
+     * handle it separately.
      */
     if (s390_exc & ~S390_IEEE_MASK_INEXACT) {
         if (s390_exc & ~S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index d79ae9e..1631948 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -523,7 +523,7 @@
 /* LOAD LOGICAL HALFWORD RELATIVE LONG */
     C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
     C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
-/* LOAD LOGICAL IMMEDATE */
+/* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
     D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
     D(0xa50c, LLIHH,   RI_a,  Z,  0, i2_16u_shl, 0, r1, mov2, 0, 48)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 58dbc02..929e509 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -312,7 +312,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
             /* same as machine type number in STORE CPU ID, but in EBCDIC */
             snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type);
             ebcdic_put(sysib.sysib_111.type, type, 4);
-            /* model number (not stored in STORE CPU ID for z/Architecure) */
+            /* model number (not stored in STORE CPU ID for z/Architecture) */
             ebcdic_put(sysib.sysib_111.model, "QEMU            ", 16);
             ebcdic_put(sysib.sysib_111.sequence, "QEMU            ", 16);
             ebcdic_put(sysib.sysib_111.plant, "QEMU", 4);
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a777343..58ad6c8 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -433,7 +433,7 @@ static void gen_program_exception(DisasContext *s, int code)
 {
     TCGv_i32 tmp;
 
-    /* Remember what pgm exeption this was.  */
+    /* Remember what pgm exception this was.  */
     tmp = tcg_const_i32(code);
     tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_code));
     tcg_temp_free_i32(tmp);
@@ -489,7 +489,7 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
 
     /*
      * Note that d2 is limited to 20 bits, signed.  If we crop negative
-     * displacements early we create larger immedate addends.
+     * displacements early we create larger immediate addends.
      */
     if (b2 && x2) {
         tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
index eb767f5..983da56 100644
--- a/target/s390x/translate_vx.c.inc
+++ b/target/s390x/translate_vx.c.inc
@@ -789,7 +789,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
         }
         break;
     case 0x94:
-        /* If sources and destination dont't overlap -> fast path */
+        /* If sources and destination don't overlap -> fast path */
         if (v1 != v2 && v1 != v3) {
             const uint8_t src_es = get_field(s, m4);
             const uint8_t dst_es = src_es - 1;
-- 
2.26.2.windows.1


