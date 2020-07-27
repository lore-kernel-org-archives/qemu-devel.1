Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6400C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E262070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=leostella.onmicrosoft.com header.i=@leostella.onmicrosoft.com header.b="dfDVZxQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E262070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leostella.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07NS-0001jx-KQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1k07Me-00011K-KK; Mon, 27 Jul 2020 13:56:40 -0400
Received: from mail-bn3usg02on0127.outbound.protection.office365.us
 ([23.103.208.127]:1729 helo=USG02-BN3-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1k07Mb-0007TE-At; Mon, 27 Jul 2020 13:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=jmCK1cY4VCIH8BzczjU7L2M5EcosL8GCnj50v9xnUOle2CVMKPqylcGRr7h6djdDPa1euG7pAh8I4gflSe+HIGSlGebyU0t0UQKTefCwF36Y8rP81ghnZYAUjQNAS9/nPAlz6vD9Rnjd0C4qcqDQ7qQdyxD6xBlybz7SqGeVxUz2vZbBJOF+hoTPHP/t/GG1xd++00syJuI5tiwR2/AsfkW5QAIv1pZvnN4920SWtA/5IeiN64ZQiti2OweDjtqVTQt3LDi8faRF4zN8LlpF8lrzLQvubF7UwgrVY6AkYy/s0IIiF+AlvRwQWhy3LQBSDh5SGqvMzLxiofXHZagoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHDTPm7TelKdb6MtQIUoiXd44OshT9gIJirX0vbtNas=;
 b=dI+BVM7tP054Gsu2gJXoLVOsj0Q+Ny21T0kTwb/IcKit9ya3yn7+fHga/esbSA+Sy+OJobigebQXKxh8VHu+8CJF3M+kyU6ic9GRB+9ExXTwLs44L+LJQjJ2vIu/hB1i7d4P+2/j+vvUjQP1EFFbClhuozdDIkHPgY8ggdi4ascW29tOqMdYReTLRAr0ZpWCzF2p3IgcogZ2CGgXn7p/8R3gsCyJ4jAKjJYtUuV/LUiZ4YW44DOMzvaldUZd1FNcmqv7cRzD1NO7qC5TBrhO6F34nH5HN5E5Mu9zLiVWjSg1Nwj794MWq2w9oRlk7b4B/sD/MFcnDVgXRNMCWqaE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leostella.com; dmarc=pass action=none
 header.from=leostella.com; dkim=pass header.d=leostella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leostella.onmicrosoft.com; s=selector1-leostella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHDTPm7TelKdb6MtQIUoiXd44OshT9gIJirX0vbtNas=;
 b=dfDVZxQsmuJMD6ihNPL3ISQKm+8Tv7TEEAwla+52DMPR7Eq828phrOCq6zMhH3V4DWIl6s2bnW04Jj/YTt4wKZstduFZMstUY+r49RFKen5E6tKTzHzmbnVYjlJiegrj7YWOaXjTGW8gh6ymTpA2WEMJ4vnkeWmxoX4wXptpd5g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=leostella.com;
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::10)
 by SN5P110MB0350.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:419::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Mon, 27 Jul
 2020 17:56:28 +0000
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2]) by SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2%5]) with mapi id 15.20.3216.031; Mon, 27 Jul 2020
 17:56:28 +0000
From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2] target/ppc: Fix SPE unavailable exception triggering
Date: Mon, 27 Jul 2020 10:55:53 -0700
Message-Id: <20200727175553.32276-1-matthieu.bucchianeri@leostella.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SN5P110CA0006.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:418::16) To SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:41c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bd1.leostella.local (73.109.75.102) by
 SN5P110CA0006.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:418::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.28 via Frontend Transport; Mon, 27 Jul 2020 17:56:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [73.109.75.102]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b93c87eb-2764-4478-382c-08d832566312
