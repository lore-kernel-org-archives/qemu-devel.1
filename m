Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E5FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1A582077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BT3PQcg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1A582077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNsm-0007NF-F9
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbr-0000Al-Si
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbq-00085F-O6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:18:15 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7465)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbq-0007jP-DT; Mon, 09 Dec 2019 13:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915537; x=1607451537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1ouQpgA8fZ9f6S2wb+mbdq45UesV7oRMMM1YCyNY++4=;
 b=BT3PQcg3knJsoSF+xzAnOm7oABROop7QH4y+2/KPYpxT+5FTKSKoSTKj
 0R9GZh/yHXWzD12b4Wc4VKrJCTEHgSyWQ0RIQYmWR6IgqTc8KLKgA6DA2
 Z9Uakb4PN/P+uHnY9JnrrH2WsIE6sq3rBxuLQjO2Ft0u2z1ZIbq8cN/PC
 3soV/eY66S9L5y35wLAmDjsMnABhb44HEJ6r32Zs3uND7nB8fpNwgdrMD
 QkJEMKiWgYAz1kSdQxg24W4icBTZfPL2d9MRVEEVSzgOMzvqjAesL1d4d
 MXY4wCbUNXqKADGaYSIJh3cLAJ+TSiUUN+SeFIuDMHVPjL66OU0anUU9n g==;
IronPort-SDR: VFsv6ynyaJh5TOHFhoB9OQbzVg3QH/Lt3dnKgYopNPxY42pL47vXkevChu76HJRGaqn9ZWXlyM
 w4HgF4MxfCpb8G4cU7d4O4s18tHJdunsMHJ92KCiWjXh3gThH99bkBUh4mYx6W9R6rbJPaZ99F
 OQeMZ74lMPS1sx8qtTK63JAWLLLT4fy/BeFHUkmyy7eNYPAw4m2194AY7+GUPvbzklt/uBPmNj
 z5bjXM0Oc0BtWbrYj3229NrJ5H9cFPChfYM33L0C3FCG71t/YwJ7ehDIN5Tx6yHqUOZdR2FGsR
 Z7U=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412050"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:18:26 +0800
IronPort-SDR: mo68rGo+VqdWrKGqp6RpZ/nvo73QpXyV72qncu5aPO/BiuEeZ3u/dPG61AHTf/Q6Kylr2qcBpe
 Gbz4ethYc2H0UOxAKdKmiIo2PqPaIOam4XCz3Ug3aMRCV98/XeCrfhRlYz1PaxTWVfWcJZR7v7
 YsVMH3t/9Iy0MRA5uRFbSlEIhCcHvxf84i5tFDoE/IpI+AY10jO2naP4QmU11cx55ByRnXucZE
 dUA4zR2iR1By9h1ANW8j+S4KwM741eM5U9rbohBZAKOAqk2Zg3xjSFONFP7yv2J2rCHjUMPEuV
 8rheMmEn8rOMI1lsaQALs9IO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:31 -0800
IronPort-SDR: jAHq7t2Lg7iHN1HtyvQjhofvYry567n3EQA2RQPmCjLYc7tRDSMzDktJRYKp4HS3Gk4l7yuMZk
 XOJnLv9TdFz5PKRPzT9JCQn9kSB/D2OpOv576SFDAAbeB6zxS9lOLbreych0xj6THDib0vY3R7
 27hFbk7eULM/oFpqxbNnyfYtOMO1KYsQgYa2y4nEFIUMMp27GMA750ri/4QZ0F17BAF9gZQg2v
 x8obGCBoQmFoShHSihe+TeYnIac32snWin7MaOjz6CwyVjCk0OYMC/Qqw7Ggd2LcwQdyaO4z7s
 Cak=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:54 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 35/36] target/riscv: Add the MSTATUS_MPV_ISSET helper macro
Date: Mon,  9 Dec 2019 10:12:12 -0800
Message-Id: <c6b8c2739278b63e5e03c2a2095254fa0afedbda.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
---
 target/riscv/cpu_bits.h   | 11 +++++++++++
 target/riscv/cpu_helper.c |  4 ++--
 target/riscv/op_helper.c  |  2 +-
 target/riscv/translate.c  |  2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 049032f2ae..dd012a514e 100644
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
+# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatush, MSTATUS_MPV)
+#else
+# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatus, MSTATUS_MPV)
+#endif
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c2ad0bbce7..7166e6199e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -314,7 +314,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             mode = get_field(*env->mstatus, MSTATUS_MPP);
 
             if (riscv_has_ext(env, RVH) &&
-                get_field(*env->mstatus, MSTATUS_MPV)) {
+                MSTATUS_MPV_ISSET(env)) {
                 use_background = true;
             }
         }
@@ -714,7 +714,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         m_mode_two_stage = env->priv == PRV_M &&
                            access_type != MMU_INST_FETCH &&
                            get_field(*env->mstatus, MSTATUS_MPRV) &&
-                           get_field(*env->mstatus, MSTATUS_MPV);
+                           MSTATUS_MPV_ISSET(env);
 
         hs_mode_two_stage = env->priv == PRV_S &&
                             !riscv_cpu_virt_enabled(env) &&
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index a0a631d722..b0b9890a15 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
 
     target_ulong mstatus = *env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
-    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
+    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
     mstatus = set_field(mstatus,
         env->priv_ver >= PRIV_VERSION_1_10_0 ?
         MSTATUS_MIE : MSTATUS_UIE << prev_priv,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index dd93e12b45..0a28f208a2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -752,7 +752,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
         if (env->priv_ver == PRV_M &&
             get_field(*env->mstatus, MSTATUS_MPRV) &&
-            get_field(*env->mstatus, MSTATUS_MPV)) {
+            MSTATUS_MPV_ISSET(env)) {
             ctx->virt_enabled = true;
         } else if (env->priv == PRV_S &&
                    !riscv_cpu_virt_enabled(env) &&
-- 
2.24.0


