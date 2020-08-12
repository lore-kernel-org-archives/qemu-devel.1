Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAEF20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WBvuwhie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAEF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wMV-0006b8-CN
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLU-0004sD-8e; Wed, 12 Aug 2020 15:23:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLR-0000Qu-8n; Wed, 12 Aug 2020 15:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260209; x=1628796209;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bTBYJS33X66hR5BWg52KbjhjVXejja8XXpAu0gSx3v8=;
 b=WBvuwhieZJZaR22bCnVIz/ROMf3pBwmnge3yUe8QE4ZUQVpu/hjpbCSC
 Vwt4XEZJEuYVwWaz/2Q0XMztGORF4HrtKHtjR7lTb0j+8P+mnTbdYXRUO
 5tMEPAcntYsmoi5bJDZkNe14Ji9vOFX00TOKp0HWLZVUX40PFQQ+2+wNx
 J2+Tn7MEkTOFrZ0E6x6z+GK3hAYuIncdfbXWSMOu53l5RlMFO66RYf0gD
 wZYiDHlwMuSO6mPLbx0NB1mp24nRmyojIdB+4rYXJIZ0+xHGvdUlGYwuD
 /XN9727I9a4+1XWJoqOsi6NnVmC0g9bUczDTE4kJfJYrBivyIjazvkFX0 A==;
IronPort-SDR: i/gnJVNX/FLywHF2+AW4m0q7IXyZxD2i730K91wZxGat58nUYZRsEeXjdpq7QZHrffQWpJryoL
 nBb/b5T+enJFCxWF0fR+eF4acxzzSZSXjOR4T9e8Vt/+PhmcLT4+ciULhA9a99HBVVgxmZ8sDE
 uZklH8UgrHYjGZmf6Sy5/Y6HW2DN8YDdHP2Y0C1CO8E4O7jgOSkanyyJTy9V5pz/blYewcVcGl
 y35+tYztOT7j3oz78spkF8yLHu8hHQW4gy85XmYgCrGqq0h5Ezx7cJGz7vbkd+uU8TFNX6oVql
 fzI=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029202"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:28 +0800
IronPort-SDR: 1OEodlBCKetwIFppLaOdSh38FyxWAHVAwuZRWe0HaiSMc4E8GCAZG4gYU7Nn8OtnU+Bjnn1NHv
 dPfBLMgk+FUg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:36 -0700
IronPort-SDR: xWPvZb4NhCsOeI98eD7XcpHDboJymBg6VVNzh9Cyl+4KVQjKrUPQzq6O7vlxK8zRnP2FGrpG96
 T2j1MQiSk+HA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 05/13] target/riscv: Convert MSTATUS MTL to GVA
Date: Wed, 12 Aug 2020 12:13:27 -0700
Message-Id: <9308432988946de550a68524ed76e4b8683f10e2.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  5 +++--
 target/riscv/cpu_helper.c | 24 ++++++++++++++++++++----
 target/riscv/csr.c        |  6 +++---
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 7abae4267f..43617e7c1f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -379,10 +379,10 @@
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
 #if defined(TARGET_RISCV64)
-#define MSTATUS_MTL         0x4000000000ULL
+#define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
 #elif defined(TARGET_RISCV32)
-#define MSTATUS_MTL         0x00000040
+#define MSTATUS_GVA         0x00000040
 #define MSTATUS_MPV         0x00000080
 #endif
 
@@ -444,6 +444,7 @@
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HU           0x00000200
+#define HSTATUS_GVA          0x00000040
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 10c9f8b63b..b5f4264525 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -894,6 +894,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         if (riscv_has_ext(env, RVH)) {
             target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
 
+            if ((riscv_cpu_virt_enabled(env) ||
+                 riscv_cpu_two_stage_lookup(env)) && tval) {
+                /*
+                 * If we are writing a guest virtual address to stval, set
+                 * this to 1. If we are trapping to VS we will set this to 0
+                 * later.
+                 */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 1);
+            } else {
+                /* For other HS-mode traps, we set this to 0. */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
+            }
+
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
                 /*
@@ -904,6 +917,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     cause == IRQ_VS_EXT)
                     cause = cause - 1;
                 /* Trap to VS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -952,13 +966,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 #ifdef TARGET_RISCV32
             env->mstatush = set_field(env->mstatush, MSTATUS_MPV,
                                        riscv_cpu_virt_enabled(env));
-            env->mstatush = set_field(env->mstatush, MSTATUS_MTL,
-                                       riscv_cpu_force_hs_excep_enabled(env));
+            if (riscv_cpu_virt_enabled(env) && tval) {
+                env->mstatush = set_field(env->mstatush, MSTATUS_GVA, 1);
+            }
 #else
             env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
                                       riscv_cpu_virt_enabled(env));
-            env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
-                                      riscv_cpu_force_hs_excep_enabled(env));
+            if (riscv_cpu_virt_enabled(env) && tval) {
+                env->mstatus = set_field(env->mstatus, MSTATUS_GVA, 1);
+            }
 #endif
 
             mtval2 = env->guest_phys_fault_addr;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0f035d33b1..f9ac21d687 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -403,10 +403,10 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
         MSTATUS_TW;
 #if defined(TARGET_RISCV64)
     /*
-     * RV32: MPV and MTL are not in mstatus. The current plan is to
+     * RV32: MPV and GVA are not in mstatus. The current plan is to
      * add them to mstatush. For now, we just don't support it.
      */
-    mask |= MSTATUS_MTL | MSTATUS_MPV;
+    mask |= MSTATUS_MPV | MSTATUS_GVA;
 #endif
 
     mstatus = (mstatus & ~mask) | (val & mask);
@@ -432,7 +432,7 @@ static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
         tlb_flush(env_cpu(env));
     }
 
-    val &= MSTATUS_MPV | MSTATUS_MTL;
+    val &= MSTATUS_MPV | MSTATUS_GVA;
 
     env->mstatush = val;
 
-- 
2.27.0


