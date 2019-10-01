Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8144C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCE921A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9r4qKNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCE921A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLpX-0005Wn-AV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl6-0001RL-J3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLl5-0005S4-94
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:20 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:35777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLl5-0005Rq-3e
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:19 -0400
Received: by mail-pg1-x533.google.com with SMTP id a24so10120555pgj.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jU8brlUXzPjkar+u0NpnsFMARH74CTCG+r5FbUcwGjw=;
 b=m9r4qKNs/zQLSFvYcRFXDZCES/Eim/BJ8FdrangvzLph10yyq0vv0NcSDNHIW0tqVH
 qJochh9fawb7efFcoW2O/Yn/0bmLZy14nWhRd9gVuMaZJz6l7iBTeKQb06zeq6mSNUbJ
 d13jW704jDuP30c2UiDzP9xoEN7yi+DiI0dqP/Rh/wd7C3xH+nyG+uvz2p7EqgvyV5VP
 4yah9rze3oCWIwaoQvpmmLsu/6s0oLPftZDSevCRTuraXKTkx2G17eHUkbs1TsIxswPy
 lQ1wvQC5aagsOWmRQm9dFYv0FNV7hgW49HuyVP3JWms3jTnIQxW7yeXcCk6n/uOiqxeN
 2n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jU8brlUXzPjkar+u0NpnsFMARH74CTCG+r5FbUcwGjw=;
 b=jp/qk3JFo1lvL6/LroFdDEG9q5C3Ebua6U85SfsSiTZ+fH4/3R7QjKbF545OehjJ0A
 LTlHPT7uROq+tiHsv0CjoMOHoKi1AjYDYBluSBeifTy8C+Yax/dtWYsqFXDBV7a/0G1F
 YV47FUUImRra9DMf3ImTOM/LCdc/X+y55UInsJDou/H1vZn0hC5+MFQVoB/zr7GDsuCp
 44T8NPvOoxGPRMreDu9KHamy5zsHo8dtmte2lzRebEYvvBUHVwBT/ySn8IEqxOwion3M
 6tkIlpni4V+nM5nIlTFiNjVLDQp9PiVroG2uD9/ROewqlVagJhWoh3/Qlt/szA7SDHf8
 1I3g==
X-Gm-Message-State: APjAAAUhBB9jmCXfe4RmhIKO3DW1ltLrtBNxHmJ2hb9td+/AAXSvOwsM
 kXE6MqA10n8mHKBthvGikPk+ARu9pms=
X-Google-Smtp-Source: APXvYqwwWjv0tRY0a03kcc13MbUYDi2Vgej7vsh510e/djWiIOh8CyZuKLOAaLh3ZOC5magDKRTkKQ==
X-Received: by 2002:a65:5802:: with SMTP id g2mr25715032pgr.333.1569950177620; 
 Tue, 01 Oct 2019 10:16:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/18] target/s390x: Add ilen to unwind data
Date: Tue,  1 Oct 2019 10:15:57 -0700
Message-Id: <20191001171614.8405-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::533
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
Cc: Richard Henderson <rth@twiddle.net>, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

Use ILEN_UNWIND to signal that we have in fact that cpu_restore_state
will have been called by the time we arrive in do_program_interrupt.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h       |  4 +++-
 target/s390x/interrupt.c |  5 ++++-
 target/s390x/translate.c | 20 +++++++++++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b907741858..1a5b1397da 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -34,7 +34,7 @@
 /* The z/Architecture has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
 
 #define MMU_MODE0_SUFFIX _primary
 #define MMU_MODE1_SUFFIX _secondary
@@ -804,6 +804,8 @@ int cpu_s390x_signal_handler(int host_signum, void *pinfo, void *puc);
 void s390_crw_mchk(void);
 void s390_io_interrupt(uint16_t subchannel_id, uint16_t subchannel_nr,
                        uint32_t io_int_parm, uint32_t io_int_word);
+/* instruction length set by unwind info */
+#define ILEN_UNWIND                 0
 /* automatically detect the instruction length */
 #define ILEN_AUTO                   0xff
 #define RA_IGNORED                  0
diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
index a841f7187d..30a9fb8852 100644
--- a/target/s390x/interrupt.c
+++ b/target/s390x/interrupt.c
@@ -28,7 +28,10 @@ void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t ilen)
 
     cs->exception_index = EXCP_PGM;
     env->int_pgm_code = code;
-    env->int_pgm_ilen = ilen;
+    /* If ILEN_UNWIND, int_pgm_ilen already has the correct value.  */
+    if (ilen != ILEN_UNWIND) {
+        env->int_pgm_ilen = ilen;
+    }
 }
 
 void s390_program_interrupt(CPUS390XState *env, uint32_t code, int ilen,
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a3e43ff9ec..151dfa91fb 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6309,6 +6309,9 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     /* Search for the insn in the table.  */
     insn = extract_insn(env, s, &f);
 
+    /* Emit insn_start now that we know the ILEN.  */
+    tcg_gen_insn_start(s->base.pc_next, s->cc_op, s->ilen);
+
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
         qemu_log_mask(LOG_UNIMP, "unimplemented opcode 0x%02x%02x\n",
@@ -6463,9 +6466,6 @@ static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
 }
 
 static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
@@ -6473,6 +6473,14 @@ static bool s390x_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
+    /*
+     * Emit an insn_start to accompany the breakpoint exception.
+     * The ILEN value is a dummy, since this does not result in
+     * an s390x exception, but an internal qemu exception which
+     * brings us back to interact with the gdbstub.
+     */
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 2);
+
     dc->base.is_jmp = DISAS_PC_STALE;
     dc->do_debug = true;
     /* The address covered by the breakpoint must be included in
@@ -6567,8 +6575,14 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     int cc_op = data[1];
+
     env->psw.addr = data[0];
+
+    /* Update the CC opcode if it is not already up-to-date.  */
     if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
         env->cc_op = cc_op;
     }
+
+    /* Record ILEN.  */
+    env->int_pgm_ilen = data[2];
 }
-- 
2.17.1


