Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E5EC433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 20:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721F5206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 20:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=leostella.onmicrosoft.com header.i=@leostella.onmicrosoft.com header.b="fe8uv1ij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721F5206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leostella.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzRFk-0005vr-Js
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 16:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzQLT-0002ed-TS; Sat, 25 Jul 2020 16:00:35 -0400
Received: from mail-bn3usg02on0098.outbound.protection.office365.us
 ([23.103.208.98]:19040 helo=USG02-BN3-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu.bucchianeri@leostella.com>)
 id 1jzQLQ-0006YD-TN; Sat, 25 Jul 2020 16:00:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=B1TgMPWM1D/mr/+PF6dpPBkNFb3D/fXIbwkFdexs1pbrzrBTc1rhMTOETHRDK5HG1kdrl+CHt+BWNl9JiQhocjpPfN7fjSW4STXE50RzsAAVXExo8ivZ5W0N11kiqxPQO9YWBj+WxUqK7HxEMNaAHbdry5IXtCZ/3LSDTjAcWPN+HdZLr4oolz7zApxKj30t3l/RZjGho1EdnVVM3LECq9bXadJgB5xjcXuI2leopHRndUkfn/nRLWYfuQTEZOcQkAVtZWmnVZsOsdrAgTgva4waxLaAtQ2Vi/CiYtzRs1yYblv8/M2ZUkhNvUVRlOX/Qcm/K/q+W5lks4oI1uyCBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt5AQ8wS4DMxclpl3bNByC7RTcaX5A84YDwZ/yMsojE=;
 b=o2KI8CSpYvF0aq8XLRVAKF6+YiVnweR5VJSvRUd0cNkzh5WqC6S0BrV3BwEXeCyZBvziFT5I1AIGbTyyQVSz8vowYrGRHuLro6UIW/n0GcfwVGat3xpsR4wzqA74xaiT5L/ZYD284iFYW7b7ZJleV6R6keKJTJ1rkut3Ntql2EPYzGIddtHEF/QvdOFwI70kY0HSqYpZuJbRTkKWmRJBvyq2jXBpnZFioJCBu2SUT74FjgtpPp8a59UxKGAftiFTwU4pitZocYp/RF3xmffkt63TbYLT4RUIosC3onRdNnWN0i3Fo/JlWDC7AkemtKoJueErl2tITKtsATgyrHBBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leostella.com; dmarc=pass action=none
 header.from=leostella.com; dkim=pass header.d=leostella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leostella.onmicrosoft.com; s=selector1-leostella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt5AQ8wS4DMxclpl3bNByC7RTcaX5A84YDwZ/yMsojE=;
 b=fe8uv1ijeNTvpswXmQxRahTJIV+K6hLKTo+PElBMP9KKMsnt4in7gZA889XGSY407gBMIIKsDpOCBCiJmxGXiGONcwF7ZTWFHBLp3kuvQUxeKqOCR4jyVRkSi6ogoMiUc2uDJA/i2XNCREmk5NjD7JUNVoixugm7JI8o+zLqxr8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=leostella.com;
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:41c::10)
 by SN5P110MB0365.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:419::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Sat, 25 Jul
 2020 19:15:00 +0000
Received: from SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2]) by SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 ([fe80::d0e1:84ad:f42:f6f2%5]) with mapi id 15.20.3195.029; Sat, 25 Jul 2020
 19:15:00 +0000
From: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Date: Sat, 25 Jul 2020 12:14:36 -0700
Message-Id: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: DM3P110CA0022.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:410::20) To SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
 (2001:489a:200:41c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bd1.hsd1.wa.comcast.net (2601:601:f01:e820:349c:f32e:2333:ec4c)
 by DM3P110CA0022.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:410::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.26 via Frontend
 Transport; Sat, 25 Jul 2020 19:14:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2601:601:f01:e820:349c:f32e:2333:ec4c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5dbd490-585c-4502-87e3-08d830cf0685
X-MS-TrafficTypeDiagnostic: SN5P110MB0365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN5P110MB036532C4F31A40337641057284740@SN5P110MB0365.NAMP110.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(508600001)(107886003)(6666004)(6512007)(2906002)(1076003)(83380400001)(966005)(36756003)(5660300002)(52116002)(186003)(16526019)(2616005)(66476007)(66556008)(66946007)(8936002)(6506007)(6486002)(86362001)(4326008)(8676002)(44832011)(131093003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: leostella.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dbd490-585c-4502-87e3-08d830cf0685
X-MS-Exchange-CrossTenant-AuthSource: SN5P110MB0543.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 19:15:00.0562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dbc51146-ab26-404b-9c4b-cce4f3331cc5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN5P110MB0365
Received-SPF: pass client-ip=23.103.208.98;
 envelope-from=matthieu.bucchianeri@leostella.com;
 helo=USG02-BN3-obe.outbound.protection.office365.us
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 16:00:30
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Jul 2020 16:57:53 -0400
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
 target/ppc/translate/spe-impl.inc.c | 101 ++++++++++++++++++----------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe=
-impl.inc.c
index 36b4d5654d..2e6e799a25 100644
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
@@ -531,8 +562,13 @@ static inline void gen_evmwsmia(DisasContext *ctx)

 static inline void gen_evmwsmiaa(DisasContext *ctx)
 {
-    TCGv_i64 acc =3D tcg_temp_new_i64();
-    TCGv_i64 tmp =3D tcg_temp_new_i64();
+    TCGv_i64 acc;
+    TCGv_i64 tmp;
+
+    if (unlikely(!ctx->spe_enabled)) {
+        gen_exception(ctx, POWERPC_EXCP_SPEU);
+        return;
+    }

     gen_evmwsmi(ctx);           /* rD :=3D rA * rB */

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