X-MS-TrafficTypeDiagnostic: SN5P110MB0350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN5P110MB0350E2D6E017CD151931FE6484720@SN5P110MB0350.NAMP110.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(16526019)(1076003)(2616005)(107886003)(52116002)(5660300002)(508600001)(6512007)(36756003)(956004)(6486002)(6666004)(83380400001)(86362001)(44832011)(966005)(2906002)(8936002)(66556008)(4326008)(8676002)(6506007)(66476007)(186003)(26005)(66946007)(131093003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: leostella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93c87eb-2764-4478-382c-08d832566312
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 17:56:28.5619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dbc51146-ab26-404b-9c4b-cce4f3331cc5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN5P110MB0350
Received-SPF: pass client-ip=23.103.208.127;
 envelope-from=matthieu.bucchianeri@leostella.com;
 helo=USG02-BN3-obe.outbound.protection.office365.us
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 13:56:35
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When emulating certain floating point instructions or vector instructions o=
n
PowerPC machines, QEMU did not properly generate the SPE/Embedded Floating-
Point Unavailable interrupt. See the buglink further below for references t=
o
the relevant NXP documentation.

This patch fixes the behavior of some evfs* instructions that were
incorrectly emitting the interrupt.

More importantly, this patch fixes the behavior of several efd* and ev*
instructions that were not generating the interrupt. Triggering the
interrupt for these instructions fixes lazy FPU/vector context switching on
some operating systems like Linux.

Without this patch, the result of some double-precision arithmetic could be
corrupted due to the lack of proper saving and restoring of the upper
32-bit part of the general-purpose registers.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888918
Buglink: https://bugs.launchpad.net/qemu/+bug/1611394
Signed-off-by: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
---
v2:
  Split out fix for TCG leak in gen_evmwsmiaa().

Based-on: <20200727172114.31415-1-matthieu.bucchianeri@leostella.com>
([PATCH] target/ppc: Fix TCG leak with the evmwsmiaa instruction)

target/ppc/translate/spe-impl.inc.c | 97 +++++++++++++++++++----------
 1 file changed, 64 insertions(+), 33 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe=
-impl.inc.c
index 42a0d1cffb..2e6e799a25 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -349,14 +349,24 @@ static inline void gen_evmergelohi(DisasContext *ctx)
 }
 static inline void gen_evsplati(DisasContext *ctx)
 {
-    uint64_t imm =3D ((int32_t)(rA(ctx->opcode) << 27)) >> 27;
+    uint64_t imm;
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+    imm =3D ((int32_t)(rA(ctx->opcode) << 27)) >> 27;

     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
 }
 static inline void gen_evsplatfi(DisasContext *ctx)
 {
-    uint64_t imm =3D rA(ctx->opcode) << 27;
+    uint64_t imm;
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+    imm =3D rA(ctx->opcode) << 27;

     tcg_gen_movi_tl(cpu_gpr[rD(ctx->opcode)], imm);
     tcg_gen_movi_tl(cpu_gprh[rD(ctx->opcode)], imm);
@@ -389,21 +399,37 @@ static inline void gen_evsel(DisasContext *ctx)

 static void gen_evsel0(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }

 static void gen_evsel1(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }

 static void gen_evsel2(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }

 static void gen_evsel3(DisasContext *ctx)
 {
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
     gen_evsel(ctx);
 }

@@ -518,6 +544,11 @@ static inline void gen_evmwsmia(DisasContext *ctx)
 {
     TCGv_i64 tmp;

+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+
     gen_evmwsmi(ctx);            /* rD :=3D rA * rB */

     tmp =3D tcg_temp_new_i64();
@@ -534,6 +565,11 @@ static inline void gen_evmwsmiaa(DisasContext *ctx)
     TCGv_i64 acc;
     TCGv_i64 tmp;

+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }
+
     gen_evmwsmi(ctx);           /* rD :=3D rA * rB */

     acc =3D tcg_temp_new_i64();
@@ -892,8 +928,14 @@ static inline void gen_##name(DisasContext *ctx)      =
                        \
 #define GEN_SPEFPUOP_CONV_32_64(name)                                     =
    \
 static inline void gen_##name(DisasContext *ctx)                          =
    \
 {                                                                         =
    \
-    TCGv_i64 t0 =3D tcg_temp_new_i64();                                   =
      \
-    TCGv_i32 t1 =3D tcg_temp_new_i32();                                   =
      \
+    TCGv_i64 t0;                                                          =
    \
+    TCGv_i32 t1;                                                          =
    \
+    if (unlikely(!ctx->spe_enabled)) {                                    =
    \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                            =
    \
+        return;                                                           =
    \
+    }                                                                     =
    \
+    t0 =3D tcg_temp_new_i64();                                            =
      \
+    t1 =3D tcg_temp_new_i32();                                            =
      \
     gen_load_gpr64(t0, rB(ctx->opcode));                                  =
    \
     gen_helper_##name(t1, cpu_env, t0);                                   =
    \
     tcg_gen_extu_i32_tl(cpu_gpr[rD(ctx->opcode)], t1);                    =
    \
@@ -903,8 +945,14 @@ static inline void gen_##name(DisasContext *ctx)      =
                        \
 #define GEN_SPEFPUOP_CONV_64_32(name)                                     =
    \
 static inline void gen_##name(DisasContext *ctx)                          =
    \
 {                                                                         =
    \
-    TCGv_i64 t0 =3D tcg_temp_new_i64();                                   =
      \
-    TCGv_i32 t1 =3D tcg_temp_new_i32();                                   =
      \
+    TCGv_i64 t0;                                                          =
    \
+    TCGv_i32 t1;                                                          =
    \
+    if (unlikely(!ctx->spe_enabled)) {                                    =
    \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                            =
    \
+        return;                                                           =
    \
+    }                                                                     =
    \
+    t0 =3D tcg_temp_new_i64();                                            =
      \
+    t1 =3D tcg_temp_new_i32();                                            =
      \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                   =
    \
     gen_helper_##name(t0, cpu_env, t1);                                   =
    \
     gen_store_gpr64(rD(ctx->opcode), t0);                                 =
    \
@@ -914,7 +962,12 @@ static inline void gen_##name(DisasContext *ctx)      =
                        \
 #define GEN_SPEFPUOP_CONV_64_64(name)                                     =
    \
 static inline void gen_##name(DisasContext *ctx)                          =
    \
 {                                                                         =
    \
-    TCGv_i64 t0 =3D tcg_temp_new_i64();                                   =
      \
+    TCGv_i64 t0;                                                          =
    \
+    if (unlikely(!ctx->spe_enabled)) {                                    =
    \
+        gen_exception(ctx, POWERPC_EXCP_SPEU);                            =
    \
+        return;                                                           =
    \
+    }                                                                     =
    \
+    t0 =3D tcg_temp_new_i64();                                            =
      \
     gen_load_gpr64(t0, rB(ctx->opcode));                                  =
    \
     gen_helper_##name(t0, cpu_env, t0);                                   =
    \
     gen_store_gpr64(rD(ctx->opcode), t0);                                 =
    \
@@ -923,13 +976,8 @@ static inline void gen_##name(DisasContext *ctx)      =
                        \
 #define GEN_SPEFPUOP_ARITH2_32_32(name)                                   =
    \
 static inline void gen_##name(DisasContext *ctx)                          =
    \
 {                                                                         =
    \
-    TCGv_i32 t0, t1;                                                      =
    \
-    if (unlikely(!ctx->spe_enabled)) {                                    =
    \
-        gen_exception(ctx, POWERPC_EXCP_SPEU);                            =
    \
-        return;                                                           =
    \
-    }                                                                     =
    \
-    t0 =3D tcg_temp_new_i32();                                            =
      \
-    t1 =3D tcg_temp_new_i32();                                            =
      \
+    TCGv_i32 t0 =3D tcg_temp_new_i32();                                   =
      \
+    TCGv_i32 t1 =3D tcg_temp_new_i32();                                   =
      \
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                   =
    \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                   =
    \
     gen_helper_##name(t0, cpu_env, t0, t1);                               =
    \
@@ -958,13 +1006,8 @@ static inline void gen_##name(DisasContext *ctx)     =
                         \
 #define GEN_SPEFPUOP_COMP_32(name)                                        =
    \
 static inline void gen_##name(DisasContext *ctx)                          =
    \
 {                                                                         =
    \
-    TCGv_i32 t0, t1;                                                      =
    \
-    if (unlikely(!ctx->spe_enabled)) {                                    =
    \
-        gen_exception(ctx, POWERPC_EXCP_SPEU);                            =
    \
-        return;                                                           =
    \
-    }                                                                     =
    \
-    t0 =3D tcg_temp_new_i32();                                            =
      \
-    t1 =3D tcg_temp_new_i32();                                            =
      \
+    TCGv_i32 t0 =3D tcg_temp_new_i32();                                   =
      \
+    TCGv_i32 t1 =3D tcg_temp_new_i32();                                   =
      \
                                                                           =
    \
     tcg_gen_trunc_tl_i32(t0, cpu_gpr[rA(ctx->opcode)]);                   =
    \
     tcg_gen_trunc_tl_i32(t1, cpu_gpr[rB(ctx->opcode)]);                   =
    \
@@ -1074,28 +1117,16 @@ GEN_SPEFPUOP_ARITH2_32_32(efsmul);
 GEN_SPEFPUOP_ARITH2_32_32(efsdiv);
 static inline void gen_efsabs(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                     (target_long)~0x80000000LL);
 }
 static inline void gen_efsnabs(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                    0x80000000);
 }
 static inline void gen_efsneg(DisasContext *ctx)
 {
-    if (unlikely(!ctx->spe_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_SPEU);
-        return;
-    }
     tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
                     0x80000000);
 }
--
2.17.1

LeoStella, LLC
A joint venture of Thales Alenia Space and Spaceflight Industries

12501 E Marginal Way S =E2=80=A2 Tukwila, WA 98168

Proprietary Document: This document may contain trade secrets or otherwise =
proprietary and confidential information owned by LeoStella LLC. It is inte=
nded only for the individual addressee and may not be copied, distributed, =
or otherwise disclosed without LeoStella LLC express prior written authoriz=
ation.
Export Controlled: This document may contain technical data whose export is=
 restricted by the Arms Export Control Act (Title 22, U.S.C., Sec 2751 et s=
eq.) or the Export Administration Act of 1979, as amended, Title 50,U.S.C.,=
 app 2401 et seq. Violation of these export laws are subject to severe crim=
inal penalties. Recipient shall not export, re-export, or otherwise transfe=
r or share this document to any foreign person (as defined by U.S. export l=
aws) without advance written authorization from LeoStella LLC.

