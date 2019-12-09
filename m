Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F206C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1063207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i/WhW1yd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1063207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNtj-0000PE-5A
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb3-0007iH-8c
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb1-0007am-Mk
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb1-0007aD-Eu; Mon, 09 Dec 2019 13:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915443; x=1607451443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IycmilN1P4zdLVNS81S76S54ZxRSpj6iUkohzNbbz80=;
 b=i/WhW1ydeMQ/ogH1oJujM8FKu9qIJP7dNj0cyNOc85n5BbET2NPUt9tz
 f/+6lUNveT9X/1DSFYRcrFSFT2QtilX58MAa5wsrkPYiOk8eVAVQ83/gg
 Ii4tsbybjiNaTVWw5FnrZhiFe3zL1d++UgJYK6l3nTUXIahyHLvfmHi5+
 fogJzdJu6v/VLcwPd4GPyupp8pnXnhSkdlOQgg0gMdSSlg/yc+1DpKPRO
 skdgwgMtymKq7W5kzRkNWOPoNKVRL2JeZzxpa9Fa991D9GczrqkB5Lr0c
 qGjE7sDlt7MhbHFDG0G54oOSZ8FBj6G5CF6QZ3mnHn2VUNP9cFEDUiGfQ Q==;
IronPort-SDR: aQ8c1cm0ah4SYMPSxnNpP+ygoOLEUZK/tk9nZ4RGyngUC6tNHN9baW0tt1zB3Afhz5R2HyNoT+
 FxNTkg01nxobDrgOj+CTw/XM4xCwWgLSFaTwCYQ25A7SGc3GpxP86s3s/NkVZ9jJ7bVqm79BXr
 LtFNgRaXsmCN+t+i5j7j2iem0aieVZPlBCOv24MlNx75IRlfFzBo4WZ4LQhiOIIsd2rj00swaz
 nCdTK4dWyemZAmv2d2bWKa0xYeGDqgHwQrimI4OMNIBbX+xmOQYSujh9VkWWIiOhxg7Vu67+PO
 Ons=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="124925583"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:22 +0800
IronPort-SDR: k18Gk9h70Et/nCBgQ+rFaV1JQUJ10GKQnHZFD74p6pr5bh8ax2ANXFsgHmBEkhF2f6Nc8Gorld
 wOzE3j6f0NYPHWfwLZGvUiU1JBNYMVUyLDQbV+UmmpkulroLOoGm0Ber16eRxBlQr4w4w0Dm82
 bypXQhXbkF4DIfL/r/YgWTc9Ma9SjW5r3264x89SxAB2EHCFHESugWhyeCbXSH9NLkh6gtaSBR
 otIdaRvstShFen9gbB7fnYtXzILizqGCx7kIiBFpKnP/v9e5zFWcfWhXqH8NiO5G2+sUjUq8Ay
 qu/ExcK3IAQDaSC/yKegfslM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:00 -0800
IronPort-SDR: pkopMyrvo5GY3QgwgFf36cG9LfovaTuyCQ7GrsOMA771Q411R8o0at7p2qJjmETJcFdSExlWnU
 NHDGbMeo5E6zRmGL/VjTjdXoptHbrID83aHOow7sajRv0Qsi2W8jUd9yT9RbjtV3joEKwOGc3W
 bw9NsJMEIKWxZlvqKeJyuEN0Viv7obJ1us2MMHRLaFblhXmSVPUtsgkBildg82PZ+fvCROUv2l
 aU3IdPKrR7fzXbImxgNaf8qPQ8w0DAMWTH2PiPLj5NpZcB2fiqT65PmxqA4IuVjhAqs4lI0kZb
 W6Y=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:23 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 23/36] target/riscv: Add hypvervisor trap support
Date: Mon,  9 Dec 2019 10:11:40 -0800
Message-Id: <f3bdee4a9bee10980939c37968aa45b406824e48.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 65 +++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 1b747abf93..2c6d2bc3a3 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -641,6 +641,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    target_ulong s;
 
     /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
      * so we mask off the MSB and separate into trap type and cause.
@@ -650,13 +651,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong deleg = async ? env->mideleg : env->medeleg;
     target_ulong tval = 0;
 
-    static const int ecall_cause_map[] = {
-        [PRV_U] = RISCV_EXCP_U_ECALL,
-        [PRV_S] = RISCV_EXCP_S_ECALL,
-        [PRV_H] = RISCV_EXCP_VS_ECALL,
-        [PRV_M] = RISCV_EXCP_M_ECALL
-    };
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
@@ -680,7 +674,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         /* ecall is dispatched as one cause so translate based on mode */
         if (cause == RISCV_EXCP_U_ECALL) {
             assert(env->priv <= 3);
-            cause = ecall_cause_map[env->priv];
+
+            if (env->priv == PRV_M) {
+                cause = RISCV_EXCP_M_ECALL;
+            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_VS_ECALL;
+            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
+                cause = RISCV_EXCP_S_ECALL;
+            } else if (env->priv == PRV_U) {
+                cause = RISCV_EXCP_U_ECALL;
+            }
         }
     }
 
@@ -690,7 +693,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     if (env->priv <= PRV_S &&
             cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
         /* handle the trap in S-mode */
-        target_ulong s = *env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
+
+            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
+                !riscv_cpu_force_hs_excep_enabled(env)) {
+                /* Trap to VS mode */
+            } else if (riscv_cpu_virt_enabled(env)) {
+                /* Trap into HS mode, from virt */
+                riscv_cpu_swap_hypervisor_regs(env);
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(*env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+
+                riscv_cpu_set_virt_enabled(env, 0);
+                riscv_cpu_set_force_hs_excep(env, 0);
+            } else {
+                /* Trap into HS mode */
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
+                                         get_field(env->hstatus, HSTATUS_SPV));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                                         get_field(*env->mstatus, SSTATUS_SPP));
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                         riscv_cpu_virt_enabled(env));
+            }
+        }
+
+        s = *env->mstatus;
         s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_SPP, env->priv);
@@ -704,7 +736,20 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         riscv_cpu_set_mode(env, PRV_S);
     } else {
         /* handle the trap in M-mode */
-        target_ulong s = *env->mstatus;
+        if (riscv_has_ext(env, RVH)) {
+            if (riscv_cpu_virt_enabled(env)) {
+                riscv_cpu_swap_hypervisor_regs(env);
+            }
+            *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
+                                      riscv_cpu_virt_enabled(env));
+            *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
+                                      riscv_cpu_force_hs_excep_enabled(env));
+
+            /* Trapping to M mode, virt is disabled */
+            riscv_cpu_set_virt_enabled(env, 0);
+        }
+
+        s = *env->mstatus;
         s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
             get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
         s = set_field(s, MSTATUS_MPP, env->priv);
-- 
2.24.0


