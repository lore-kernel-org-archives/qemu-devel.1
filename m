Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD13C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD5F2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 12:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD5F2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itsYQ-0003HW-FE
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 07:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1itsXa-0002Jy-SL
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1itsXR-0008LS-JA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:54 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1itsXR-0008K5-Aa
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:21:45 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W4y-1jhh8w3u4w-016v1V; Tue, 21 Jan 2020 13:21:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] m68k: Fix regression causing Single-Step via GDB/RSP to
 not single step
Date: Tue, 21 Jan 2020 13:21:38 +0100
Message-Id: <20200121122138.1708193-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121122138.1708193-1-laurent@vivier.eu>
References: <20200121122138.1708193-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qzrNAX6JMR+f4z69eXdGkPGxL5Na+DPPy1LwlDIxm0/DBehz34V
 gvzvgf1NBtbxoEDHA3CMmfgqLyex3sXm+NNtox9cvXronXaQ8dS4K2o37Bl7hxRd1J/iPme
 SGKfpJXPNQSA21zrxuHG3Iziq5oT6iUjKACEXzCn3P8S7ju27d2mrt7znKW2IIW171L/RoA
 trZ3U0T6/k+4GXWwNNffA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rqWASo689eY=:ErxkVLp1PIzbs6rbVITRgN
 3Zy8uVlFSE+T4Ej13IYypUj1yOZkrmxmtKHi0dq/jVwKGRU8npaRjamlrlGBJinf8X7MZdTyt
 iN3p5c+hhNj4gXSvgqvHptjJ4WBa3JzRbf/MuWU3Eb2OvjS4LQgwlRKjf4D8xZQLHuYcFcUov
 z9y3qHN9WNYqFUgrQ/kB+PCYo+r3x98Hl1HjS+qumUISpCQbGkJBXoS2qxSA1Gx6aj3bPQtNt
 +LS7j/SgGJmzyLASdFhvFQK/37cLXMpH5esGILmNqBQfhO4oGMozfrD7YXco3vTl0u2OFTiYp
 m/SCbr69kwFei0ZKtfOOkrMsOLN54kcmbOrJAfCDKJXDeJ5ahEuZv8heFI1za1e9MWtyNEy8p
 mFYnrRt5s+UMotdPJx4tVMVq1/HdW/rX/isjqZJimxxwGQ2glwp2vUfcdg07PbQfUvKLqvLPm
 FWSVzVGIUuEeLtzUDhMya1urq8/x+N/w9j/yfIFK5eCOy3wcXLoQ+GVFamxnGdvZCOlVfKhMP
 MwRcUtHd16hVVLwAumZ8hoh+JQij5G0ceTAd/PfTXSraUoh2NL9i8pS5FlICZxa1gE9qKFEZx
 s/n4Dfi87CVXGr2x14xzuW3hHVvWlzQpWPtXYuKkl5dzpehTj84KszxOMJneKZCZRCmQO+5+F
 5Pl4YZwaeW5Z4ImnicgofmhQvv7lPws7RchAkm4cFAMyY4EDlGaaDIvA9ocqt5g6dildnWDxX
 lBNoOZ6nwJK9v8v3X14t+TY1htE1C2oxG4JUhGw30ocaRT7gslcaWecXl4HaA9schh3Qw4FcV
 /2ew4+fCVGodUf8cD6UGl9pNwzkDBRQ7UPwEUirWT80Wbc6BObgvyreUjlOQed6pVdK1232K2
 Y4S6Yep3svKR4PS0GP0g==
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
Message-Id: <20200116165454.2076265-1-laurent@vivier.eu>
---
 target/m68k/translate.c | 42 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 31b743717e..0f80888203 100644
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


