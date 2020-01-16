Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0836C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5B224673
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B224673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8RN-0004XV-6q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:56:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1is8QF-0003QJ-5B
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1is8QA-0000x5-Pf
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:55:07 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:41807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1is8QA-0000wI-HI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:55:02 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4JiJ-1isPOy0x4T-000MdA; Thu, 16 Jan 2020 17:54:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] m68k: Fix regression causing Single-Step via GDB/RSP to
 not single step
Date: Thu, 16 Jan 2020 17:54:54 +0100
Message-Id: <20200116165454.2076265-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oKUymkZOZa6yYrOcjkK7FBuvCOVWejceIopEGqroZ0H+Z3DFD3d
 h1bCZGbhCBBndpQu21RIIE3F1gfcXSh8EdX0UDHoexc/HRRS5+CB/9XNbMkN7Dv9ehWWGZ6
 7AkTOs4yLjXLJDka6qzgjPRrWP3gskK1EzlrpG1al2JuKUcZXkX6QxL5kKISDkbNjh+ONAH
 XxUC/QScg1NE0kGQGO9dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4jGCtKa3KXs=:oybeWHzDkUv0U9snmZ61CT
 wqU+xHoW7Dv3jvOP1lZWtUHuZ/AdnN3Tdkee6bMnL4Wah4vqq8eHAa/P4GsG/qT6m6xSWq8vy
 dOe6QhV+6uX0GFu1C3sV+HkMMcAlWeCGDiluRilCP7IDmDVnXwz7BaYXNdpnmT4YOH/pZ76OQ
 bA6jGBXKPlsrSseTVyTX5uJmoTcVtxmLI8AUyLTd4AAUW/6AUXXfL0pFotkLyDgn/6EbV7fU/
 4R/WhR5FHMV839aSLzohVjsFgkTuUwFVDZ8l1xZjeJL+4IgdtsDCcNocoU92uwT6y3UpyYASo
 9Ro3kuGLrl2SpZy+uxx1/RBONlZ/ePyVKCJw31ilLyAIj5xRf4lBDOsnnFSLLe54wBfFOTIMy
 MQn5eeUiKzhLOslKa1EDMC4bddYSUSArQOLxNnPiBs0+p1HD7ML0c+zwgyX55L/AtzCjweI4l
 vXIwSkqWYRW0nP2z5BTtUtqbnCfrNvPBF/zGz+OL7KfHS9sXvLdV4AkHIFXpP2SZt+1wYd+H+
 FC5YTFePRvtNVYMAwQVYkGxnQfrPxtbQ3r5+VcbxdvaFfR8KMUo0Sx1E6PDlH/umXnwHjsmoo
 GDDK1yej2g7TGtarBTbXJc6egxHcPMvw3itTH5+CvDHWPyJnUCV67ckIjnKUoXyLENJkYXG3i
 6fEJL+39iuGmGwqAybC4sJdSwi952x2hJMiLiUlqOFeMRkP2Tjw1WoEjqg+GFPk3G1MJufDbz
 hIz9j4SkR5j/hxC+U96ErrgLLgEG9tFnYeVuMRiAT37LHYFqfUZJNp29dVQZrerwGnWGPK2YK
 UdY7NihPhEtkDJ0NRB44QJoH1PVxt1PGMPfPvbf0TXzyTnNqRxgO4JGPc/qBkO03CpeQ86hip
 SiUZviq6QDxwBxHCNWIQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A regression that was introduced, with the refactor to TranslatorOps,
drops two lines that update the PC when single-stepping is being performed.

Fixes: 11ab74b01e0a ("target/m68k: Convert to TranslatorOps")
Reported-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Suggested-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v3: introduce gen_raise_exception() (Richard)
    
    v2: update patch from Lucien with changes from Richard
        update subject to prefix it with "m68k:"
        rebase

 target/m68k/translate.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index fcdb7bc8e4..16fae5ac9e 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -289,16 +289,21 @@ static void gen_jmp(DisasContext *s, TCGv dest)
     s->base.is_jmp = DISAS_JUMP;
 }
 
-static void gen_exception(DisasContext *s, uint32_t dest, int nr)
+static void gen_raise_exception(int nr)
 {
     TCGv_i32 tmp;
 
-    update_cc_op(s);
-    tcg_gen_movi_i32(QREG_PC, dest);
-
     tmp = tcg_const_i32(nr);
     gen_helper_raise_exception(cpu_env, tmp);
     tcg_temp_free_i32(tmp);
+}
+
+static void gen_exception(DisasContext *s, uint32_t dest, int nr)
+{
+    update_cc_op(s);
+    tcg_gen_movi_i32(QREG_PC, dest);
+
+    gen_raise_exception(nr);
 
     s->base.is_jmp = DISAS_NORETURN;
 }
@@ -6198,29 +6203,36 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->base.is_jmp == DISAS_NORETURN) {
-        return;
-    }
-    if (dc->base.singlestep_enabled) {
-        gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
-        return;
-    }
-
     switch (dc->base.is_jmp) {
+    case DISAS_NORETURN:
+        break;
     case DISAS_TOO_MANY:
         update_cc_op(dc);
-        gen_jmp_tb(dc, 0, dc->pc);
+        if (dc->base.singlestep_enabled) {
+            tcg_gen_movi_i32(QREG_PC, dc->pc);
+            gen_raise_exception(EXCP_DEBUG);
+        } else {
+            gen_jmp_tb(dc, 0, dc->pc);
+        }
         break;
     case DISAS_JUMP:
         /* We updated CC_OP and PC in gen_jmp/gen_jmp_im.  */
-        tcg_gen_lookup_and_goto_ptr();
+        if (dc->base.singlestep_enabled) {
+            gen_raise_exception(EXCP_DEBUG);
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
         break;
     case DISAS_EXIT:
         /*
          * We updated CC_OP and PC in gen_exit_tb, but also modified
          * other state that may require returning to the main loop.
          */
-        tcg_gen_exit_tb(NULL, 0);
+        if (dc->base.singlestep_enabled) {
+            gen_raise_exception(EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
         break;
     default:
         g_assert_not_reached();
-- 
2.24.1


