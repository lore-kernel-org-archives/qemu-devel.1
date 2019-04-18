Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFECC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CACE2183E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CACE2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40055 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH5Wp-0006fE-Of
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:48:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5Sd-0003An-E5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5SY-0006Th-Op
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:50792 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH5SV-0006NO-HP
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 184A01A1DF9;
	Thu, 18 Apr 2019 13:42:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw310-lin.domain.local (rtrkw310-lin.domain.local
	[10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id E51901A246A;
	Thu, 18 Apr 2019 13:42:52 +0200 (CEST)
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 13:42:46 +0200
Message-Id: <1555587766-985-7-git-send-email-mateja.marjanovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555587766-985-1-git-send-email-mateja.marjanovic@rt-rk.com>
References: <1555587766-985-1-git-send-email-mateja.marjanovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 6/6] target/mips: Merge implementation of
 ILVOD.D and ILVL.D
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
Cc: arikalo@wavecomp.com, richard.henderson@linaro.org, philmd@redhat.com,
	amarkovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418114246.u-S2TArjuAgAZh39b9pTaJ44tbT8_S6AhfVjIfV1Uxs@z>

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

The implementation for ILVOD.D and ILVL.D instructions
is equivalent, so use a single handler for both of them.

Suggested-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
---
 target/mips/translate.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c6aa995..4837c43 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28154,19 +28154,6 @@ static inline void gen_ilvl_w(CPUMIPSState *env, uint32_t wd,
 }
 
 /*
- * [MSA] ILVL.D wd, ws, wt
- *
- *   Vector Interleave Left (doubleword data elements)
- *
- */
-static inline void gen_ilvl_d(CPUMIPSState *env, uint32_t wd,
-                              uint32_t ws, uint32_t wt)
-{
-    tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
-    tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
-}
-
-/*
  * [MSA] ILVOD.<B|H> wd, ws, wt
  *
  *   Vector Interleave Odd (<byte|halfword> data elements)
@@ -28232,9 +28219,15 @@ static inline void gen_ilvod_w(CPUMIPSState *env, uint32_t wd,
  *
  *   Vector Interleave Odd (doubleword data elements)
  *
+ * [MSA] ILVL.D wd, ws, wt
+ *
+ *   Vector Interleave Left (doubleword data elements)
+ *
+ *  These two instructions are functionally equivalent.
+ *
  */
-static inline void gen_ilvod_d(CPUMIPSState *env, uint32_t wd,
-                               uint32_t ws, uint32_t wt)
+static inline void gen_ilvod_ilvl_d(CPUMIPSState *env, uint32_t wd,
+                                    uint32_t ws, uint32_t wt)
 {
     tcg_gen_mov_i64(msa_wr_d[wd * 2], msa_wr_d[wt * 2 + 1]);
     tcg_gen_mov_i64(msa_wr_d[wd * 2 + 1], msa_wr_d[ws * 2 + 1]);
@@ -28447,7 +28440,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvl_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvl_d(env, wd, ws, wt);
+            gen_ilvod_ilvl_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
@@ -28543,7 +28536,7 @@ static void gen_msa_3r(CPUMIPSState *env, DisasContext *ctx)
             gen_ilvod_w(env, wd, ws, wt);
             break;
         case DF_DOUBLE:
-            gen_ilvod_d(env, wd, ws, wt);
+            gen_ilvod_ilvl_d(env, wd, ws, wt);
             break;
         default:
             assert(0);
-- 
2.7.4


