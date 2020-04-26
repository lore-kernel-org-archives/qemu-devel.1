Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996EC55194
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54A7920700
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bqTLlKhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A7920700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSkEd-0008Qn-0o
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 12:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8D-0005A4-Rb
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8D-0004gr-6x
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 12:27:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=378a396a1=alistair.francis@wdc.com>)
 id 1jSk8C-0004Yo-GW; Sun, 26 Apr 2020 12:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587918469; x=1619454469;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0oiDk7J3Zus8eSyYHPNvY+6gdJrBdeYARP2nSpKdd4A=;
 b=bqTLlKhDrRgjQ5NzwEuS7t4iXZ23W8oaUf7FQvsdZ700nG8glWnlJH0A
 KXEL4NFKbKguhXEQ8HiRj3bQ4hOEr4ywbgIjoh/+c/IGqpyA0CUn7XXBN
 S+YqNqxvJQmlygzTf/T9uEr5TecvWQ/PKS8pTq3LPPrqt1Rt42h+dqkG3
 FapK560Rb91d2uaAi3BO+ynEYCxGEOUFUvug0XQ72FDtw2aa1Hki48zvr
 Dk4ECzxVEvqLUsAxD41kW5B21kk3J8EUVLck0Xw8K38CQVou9FW0VBIfw
 rxmWmI+OhdyECHg21PXRZDW73RN24BBbSVWHbjCIxmIxYX06e2FzV6lQt g==;
IronPort-SDR: cWr+oxSxknsvFuIVU0trCfgYqhRgI6vabJjIPCW0/ib87/SivWgpGHHpYhs1Yd/QkTshSnI9KP
 qjhYiUY3sw/I2RCC9TIY+aBjy+svRdzrE0AWulQPi3HVEFRR+MU9zU1hKbJqJBD4yJY0+k1EFp
 ukfxmafUqrzkFPbAQwpLk60YeR/Xr7Lqa61seYDL6WZrfKTKSdu801JhOBvNiJ5U8ol48oc2iN
 UuutLYQy8QxHiFLQO8g8b2fH4F4HgzHK1jtJYHWDYQ25pHw5RNlLpKAtgaE9XT98PDeSM6qlJn
 3T4=
X-IronPort-AV: E=Sophos;i="5.73,320,1583164800"; d="scan'208";a="137626685"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 00:27:48 +0800
IronPort-SDR: +n2fw6xHpRGgUOxUj5STLGzGMUpOG9kH+d6usis2y5CBgyerL4ZTUN43OZ9ZMJc7ET6L1N2C2u
 m1SZsoFODy8FcLEu20z1VMUYcS1G6KWO4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 09:18:30 -0700
IronPort-SDR: 6SCtEmM9IE2MY2rMGSFPmvfhONyhBvmubHC+2dLm1rqturdaOz0A63TDjVLJ9dygxibZtc2yZp
 3wWYMu7r6CZA==
WDCIronportException: Internal
Received: from wdthnc17-0189.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.50])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Apr 2020 09:27:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 09/15] target/riscv: Convert MSTATUS MTL to GVA
Date: Sun, 26 Apr 2020 09:19:37 -0700
Message-Id: <94c8a014597c988cd58a01abab5803004beb7e83.1587917657.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1587917657.git.alistair.francis@wdc.com>
References: <cover.1587917657.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=378a396a1=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 12:27:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
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
index 2ac599505f..93df7a896d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -914,6 +914,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -924,6 +933,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                     cause == IRQ_VS_EXT)
                     cause = cause - 1;
                 /* Trap to VS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_GVA, 0);
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
@@ -973,13 +983,15 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index 88cf0ff600..6b6080592a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -380,10 +380,10 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
             MSTATUS_TW;
 #if defined(TARGET_RISCV64)
             /*
-             * RV32: MPV and MTL are not in mstatus. The current plan is to
+             * RV32: MPV and GVA are not in mstatus. The current plan is to
              * add them to mstatush. For now, we just don't support it.
              */
-            mask |= MSTATUS_MTL | MSTATUS_MPV;
+            mask |= MSTATUS_MPV | MSTATUS_GVA;
 #endif
     }
 
@@ -410,7 +410,7 @@ static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
         tlb_flush(env_cpu(env));
     }
 
-    val &= MSTATUS_MPV | MSTATUS_MTL;
+    val &= MSTATUS_MPV | MSTATUS_GVA;
 
     env->mstatush = val;
 
-- 
2.26.2


