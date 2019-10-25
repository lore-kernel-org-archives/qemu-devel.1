Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F25CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC0D206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BbyemCzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC0D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9PR-00050L-63
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91T-0005ji-4Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91R-0004jO-TX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91R-0004Yx-LU; Fri, 25 Oct 2019 19:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046173; x=1603582173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g37n1ZVkdhVO3F8wxnglbViPKYTuNjM3/io1BWGTgEQ=;
 b=BbyemCzW2wjELf47Dn6vNobMpGd0Y/8mmBZcFfBjryRL6SoHsjPDhzlp
 czeZZipSFTwwtV4c6dSUbQC7vPgJcIufnHTzSjj52TEj4stUejFkbUT6v
 BfhSzDEJLtHhSFc/fUeNia1ZVFbsOTDmqWnXbMlQTR2BpkVpm26k10Hyl
 cTPsuz9xq1c7q/uS3zna1K8AZUPbp9AMFzLImOWng1HRMFQPR+GHP0Ei6
 F5Yh4xG18PoZGuRpgUqC2CqX0UiPUP4lJqbdH070Q7/OFUmodYoJ8pDgi
 mZyMK+sotnlgw3B4RH+Rk+K5jzyHbZJhPMi4Jyoy5eHEnH+dLLN0CbG5s g==;
IronPort-SDR: wqo6lQw/fJqiF6gPo5HVdBqKlK0orCd49QQsSnXbqaLq35eoNnhnTlqnGYfJy9GE1xSnzkja9c
 3ssn2a5T8E5LkRg+m56IoE4KbS8EBqdDc3xHYFe7o5Dk/BmyKTkDahTo1XfFWHmZpRuA2/jFE2
 46jt95Oz0oO5FHvlI8rKAEuteQxoOebko8ei08VYMIE7BbMP6bfPqgRbrn0aH4YabIsT0n7yPV
 yLfg5VN6crKXktbOzLrDsOJbZH/Zku9RVxul8szsrlJ9FeTuqH+sTVN0RpuW5rRUfSzrzZwM0I
 dNY=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956706"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:33 +0800
IronPort-SDR: h8IeMF5ZNBhgrkkXD27TJjN86D+0XJsXTTqtvOWwb9HTkY+OgWEE3v2k/aEU/Ops6mxYOMLmS8
 qTrgzMx0dboBBe5si1UqtJEF62WGVwSFxb2uWZb+Ls9fu3U8wynupYbtxCv50/srCRLP0uVDWk
 Fn8r1VoubG+Ok7FpADKhnvR96xFW+HW7NhLZf2F3Wv04iTRBk/X3qAGkIAfynK2r46IH1Mc9IO
 fng7Sg3PQ5oIh7UPfQcbIyrxGV96394nlq9i3/yCQIEvP6sW0vfPkdtJycixvmfYsHenHp0prW
 oATz0F69Pi1pgVhSsjUJPAU+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:59 -0700
IronPort-SDR: isbioOg7ONCyJlMVGb99z3E9plILh6RClF3WZXFbHVj3yWtVzr0oXeHibQNbNVLCHvia0kFYyP
 R9cYTRTQ2mgYPEAURcNjYBPvKRC4etBGCufEV468KA22RdFtCF4SFpwwBaPbg5dWrtb97QEqdA
 XoUeF49hMZHqAl9sMRTU+HrWeoDKz9vzOHqYzBsa/teNRlPnfHFII+Pg4lKr58dsmMHD05X2Pk
 9+XfIX52S9jSffMSrzQ+e+PheJfrrBYfeKXbSGeOXb4pDQKi8rPQlZPVXEhCpYVHoHcE21B+vb
 2rw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2019 16:29:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 26/27] target/riscv: Add the MSTATUS_MPV_ISSET helper macro
Date: Fri, 25 Oct 2019 16:24:37 -0700
Message-Id: <70a2a77da9586b6127e7b5405bf1667a31da5fb6.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
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
index a2358c4956..f9389b071d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -365,8 +365,19 @@
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
index 79b2f30876..dedca3eea8 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -331,7 +331,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
             mode = get_field(*env->mstatus, MSTATUS_MPP);
 
             if (riscv_has_ext(env, RVH) &&
-                get_field(*env->mstatus, MSTATUS_MPV)) {
+                MSTATUS_MPV_ISSET(env)) {
                 use_background = true;
             }
         }
@@ -718,7 +718,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
index ea19ba9c5d..f0d9860429 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -754,7 +754,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
         ctx->virt_enabled = riscv_cpu_virt_enabled(env);
         if (env->priv_ver == PRV_M &&
             get_field(*env->mstatus, MSTATUS_MPRV) &&
-            get_field(*env->mstatus, MSTATUS_MPV)) {
+            MSTATUS_MPV_ISSET(env)) {
             ctx->virt_enabled = true;
         } else if (env->priv == PRV_S &&
                    !riscv_cpu_virt_enabled(env) &&
-- 
2.23.0


