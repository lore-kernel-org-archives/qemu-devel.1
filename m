Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F69C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30400207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hg1ugIwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30400207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53686 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN7N-00020f-BE
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrz-0004EL-Lu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMry-0001sp-DZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:57:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMrx-0001Pu-VA; Fri, 07 Jun 2019 17:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944674; x=1591480674;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V7hzYZ9pPfeYdjZ6nLEgskvAj7ymCe64/NTTLGRivJg=;
 b=Hg1ugIwzNcFZvATDz91aMQIUSgZvpDH/rSxSngSXHdg6G/n28Q4jOH5u
 L4a3tSV1iZ0/cIBWi9fZcrRRa3Js1eDFFr18czBziZydmkhi9iYyEQ4v/
 fr5FF75zwo5dNcFIejG6dZ3fQA8oAOKtigFSZM+i98eGPOahBUtlV7VNi
 9Dr03NfL08IY7mu1Fp3qSFlzPJYis+HaVHapQ7zAkZ12UEef/MxtJbx+H
 2SP7vSwD2cwfijvF/byY+mfBaPOQeZ+ykeLpVXNd8xjyqhi9pH6PoqqFU
 Kow0aP8ZetKcDQf+gOCGeVoAaBcJVQST28Lk82da8n/igRICuvqwpvELO w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="115014090"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:57:54 +0800
IronPort-SDR: cPh9Bn7S02kdPPDH6Kf2xvAXjEP1u6HxI5BCgnPk5Kot6Bhgmy0b9Y6XyUudPfTFqsbTBTmjIz
 SoQNSbNJoHSezv7b6NhlH5NtVBx0Me8MjOeDfNAR/k2JrhVpIPE6ydCbCnl70Qe5vMAuLxPoaM
 oggKWAx1XlydjZXNt+//vtKk6O+4sU5XTXA22rQ5JNJI78Rb/wqOPfaCtrxyUPVDb/D+k1oymf
 KmPRNbSbI6W6vIariK+hfo9aFVFPWhnV9/WSiVPqZV/iL4TiHBXwt7biCBKqjZG9cDo9XFg048
 OXRPOvG1tSdA1it8H/5gsg/B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:09 -0700
IronPort-SDR: +vE6w7f/zuxUpzir9AnAnW4C1OJKONh47TzTgxzgNfk+NsTwMK7pl08GvEuRAw+5boOqa1FNAs
 jF6u6ZxV/R3TU0ykziXnyyVQp9hxRMHy1s6qriaoZz2Ll6QDLLzSOXdx9DQiWVi6pU/BPvICIv
 60cZ7EW3cN76ZDnifrciiTv1v/eZAa0puqbQ1aha/z5Sf5qBBEWT5EzqtrAIZojZrCGTx7Ce/m
 +rQoK8Iy3/1OMW4QW2d4ZD1xJe3fjrUfDN5hF1zaT9qAPIYnAt9Q1iCTlcQ/77tuRPcnARMOAD
 z+o=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:57:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:55:43 -0700
Message-Id: <9119001d8c309e9440d01f1606ce5e6c783845c7.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v1 08/27] target/riscv: Create function to test
 if FP is enabled
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's creaate a function that tests if floating point support is
enabled. We can then protect all floating point operations based on if
they are enabled.

This patch so far doesn't change anything, it's just preparing for the
Hypervisor support for floating point operations.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  6 +++++-
 target/riscv/cpu_helper.c | 10 ++++++++++
 target/riscv/csr.c        | 22 +++++++++++++---------
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index b99d2b7af2..eed561d56e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -301,6 +301,7 @@ bool riscv_cpu_virt_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 bool riscv_cpu_force_hs_excep_enabled(CPURISCVState *env);
 void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable);
+bool riscv_cpu_fp_enabled(CPURISCVState *env);
 int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
 hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
@@ -344,7 +345,10 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
 #ifdef CONFIG_USER_ONLY
     *flags = TB_FLAGS_MSTATUS_FS;
 #else
-    *flags = cpu_mmu_index(env, 0) | (env->mstatus & MSTATUS_FS);
+    *flags = cpu_mmu_index(env, 0);
+    if (riscv_cpu_fp_enabled(env)) {
+        *flags |= env->mstatus & MSTATUS_FS;
+    }
 #endif
 }
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0fdc81f71f..f51139b543 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -117,6 +117,16 @@ void riscv_cpu_set_force_hs_excep(CPURISCVState *env, bool enable)
     env->virt |= enable << FORCE_HS_EXCEP_SHIFT;
 }
 
+/* Return true is floating point support is currently enabled */
+bool riscv_cpu_fp_enabled(CPURISCVState *env)
+{
+    if (env->mstatus & MSTATUS_FS) {
+        return true;
+    }
+
+    return false;
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 809c4c09a9..4b1308d47c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -46,7 +46,7 @@ void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
 static int fs(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -92,7 +92,7 @@ static int pmp(CPURISCVState *env, int csrno)
 static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -103,7 +103,7 @@ static int read_fflags(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -115,7 +115,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
 static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -126,7 +126,7 @@ static int read_frm(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -138,7 +138,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
 static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
 #endif
@@ -150,7 +150,7 @@ static int read_fcsr(CPURISCVState *env, int csrno, target_ulong *val)
 static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
 {
 #if !defined(CONFIG_USER_ONLY)
-    if (!env->debugger && !(env->mstatus & MSTATUS_FS)) {
+    if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
         return -1;
     }
     env->mstatus |= MSTATUS_FS;
@@ -324,8 +324,12 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 
     mstatus = (mstatus & ~mask) | (val & mask);
 
-    int dirty = ((mstatus & MSTATUS_FS) == MSTATUS_FS) |
-                ((mstatus & MSTATUS_XS) == MSTATUS_XS);
+    int dirty = (mstatus & MSTATUS_XS) == MSTATUS_XS;
+
+    if (riscv_cpu_fp_enabled(env)) {
+        dirty |= (mstatus & MSTATUS_FS) == MSTATUS_FS;
+    }
+
     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
     env->mstatus = mstatus;
 
-- 
2.21.0


