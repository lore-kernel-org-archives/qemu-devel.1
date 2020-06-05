Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA40D2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l+B8P5LT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA40D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1II-0005ch-26
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BR-0002DB-5o; Thu, 04 Jun 2020 21:30:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1BP-00009b-V2; Thu, 04 Jun 2020 21:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320608; x=1622856608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aYDJIv52R35pGo+x383MSKsJbltgkUkvhSmP0kHofFc=;
 b=l+B8P5LTqixeNLbXMeXX2p/07inxo2pUqYRTxvsaySN+xHB8csC1Jed3
 1TDRWY7sYsx7JoEFrU9+MFws4I9VAIXoR/yMzFmY7XfRdw+I+f/OZX35E
 ObNp2PX4mQ1n714YDk9+q4aMfszz5cibnDg8ZLCWsnOIKEJZyhhGT15RO
 bYKpKBibATBvvssVv6kwCb8kp4YNQHRHdWoonaiLYU0TLZGoY1vUKBt15
 W1lC3AvzZ8qs7hhHUypN5Ddky75rQyOWGCCgbuI5TY+FyFv+CZ7RCIPsp
 MlXZ0px0p9Rv1gtMAhky4uHq+R+XntV6B/NYf0K94M0yPEN/CCYYlsMCs w==;
IronPort-SDR: yPX10IfgeYGMXbFvchT9MHVCXyOpdvFgj1V3yOQ0SLo0hk34W6zdLivDYTHVdQCmqX9oGtMkah
 IpLUe0jNS6ZsuhGxwBPslnRivxgGMUtmV2Viw1gFEcidmWIiWA//xauvbRxZHuDO153WsvnGI3
 NnSkyxULoDz3eAq6WEso3rEQBJBUFLTN3J5EylrGWwFyfV7yaHKRlTEYimyoqhYog7NrSz4DGr
 Be5yy2dcq6+GAh+Zf7uaHnOaWDEf7pVED+DsfQnN/QrEMX8lWzH8IOeg8wTplSYt6ZVeMQG0Y3
 6YM=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="143573571"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:55 +0800
IronPort-SDR: ngo/fv0omU5qYEBAa9V/uP6oXfChWE8dVYUekGCLdlEtGB5TcuFBoP7WbgvL1wAP1Sm6W4vbq1
 +XJfGRhtFUUaAT1U9zm35vckNG7L7rTYA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:18:57 -0700
IronPort-SDR: bMRr1iGQjM8DTr2o/ujSmT1pV/Vka5u59ewaKUNG6ykIf9H4n6qyHsRvPet0MajoDBxFhCsBd7
 0eO0n3l9u+bA==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 09/17] target/riscv: Convert MSTATUS MTL to GVA
Date: Thu,  4 Jun 2020 18:21:07 -0700
Message-Id: <c4bd44f93615c74cfacfd94815ed7a47700640b4.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:41
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h   |  5 +++--
 target/riscv/cpu_helper.c | 20 ++++++++++++++++----
 target/riscv/csr.c        |  6 +++---
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index bb4ee3fc35..028e268faa 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -364,10 +364,10 @@
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
 
@@ -429,6 +429,7 @@
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HU           0x00000200
+#define HSTATUS_GVA          0x00000040
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1521c14b72..3b1a2f75ca 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -892,6 +892,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         if (riscv_has_ext(env, RVH)) {
             target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
 
+            if (riscv_cpu_virt_enabled(env) && tval) {
+                /*
+                 * If we are writing a guest virtual address to stval, set
+                 * this to 1. If we are trapping to VS we will set this to 0
+                 * later.
+                 */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 1);
+            }
+
             if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
                 !force_hs_execp) {
                 /*
@@ -902,6 +911,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     cause == IRQ_VS_EXT)
                     cause = cause - 1;
                 /* Trap to VS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -950,13 +960,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 53665b0985..69a3c8379c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -335,10 +335,10 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
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
@@ -364,7 +364,7 @@ static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
         tlb_flush(env_cpu(env));
     }
 
-    val &= MSTATUS_MPV | MSTATUS_MTL;
+    val &= MSTATUS_MPV | MSTATUS_GVA;
 
     env->mstatush = val;
 
-- 
2.26.2


