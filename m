Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0247AC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30C420663
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z+0fZFv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhTZ-0003ta-Sv
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJM-0005eG-Oz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJL-0007QX-HJ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:11:00 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhJL-0006KL-8Y; Fri, 31 Jan 2020 20:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519459; x=1612055459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LmF7Npj7qxhE1CXlTcj+sYe2VYmMpMrbnepOZ6+em5s=;
 b=Z+0fZFv/WickJa1XrB2BtRO6J3+ZTyADD6IxGX40QXYwfuqP4DCP865G
 3ju7m52p9dgLNsApFtUtcZ7d1KFaHdjbJe96n6EwDADGw8doKlf0Wm0Zo
 qvEFjyDUH8NH+oQhW92uvONXGidVh4xrAfodFYaV7YUmWpEMRuxdrI+y7
 coYFkpUwI55fUmiZ//fsFgCHy/n/EaYilUCeIijmD7uM8AEZoI1AhlefE
 YGMElNQ5AUTHM80ZQLVj5fiadT6bhAyJAvsrGXIrV3de4DSXnKgYwI6tK
 e11lpw1QUV+U31lA16b3KHsLFk7aPvHW09nsqwK7BxeBKIr3iRG27pvzV Q==;
IronPort-SDR: SKtLj1K59BJuN+gmCPJCaPvNRIhV+lbfahU89zwbUWYd/oCcY+BtAFUpEKoCsX8j9yCUXld/Lc
 UMUsOIlurFeBSoSXtZQwiPiadrvaFp4hp0hdWJmNyHqg7RCfcATTCg+lQva1+ENxZKrWs9HECm
 xkKg6RS75YtIoRVFDZKdITisCIb1WMJ9HkWW1AcIGPHdj4Lt2UWCjBDTp97Dt8sb5HCIf3JB+K
 MGCoRlmq26f9M+NH/u7d+5A0tBq3/qBuS7WGqAFvir++x80t7OBak9ko4AUaju1mWJyA2tHdiM
 PbA=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872502"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:09:45 +0800
IronPort-SDR: UvToYaJt0SUlVi4jhMBu2Qp53gPgovdhr1hCn/zMNBURMjbU8/9AJ7I0U+u64JkuZy4Tg0BeDQ
 pKkRi9uATstkiAcJBuU0YMR7tMxwfLVaLKhKR1I1fp2WiwnWwwdTT9a32X5zpp7F063Z6lq6Ra
 vKqAThM3z5qMOOVuI8uVQOZWfx5lzDpo5JSd/VC6AUvvbm/Wk5eIc2gcSBFWej8ceMqnYKTqOk
 LvYndneo8vR6ZekEKyu5vVpKij3i0U30Cz0P8lD1Ob/LF1CcwaPqdvcoJZdvGaAkXyIue0a7fI
 0mq+y1+/SFlDA+hCeuNPdqlV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:02:53 -0800
IronPort-SDR: g7O3Wgu2kCXv6qIvc2W1102glPZ4yrdZS4eJBjHKzoA52EgVDdftNHfMu+vH9ZCmD+YEsyJU2o
 MQaGosWPXyd3/3cYdnCDT71lXjWMoszprJp/ptY+zgdPbabrhXow8xVB2XePQBqcfZxcqbAPuj
 wTh5h96bgN4LK1LZOOhLIP4kZYMUBoLmtKpCJkjF/kD5SwW/59E0Ho+++j+wIBnKmjFEO1LaiY
 8t/JviT/W1CqRYAV5rr4FIbHRxjUfjJ2zrOWdU34H8Y/Ym7bA/IqSOwGf+zl5tNwO0m2axXa7j
 +V8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2020 17:09:44 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 34/35] target/riscv: Add the MSTATUS_MPV_ISSET helper macro
Date: Fri, 31 Jan 2020 17:03:08 -0800
Message-Id: <cf7a5eeb1933140143ef236ccd086eff12bcab44.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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

Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/cpu_bits.h   | 11 +++++++++++
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/op_helper.c  |  2 +-
 target/riscv/translate.c  |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 049032f2ae..7f64ee1174 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -363,8 +363,19 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
+#if defined(TARGET_RISCV64)
 #define MSTATUS_MTL         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#elif defined(TARGET_RISCV32)
+#define MSTATUS_MTL         0x00000040
+#define MSTATUS_MPV         0x00000080
+#endif
+
+#ifdef TARGET_RISCV32
+# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatush, MSTATUS_MPV)
+#else
+# define MSTATUS_MPV_ISSET(env)  get_field(env->mstatus, MSTATUS_MPV)
+#endif
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e04545adf7..b9e90dfd9a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -322,7 +322,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             mode = get_field(env->mstatus, MSTATUS_MPP);
 
             if (riscv_has_ext(env, RVH) &&
-                get_field(env->mstatus, MSTATUS_MPV)) {
+                MSTATUS_MPV_ISSET(env)) {
                 use_background = true;
             }
         }
@@ -720,7 +720,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         m_mode_two_stage = env->priv == PRV_M &&
                            access_type != MMU_INST_FETCH &&
                            get_field(env->mstatus, MSTATUS_MPRV) &&
-                           get_field(env->mstatus, MSTATUS_MPV);
+                           MSTATUS_MPV_ISSET(env);
 
         hs_mode_two_stage = env->priv == PRV_S &&
                             !riscv_cpu_virt_enabled(env) &&
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dca68fa96e..8736f689c2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
+    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 240fd7c971..ae8818efb3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -752,7 +752,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
         if (env->priv_ver == PRV_M &&
             get_field(env->mstatus, MSTATUS_MPRV) &&
-            get_field(env->mstatus, MSTATUS_MPV)) {
+            MSTATUS_MPV_ISSET(env)) {
             ctx->virt_enabled = true;
         } else if (env->priv == PRV_S &&
                    !riscv_cpu_virt_enabled(env) &&
-- 
2.25.0


