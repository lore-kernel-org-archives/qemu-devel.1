Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D456C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB4520663
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ahq6G8Ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB4520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1Gb-0001sp-9k
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BZ-0002Xk-OD; Thu, 04 Jun 2020 21:30:17 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BY-00009e-3L; Thu, 04 Jun 2020 21:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320617; x=1622856617;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cXuY4R2iUhKB0c3QoY7e2kDEz+l0l5YvpJtrzSp+Dmo=;
 b=Ahq6G8OwcE+DjhnA0UHjxawxAQD2THqjp3RXgPKEQ+uM86nF/9uXx8h2
 jhkGZHJ2uaeeMAppivW7gR9JQy73VQ+ybcWr6k7kdSWFOa/TW9h5hVhr7
 Zxjk9fzsNBlpKEVTQcn6a0kxbNgje/YvcLDxsngwkDgRcUy65QMMV3K2K
 dLOgb4jPsFgeAVzG+BmJsBgdZB+MBZzcZkhbQln3TBBe1wMcYHWtK0rXM
 VlXJMM0Y5gSLlHfVlZ31BPbwrfvS3qFOA11VNDpTFjMMlr+h5N+3esNPj
 OEUuuMcZ5Z7samOeH0ZRPXZTGhynY13RDgUM5mGVFvfDNwWi7qjkuTqIG w==;
IronPort-SDR: yJhNQEm1APh4Tqzx90lqFUUVKRSKPLRgLbaKrOOiOUvvHDyJRXacUq5GJQLRF/s3TcmjSSSRGj
 7J7m8cd4XBq1fPRZzbYf+sJzUO1+NjE9BggjU5q4t8nV/TzhaPrJ5OSBAkZ3Dbek54EogHZAkb
 vGMO/eF89wdWLFAGpzjE/mcmlO769OqhPk83kOCym3/ks7VW/SBEh3AAb7mh5RZHxaM1PaFz9V
 9Rk3928gVAmsEwapcVoUYAkM+l9IPrg/7umMlFAV7Q4tb1OzvXc4OdZOGuas0KIHZwdqsk3Et9
 rqk=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="242127071"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:30:17 +0800
IronPort-SDR: N2nRLyvfz4dqizsYgN7Q7rVCwGCNtBINMOlmrXavUxMuUCRTxfK//PO/7V3YZ3VLbfa8Io9oam
 2iJQVcOwTlfZaBZFaMWhTBCO69hqYRdlw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:50 -0700
IronPort-SDR: 5NSR7Cz/Tq5FBjEijCh2GBmxmFurVGGKJ5gynlyQDbAce7c44dkJ7FGajbUTJ2QG37Gl0Bn+rq
 YpifhsXL2MLA==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip02.wdc.com with ESMTP; 04 Jun 2020 18:30:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 16/17] target/riscv: Return the exception from invalid CSR
 accesses
Date: Thu,  4 Jun 2020 18:21:27 -0700
Message-Id: <d616a44645811854db7ada768c179ad8f2532158.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:30:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When performing a CSR access let's return a negative exception value on
an error instead of -1. This will allow us to specify the exception in
future patches.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c       | 46 ++++++++++++++++++++--------------------
 target/riscv/op_helper.c | 18 ++++++++++------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 9990a0dd09..0c53438605 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -47,7 +47,7 @@ static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -61,7 +61,7 @@ static int ctr(CPURISCVState *env, int csrno)
 
     if (!cpu->cfg.ext_counters) {
         /* The Counters extensions is not enabled */
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -89,7 +89,7 @@ static int hmode(CPURISCVState *env, int csrno)
         }
     }
 
-    return -1;
+    return -RISCV_EXCP_ILLEGAL_INST;
 }
 
 static int pmp(CPURISCVState *env, int csrno)
@@ -103,7 +103,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = riscv_cpu_get_fflags(env);
@@ -114,7 +114,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -126,7 +126,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = env->frm;
@@ -137,7 +137,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -149,7 +149,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
@@ -161,7 +161,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -223,7 +223,7 @@ static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->rdtime_fn() + delta;
@@ -236,7 +236,7 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = (env->rdtime_fn() + delta) >> 32;
@@ -502,7 +502,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     *val = env->mcounteren;
     return 0;
@@ -512,7 +512,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mcounteren = val;
     return 0;
@@ -736,7 +736,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     }
 
     if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     } else {
         *val = env->satp;
     }
@@ -753,7 +753,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-            return -1;
+            return -RISCV_EXCP_ILLEGAL_INST;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
                 tlb_flush(env_cpu(env));
@@ -923,7 +923,7 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -937,7 +937,7 @@ static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -952,7 +952,7 @@ static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->htimedelta >> 32;
@@ -962,7 +962,7 @@ static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
@@ -1160,18 +1160,18 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     if ((write_mask && read_only) ||
         (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
 
     /* ensure the CSR extension is enabled. */
     if (!cpu->cfg.ext_icsr) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* check predicate */
     if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* execute combined read/write operation if it exists */
@@ -1181,7 +1181,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* if no accessor exists then return failure */
     if (!csr_ops[csrno].read) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* read old value */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index efc2d854eb..80d632777b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -43,8 +43,10 @@ target_ulong helper_csrrw(CPURISCVState *env, target_ulong src,
         target_ulong csr)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, src, -1) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, src, -1);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
@@ -53,8 +55,10 @@ target_ulong helper_csrrs(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, -1, rs1_pass ? src : 0);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
@@ -63,8 +67,10 @@ target_ulong helper_csrrc(CPURISCVState *env, target_ulong src,
         target_ulong csr, target_ulong rs1_pass)
 {
     target_ulong val = 0;
-    if (riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0) < 0) {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    int ret = riscv_csrrw(env, csr, &val, 0, rs1_pass ? src : 0);
+
+    if (ret < 0) {
+        riscv_raise_exception(env, -ret, GETPC());
     }
     return val;
 }
-- 
2.26.2


