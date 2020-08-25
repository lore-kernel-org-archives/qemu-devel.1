Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B5CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCBC2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pvxibjhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCBC2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeFk-00050q-FJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAeA0-0003mB-ND
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9y-0002vu-Nn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381947; x=1629917947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38NE26KjmP/VOkhh84mZhIvIW7KkyhMM9Bjcgr+uH+k=;
 b=pvxibjhYE2UpUqw0KD/h9ceJlV3Pjs/w/Pnr8ygwTnKTh8D77UgWuDrC
 F6zJywPHwzBSfYjTIgTZyzQZyqLALvuU6gi3cjBCR/YHjMhifUgnxeINg
 VQVa3LagU0p7wz4WGbKomIbQc0l6LGTeCg43m0qdvqEDHGmk6Wp8JLBsP
 X9oCPgtmctYVn+00rg/1huQvJaMRe8fom/ZaQcMFeA5g2LPBVMXW9+qQZ
 CmRMUoQOAG8rqWRP8e3k44OKV5J+1GGPERzZK2wS70OwKZu9TrYVb/Bx3
 8lH4k7zNsCVNnQ+2iF7FU6vdj8f81MSBqFOMw1z1SZ7pNSPvHtkQiuVGh g==;
IronPort-SDR: Lvt6tl45kYswuP0XxIUEQ/rIVm4t8JFbysG5u/dQVGr+GLO40VNzfHhEM+Ar7JAEwA2BJLxuPZ
 njdrlyQI7wd42SDrOcv4KSjMYLqmsblENkF92NWkZWSAtPt2DnZEYjRDX6P+kEBxytXmsczJLD
 Wlb+Iqv+c6fmHObfGQVPCO/ffGh7s+cFqtzjm7up57kVbjLT93Wn8DCil98vgRYSllZSbEmXxa
 XUBNC4HhWOjiS+/YCa44vKQzGWc5HdVVyNvd6fYyVZ3axNhnyivLSSfQPRt1IY4LU1cHH8Za97
 FFc=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145292"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:57 +0800
IronPort-SDR: pXaGjbQStVQseaXVhT6nG4U1xQgQaEojuGJJ2DQVWVkoNznBxm06RgUsVoT3m5LCUriEcquyGJ
 uyHUpqjpzeVQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:32 -0700
IronPort-SDR: 7DSZie4UTo7+i2r2lVqa9y1ajAaN+4dMFCh4W6EhO8zJgiBkd0ZM8UfOBiPT2HFX1yF3mEHS9t
 gF3jJZSahsnA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] target/riscv: Convert MSTATUS MTL to GVA
Date: Tue, 25 Aug 2020 11:48:28 -0700
Message-Id: <20200825184836.1282371-11-alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 9308432988946de550a68524ed76e4b8683f10e2.1597259519.git.alistair.francis@wdc.com
Message-Id: <9308432988946de550a68524ed76e4b8683f10e2.1597259519.git.alistair.francis@wdc.com>
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
index 5efb3b16e0..0b4ad4bf46 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -901,6 +901,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -911,6 +924,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     cause == IRQ_VS_EXT)
                     cause = cause - 1;
                 /* Trap to VS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -959,13 +973,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
2.28.0


