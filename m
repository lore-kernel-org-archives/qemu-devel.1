Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBD9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E353233FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="u36unjx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E353233FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kHf-0001gr-L9
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDK-0005u4-MP
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDJ-0005aX-76
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:06 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:43956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1i0kDJ-0005ZV-0N
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jINiFwIgkBzloBCN5JnJbGmPZ+sUY/qCCm2bVfZUztY=; b=u36unjx77MGxQxiN8m3B+WOuTd
 tDG4kpY1auMwsamKZZPacN80yNxBEo7cKKhVIZu7LJDAaQUL/JO9Lh8ZI9Cwns2MLLkdlOGdtX/g0
 2rHzbdQ/MG4Y7eNo81awFvrjLTyIhkUz201R3aroGPblGInS90AfhQQiXPIJEe5BsYUk=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 12:20:45 +0200
Message-Id: <20190822102046.8765-5-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
References: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.22.101216, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 4/5] target/tricore: Implement a qemu excptions
 helper
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this helper is only used to raise qemu specific exceptions. We use this
helper to raise it on breakpoints.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.h    |  1 +
 target/tricore/op_helper.c |  7 +++++++
 target/tricore/translate.c | 20 +++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index b64780c37d..78176aa17a 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -153,3 +153,4 @@ DEF_HELPER_2(psw_write, void, env, i32)
 DEF_HELPER_1(psw_read, i32, env)
 /* Exceptions */
 DEF_HELPER_3(raise_exception_sync, noreturn, env, i32, i32)
+DEF_HELPER_2(qemu_excp, noreturn, env, i32)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 9476d10d00..32c2bc1699 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -107,6 +107,13 @@ static void raise_exception_sync_helper(CPUTriCoreState *env, uint32_t class,
     raise_exception_sync_internal(env, class, tin, pc, 0);
 }
 
+void helper_qemu_excp(CPUTriCoreState *env, uint32_t excp)
+{
+    CPUState *cs = env_cpu(env);
+    cs->exception_index = excp;
+    cpu_loop_exit(cs);
+}
+
 /* Addressing mode helper */
 
 static uint16_t reverse16(uint16_t val)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5fb42abe35..88b2840ad1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3261,6 +3261,15 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     tcg_temp_free(tintemp);
 }
 
+static void generate_qemu_excp(DisasContext *ctx, int excp)
+{
+    TCGv_i32 tmp = tcg_const_i32(excp);
+    gen_save_pc(ctx->base.pc_next);
+    gen_helper_qemu_excp(cpu_env, tmp);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    tcg_temp_free(tmp);
+}
+
 static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
                                    TCGv r2, int16_t address)
 {
@@ -8808,7 +8817,16 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
                                       const CPUBreakpoint *bp)
 {
-    return false;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    generate_qemu_excp(ctx, EXCP_DEBUG);
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
+    ctx->base.pc_next += 4;
+    return true;
 }
 
 static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.23.0


