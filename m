Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8BC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF0220652
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF0220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35015 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvLS-0000Kr-U3
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:34:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYvEt-0003TN-WB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hYvEr-0003TB-Ai
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43402 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hYvEr-0003Q0-1A
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:27:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id E664C1A2106;
	Thu,  6 Jun 2019 18:27:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id B49981A1FBD;
	Thu,  6 Jun 2019 18:27:38 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:27:12 +0200
Message-Id: <1559838440-9866-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559838440-9866-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1559838440-9866-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 02/10] target/mips: Fix
 block-comment-related issues im msa_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix block-comment-related issues reported by checkpatch for file
msa_helper.c.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Message-Id: <1559745316-1454-3-git-send-email-aleksandar.markovic@rt-rk.com>
---
 target/mips/msa_helper.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index eacb5a4..851450c 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1975,8 +1975,10 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
         c &= ~FP_UNDERFLOW;
     }
 
-    /* Reciprocal operations set only Inexact when valid and not
-       divide by zero */
+    /*
+     * Reciprocal operations set only Inexact when valid and not
+     * divide by zero
+     */
     if ((action & RECIPROCAL_INEXACT) &&
             (c & (FP_INVALID | FP_DIV0)) == 0) {
         c = FP_INEXACT;
@@ -1985,15 +1987,19 @@ static inline int update_msacsr(CPUMIPSState *env, int action, int denormal)
     cause = c & enable;    /* all current enabled exceptions */
 
     if (cause == 0) {
-        /* No enabled exception, update the MSACSR Cause
-         with all current exceptions */
+        /*
+         * No enabled exception, update the MSACSR Cause
+         * with all current exceptions
+         */
         SET_FP_CAUSE(env->active_tc.msacsr,
                 (GET_FP_CAUSE(env->active_tc.msacsr) | c));
     } else {
         /* Current exceptions are enabled */
         if ((env->active_tc.msacsr & MSACSR_NX_MASK) == 0) {
-            /* Exception(s) will trap, update MSACSR Cause
-           with all enabled exceptions */
+            /*
+             * Exception(s) will trap, update MSACSR Cause
+             * with all enabled exceptions
+             */
             SET_FP_CAUSE(env->active_tc.msacsr,
                     (GET_FP_CAUSE(env->active_tc.msacsr) | c));
         }
@@ -3059,9 +3065,11 @@ void helper_msa_fexdo_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     switch (df) {
     case DF_WORD:
         for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            /* Half precision floats come in two formats: standard
-               IEEE and "ARM" format.  The latter gains extra exponent
-               range by omitting the NaN/Inf encodings.  */
+            /*
+             * Half precision floats come in two formats: standard
+             * IEEE and "ARM" format.  The latter gains extra exponent
+             * range by omitting the NaN/Inf encodings.
+             */
             flag ieee = 1;
 
             MSA_FLOAT_BINOP(Lh(pwx, i), from_float32, pws->w[i], ieee, 16);
@@ -3617,9 +3625,11 @@ void helper_msa_fexupl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     switch (df) {
     case DF_WORD:
         for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            /* Half precision floats come in two formats: standard
-               IEEE and "ARM" format.  The latter gains extra exponent
-               range by omitting the NaN/Inf encodings.  */
+            /*
+             * Half precision floats come in two formats: standard
+             * IEEE and "ARM" format.  The latter gains extra exponent
+             * range by omitting the NaN/Inf encodings.
+             */
             flag ieee = 1;
 
             MSA_FLOAT_BINOP(pwx->w[i], from_float16, Lh(pws, i), ieee, 32);
@@ -3651,9 +3661,11 @@ void helper_msa_fexupr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
     switch (df) {
     case DF_WORD:
         for (i = 0; i < DF_ELEMENTS(DF_WORD); i++) {
-            /* Half precision floats come in two formats: standard
-               IEEE and "ARM" format.  The latter gains extra exponent
-               range by omitting the NaN/Inf encodings.  */
+            /*
+             * Half precision floats come in two formats: standard
+             * IEEE and "ARM" format.  The latter gains extra exponent
+             * range by omitting the NaN/Inf encodings.
+             */
             flag ieee = 1;
 
             MSA_FLOAT_BINOP(pwx->w[i], from_float16, Rh(pws, i), ieee, 32);
-- 
2.7.4


