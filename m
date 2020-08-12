Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D06C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECFE20658
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LRPKjIxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECFE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wSf-0000Pp-Bm
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLY-00053N-MZ; Wed, 12 Aug 2020 15:23:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLW-0000Qu-Ng; Wed, 12 Aug 2020 15:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260215; x=1628796215;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sgOyLkhLmD+vx2DwarIMU5m8PvXjjcCG07p8bd0Fzks=;
 b=LRPKjIxwlAW51OAjryjuTD0952yp7W4UymvzA2R9rEyYZv4IxGuXnqtb
 BDJvRrH4IyA7wgyIVM67j++ka8QqI1attWjQcL3yIHsjyc+p4OUr2OU9Y
 FVukmizSzZUkSKrFN7lgCm/TyU0eb8LbL7s/rgUsupploZKii9VlaspI7
 QFH41f3P64x+XOB5MQXTerUPWd3npBd41c6MRmzD6zyF6uevBdSwZF3bu
 bAbpmw/gEh17Nf13Kg5jzOYcgWQei5H8Rc4R3/dyvHftBKRJMnyIOhzWe
 9z192tJUVvRlxYyzBItQi+X3oQ/EGpJ5kPox43HlukTLc4fOjOzAmWB67 A==;
IronPort-SDR: bq9IBVh/OzjHV6moGulsoBFDvDExxxezMRyoM+vcqK+NP8+fuPvAmf9HMe87f95XaX3Lpr5XCR
 S+jyVbC4exv2JCAOTOSHwoTjzqhZAARFM+Xwn4/zEQ13+jm4FUPnPmWEyRlRKAFgjlG71XhwLm
 S7BM1PLQTnhkW4uLMdofa4Aue8WjTVkDA5rbg4nihDaAvoPlGLIgucYKoIauYQKE5faqI3j6kF
 uaqJjp4S72tBcO6qGZNRzajpQgmdyQ63726+oCwVvD5USCRgV7k//xir+JCiQB0wheODnDPTjP
 JGU=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029207"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:34 +0800
IronPort-SDR: lp6BIsHYS0PPJq8a229N33K1QzQSsPK370GCCcC8ztLtORYpPJmNtBF1Gb+e6R8BupztYYOlr7
 uYg/j0yI9wZg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:41 -0700
IronPort-SDR: HxFbRqBpgc3yX0nYobIkwhglqese/yCQBH8mVohhWU+LOBsOFbQbUA5FXliA0JLFPhrVW6Oc8v
 KWndJ3aClAJQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 07/13] target/riscv: Update the Hypervisor trap return/entry
Date: Wed, 12 Aug 2020 12:13:33 -0700
Message-Id: <e7e4e801234f2934306e734f65860f601a5745bd.1597259519.git.alistair.francis@wdc.com>
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
 target/riscv/cpu_bits.h   |  1 +
 target/riscv/cpu_helper.c | 16 ++++++----------
 target/riscv/op_helper.c  |  8 ++------
 target/riscv/translate.c  | 10 ----------
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 43617e7c1f..fb6a3e9092 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -445,6 +445,7 @@
 #define HSTATUS_VTSR         0x00400000
 #define HSTATUS_HU           0x00000200
 #define HSTATUS_GVA          0x00000040
+#define HSTATUS_SPVP         0x00000100
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9ab3ca4675..79166875a9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -922,9 +922,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             } else if (riscv_cpu_virt_enabled(env)) {
                 /* Trap into HS mode, from virt */
                 riscv_cpu_swap_hypervisor_regs(env);
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
+                env->hstatus = set_field(env->hstatus, HSTATUS_SPVP,
                                          get_field(env->mstatus, SSTATUS_SPP));
                 env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
                                          riscv_cpu_virt_enabled(env));
@@ -935,13 +933,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                 riscv_cpu_set_force_hs_excep(env, 0);
             } else {
                 /* Trap into HS mode */
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
-                                         get_field(env->hstatus, HSTATUS_SPV));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
-                                         get_field(env->mstatus, SSTATUS_SPP));
-                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
-                                         riscv_cpu_virt_enabled(env));
-
+                if (!riscv_cpu_two_stage_lookup(env)) {
+                    env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
+                                             riscv_cpu_virt_enabled(env));
+                }
+                riscv_cpu_set_two_stage_lookup(env, false);
                 htval = env->guest_phys_fault_addr;
             }
         }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 3d306c343c..4b64bfe7d2 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -97,12 +97,8 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
         prev_priv = get_field(mstatus, MSTATUS_SPP);
         prev_virt = get_field(hstatus, HSTATUS_SPV);
 
-        hstatus = set_field(hstatus, HSTATUS_SPV,
-                                 get_field(hstatus, HSTATUS_SP2V));
-        mstatus = set_field(mstatus, MSTATUS_SPP,
-                            get_field(hstatus, HSTATUS_SP2P));
-        hstatus = set_field(hstatus, HSTATUS_SP2V, 0);
-        hstatus = set_field(hstatus, HSTATUS_SP2P, 0);
+        hstatus = set_field(hstatus, HSTATUS_SPV, 0);
+        mstatus = set_field(mstatus, MSTATUS_SPP, 0);
         mstatus = set_field(mstatus, SSTATUS_SIE,
                             get_field(mstatus, SSTATUS_SPIE));
         mstatus = set_field(mstatus, SSTATUS_SPIE, 1);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9632e79cf3..f896412235 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -768,16 +768,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVH)) {
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
-        if (env->priv_ver == PRV_M &&
-            get_field(env->mstatus, MSTATUS_MPRV) &&
-            MSTATUS_MPV_ISSET(env)) {
-            ctx->virt_enabled = true;
-        } else if (env->priv == PRV_S &&
-                   !riscv_cpu_virt_enabled(env) &&
-                   get_field(env->hstatus, HSTATUS_SPRV) &&
-                   get_field(env->hstatus, HSTATUS_SPV)) {
-            ctx->virt_enabled = true;
-        }
     } else {
         ctx->virt_enabled = false;
     }
-- 
2.27.0


