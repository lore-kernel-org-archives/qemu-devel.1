Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E34C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092612467C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092612467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is8QE-0003G9-4t
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1is8PV-0002ox-Qn
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1is8PR-0000ci-T5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:54:21 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:58801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1is8PR-0000bk-JO
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:54:17 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqK6l-1jNdey2JMZ-00nQdW; Thu, 16 Jan 2020 17:54:11 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] m68k: Fix regression causing Single-Step via GDB/RSP to
 not single step
Date: Thu, 16 Jan 2020 17:54:10 +0100
Message-Id: <20200116165410.2076012-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wni8AbMesIINrO+TEM6raf3K+aRP38wOKuwnqyEMaxQtbGh8Mm5
 309PsLNqKmjkuY9/tdjOrSrtphdOKSteXfT1tgYmasprtSHCHRQJOuRYG5CVQyy4mjsZd/j
 7M10MlFg+YSmax3aBfULjp659V1JUF5o11Il/X3KjJ8cJZkYmYqQsdam9VNowm5qzeoZ8vM
 WEXz7uGwxaf4cdO4r7n9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GGVtj4xCsGs=:7gbu4KYtD2o+RWWoOrAj+M
 9cY0+eiIJBnxfaMX8jEj1O3UmnYxeyX0VqIhLzMC9ayN0+OpzAg2e78+cb6ukz+voyt6keKBg
 F5s33DizPW3ZQv1u4FITbuMLe6v46Trleu7Fp+MpSkZ+v6umCMW5ZV9Lbh/zo17MHr/A4SMfC
 u0hg3gudD3uyW0XeU7G0axQhBECDw2oMf6eoPKhHcJEx1sx2mICsr7URfvV7y8exhREwYieAc
 GJC0h9dd9BD9QGzze+LE/lBhgBr1J7pbYKZPlbNXL2qma38SHE6nTrhE+Dc30M5dpaufWtC4Z
 abYm8YQJwwPzXJmMec56wPMGqn1E3Z54P7Blrh0r9/QnUJ52AxHrdzLNi0MIiiEEuvfIZnAHs
 bOkeMKq/LwAyAAC+/Cyj/pS64FZ7F0GkCT+ywKBoIAEAzGBtoqMMREF74LnO3vX9XRuMCKypW
 0YAIDt+aEP5W+izpONsndKAhKtgf6Gja7cfSavotRWRMkFJGWl6BFkRxJSHm1NmfiyVRFbcX3
 BkhgKC+qw6dqCGSKogJlQkNHwd06rgBfABL0MUA2VwbnquqR7HdCrwgZT1MVfN8NgRKumKges
 Aejhwer+GhDxKbwjoysTb3SaBaUe5cwdj6sjWJNa/T2n3jneb4eRDwDb94Df6UprjcZ1rfBHM
 WVsKSCcuYgorTkkHh5NkpGDbU/iHeMq+NGzpSp/MZIXCag+6qk+qZ6KpIT/kYybZPMdvBY9Z0
 enlMy2Pt+T4rvAZax/3F6EstwVSMoMgtWT6Hud8GTOVxY8AVkukK36l+OghHdl2lwIHtFTXkm
 Iu+kpSNlEstUM/3XxyPo+GZWe+s0hhJfQPf24+DUYryfX3rCnXY2iO2lR5yiJVOlvbfQ6gbkJ
 jPBfjVMBjL5FVaYMJ5bA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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


