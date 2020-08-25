Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:09:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15F12074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Amtm6D27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15F12074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeKH-0004sU-5T
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAd-0004qZ-DT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeAa-0002vn-0e
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381985; x=1629917985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=phuY6E/b88DLSXc1+8LIVym5ETpDpaL8va6SjjxdDfY=;
 b=Amtm6D27FXS8urnbeKH34nrT+qrd7b1pF0kj9ugyjAJVwxQg/g0eGvDX
 c6yOeqNNqXD2o622SbNT93iFAb91Elsol2v/PhQTzcUXZSz/Ebf80MNSf
 OJJNc3h7xG7tpmfGkp+skxPhTsB3davdXsY07puHk8SVqkrhuTp+GuPcg
 FbiVuBCnskQrPc/PogaJM63StvORWUKllayb3rPXILcBnpjFsHe7NRJY4
 VM5OhIBgN4j246oEOZJj/RO4U8XODffzMwSUXTX1GOfbOcNg0/uqs68qw
 KpKiU+wLExdDR7WyEUEi7js2o3cSt/VJUI+69IUvyNVW082VZKyLr96qz w==;
IronPort-SDR: GqF0cf3sY7uVY2bzf0LduhKgsqJM4iSQIVPAZn1rrLMm1YCoaFEHcplzgtK0Z+lYHl987MKrWW
 F/+SwM6oGIRoGy4KDJa6QToT6f4gZDRkVZb2GaHjQroUVFGSz9Ss+80CFDjkuQ9RJmoDWFbS8j
 aieTlxo8NJ5fnOB5QtTZyJZsNGBreCqO/MRbomWOC/QIBcgcTxLnB59Nortnx9Bo5P6izC9TW8
 azM5bVUZkLZmfzbQEyc6c9TGx3VQJmuAWc7isjfAmazuMtZh/i/66gPrLyt45bUNgJ0rn0XtGC
 VVY=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145301"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:58 +0800
IronPort-SDR: jkT9f9xc9oiuDFJO6CaBVByvlphDsKnKgXCGt1dCwqZAaG6/Qo0riR8s/q+GpaIDORk8l8FSg7
 7vY/ugbw7r7w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:33 -0700
IronPort-SDR: cyBKwzjrLoXByKYGUcQ+Snlvq+S3/Yc0qwkbV8/3atAB0OFXZdbz7PGpKE9y66qn7z7JHxTyj2
 SelwGBZEgV6A==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] target/riscv: Return the exception from invalid CSR
 accesses
Date: Tue, 25 Aug 2020 11:48:35 -0700
Message-Id: <20200825184836.1282371-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When performing a CSR access let's return a negative exception value on
an error instead of -1. This will allow us to specify the exception in
future patches.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: a487dad60c9b8fe7a2b992c5e0dcc2504a9000a7.1597259519.git.alistair.francis@wdc.com
Message-Id: <a487dad60c9b8fe7a2b992c5e0dcc2504a9000a7.1597259519.git.alistair.francis@wdc.com>
---
 target/riscv/csr.c       | 46 ++++++++++++++++++++--------------------
 target/riscv/op_helper.c | 18 ++++++++++------
 2 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7dc50e6299..197ce97e95 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -51,7 +51,7 @@ static int fs(CPURISCVState *env, int csrno)
         return 0;
     }
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -73,7 +73,7 @@ static int ctr(CPURISCVState *env, int csrno)
 
     if (!cpu->cfg.ext_counters) {
         /* The Counters extensions is not enabled */
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     return 0;
@@ -101,7 +101,7 @@ static int hmode(CPURISCVState *env, int csrno)
         }
     }
 
-    return -1;
+    return -RISCV_EXCP_ILLEGAL_INST;
 }
 
 static int pmp(CPURISCVState *env, int csrno)
@@ -115,7 +115,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = riscv_cpu_get_fflags(env);
@@ -126,7 +126,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -138,7 +138,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = env->frm;
@@ -149,7 +149,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -161,7 +161,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 #endif
     *val = (riscv_cpu_get_fflags(env) << FSR_AEXC_SHIFT)
@@ -177,7 +177,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mstatus |= MSTATUS_FS;
 #endif
@@ -291,7 +291,7 @@ static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->rdtime_fn() + delta;
@@ -304,7 +304,7 @@ static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
     uint64_t delta = riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
 
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = (env->rdtime_fn() + delta) >> 32;
@@ -570,7 +570,7 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     *val = env->mcounteren;
     return 0;
@@ -580,7 +580,7 @@ static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (env->priv_ver < PRIV_VERSION_1_11_0) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
     env->mcounteren = val;
     return 0;
@@ -804,7 +804,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
     }
 
     if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     } else {
         *val = env->satp;
     }
@@ -821,7 +821,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
         ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
     {
         if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
-            return -1;
+            return -RISCV_EXCP_ILLEGAL_INST;
         } else {
             if((val ^ env->satp) & SATP_ASID) {
                 tlb_flush(env_cpu(env));
@@ -991,7 +991,7 @@ static int write_hgatp(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -1005,7 +1005,7 @@ static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
 #if defined(TARGET_RISCV32)
@@ -1020,7 +1020,7 @@ static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong val)
 static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     *val = env->htimedelta >> 32;
@@ -1030,7 +1030,7 @@ static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong val)
 {
     if (!env->rdtime_fn) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     env->htimedelta = deposit64(env->htimedelta, 32, 32, (uint64_t)val);
@@ -1228,18 +1228,18 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
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
@@ -1249,7 +1249,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* if no accessor exists then return failure */
     if (!csr_ops[csrno].read) {
-        return -1;
+        return -RISCV_EXCP_ILLEGAL_INST;
     }
 
     /* read old value */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 4b64bfe7d2..948d204793 100644
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
2.28.0


