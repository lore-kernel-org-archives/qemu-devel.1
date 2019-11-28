Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF7DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C164A2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 14:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C164A2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKU4-0007Zz-OP
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 09:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iaK93-00045l-SR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iaK8z-0006Kn-Dt
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:43 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:59885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iaK8z-0006Au-5O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:47:41 -0500
Received: from player688.ha.ovh.net (unknown [10.108.35.119])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id E433F1B7633
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 14:47:38 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id D8A41C94B45E;
 Thu, 28 Nov 2019 13:47:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/7] target/ppc: Add SPR TBU40
Date: Thu, 28 Nov 2019 14:46:57 +0100
Message-Id: <20191128134700.16091-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134700.16091-1-clg@kaod.org>
References: <20191128134700.16091-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 14986290712008362982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeijedgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.52.147
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spr TBU40 is used to set the upper 40 bits of the timebase
register, present on POWER5+ and later processors.

This register can only be written by the hypervisor, and cannot be read.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu.h                |  1 +
 target/ppc/helper.h             |  1 +
 hw/ppc/ppc.c                    | 13 +++++++++++++
 target/ppc/timebase_helper.c    |  5 +++++
 target/ppc/translate_init.inc.c | 19 +++++++++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 646a94370dba..8ffcfa0ea162 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1312,6 +1312,7 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env);
 void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value);
 target_ulong cpu_ppc_load_hdecr(CPUPPCState *env);
 void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value);
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value);
 uint64_t cpu_ppc_load_purr(CPUPPCState *env);
 void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value);
 uint32_t cpu_ppc601_load_rtcl(CPUPPCState *env);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 356a14d8a639..cd0dfe383a2a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -672,6 +672,7 @@ DEF_HELPER_FLAGS_2(store_decr, TCG_CALL_NO_RWG, void,=
 env, tl)
 DEF_HELPER_FLAGS_1(load_hdecr, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_2(store_hdecr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(store_vtb, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(store_tbu40, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_2(store_hid0_601, void, env, tl)
 DEF_HELPER_3(store_403_pbr, void, env, i32, tl)
 DEF_HELPER_FLAGS_1(load_40x_pit, TCG_CALL_NO_RWG, tl, env)
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 353f11b91d40..3666e58865b3 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -710,6 +710,19 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t va=
lue)
                      &tb_env->vtb_offset, value);
 }
=20
+void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
+{
+    ppc_tb_t *tb_env =3D env->tb_env;
+    uint64_t tb;
+
+    tb =3D cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        tb_env->tb_offset);
+    tb &=3D 0xFFFFFFUL;
+    tb |=3D (value & ~0xFFFFFFUL);
+    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                     &tb_env->tb_offset, tb);
+}
+
 static void cpu_ppc_tb_stop (CPUPPCState *env)
 {
     ppc_tb_t *tb_env =3D env->tb_env;
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 2395295b778c..703bd9ed18b9 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -128,6 +128,11 @@ void helper_store_vtb(CPUPPCState *env, target_ulong=
 val)
     cpu_ppc_store_vtb(env, val);
 }
=20
+void helper_store_tbu40(CPUPPCState *env, target_ulong val)
+{
+    cpu_ppc_store_tbu40(env, val);
+}
+
 target_ulong helper_load_40x_pit(CPUPPCState *env)
 {
     return load_40x_pit(env);
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index a3cf1d8a450c..9815df6f77c8 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -327,6 +327,11 @@ static void spr_write_vtb(DisasContext *ctx, int spr=
n, int gprn)
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
 }
=20
+static void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
+}
+
 #endif
 #endif
=20
@@ -7848,6 +7853,16 @@ static void gen_spr_power5p_ear(CPUPPCState *env)
                  0x00000000);
 }
=20
+static void gen_spr_power5p_tb(CPUPPCState *env)
+{
+    /* TBU40 (High 40 bits of the Timebase register */
+    spr_register_hv(env, SPR_TBU40, "TBU40",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, &spr_write_tbu40,
+                    0x00000000);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 static void spr_write_hmer(DisasContext *ctx, int sprn, int gprn)
 {
@@ -8399,6 +8414,7 @@ static void init_proc_power5plus(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
=20
     /* env variables */
     env->dcache_line_size =3D 128;
@@ -8511,6 +8527,7 @@ static void init_proc_POWER7(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power7_book4(env);
@@ -8652,6 +8669,7 @@ static void init_proc_POWER8(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
@@ -8842,6 +8860,7 @@ static void init_proc_POWER9(CPUPPCState *env)
     gen_spr_power5p_common(env);
     gen_spr_power5p_lpar(env);
     gen_spr_power5p_ear(env);
+    gen_spr_power5p_tb(env);
     gen_spr_power6_common(env);
     gen_spr_power6_dbg(env);
     gen_spr_power8_tce_address_control(env);
--=20
2.21.0


