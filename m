Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A13206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A13206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXMq-0001KS-65
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKf-0005Mn-F1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKe-0001GG-Ew
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:33 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41809 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iwXKe-0001BJ-4E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CF91A1A1FFA;
 Tue, 28 Jan 2020 21:09:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B344E1A1E9A;
 Tue, 28 Jan 2020 21:09:52 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] mips-semi.c: remove 'uhi_done' label in
 helper_do_semihosting()
Date: Tue, 28 Jan 2020 21:09:18 +0100
Message-Id: <1580242161-20333-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The label 'uhi_done' is a simple 'return' call and can
be removed for a bit more clarity in the code.

CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Aleksandar Markovic <amarkovic@wavecomp.com>
CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200106182425.20312-7-danielhb413@gmail.com>
---
 target/mips/mips-semi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 35bdfd7..10a710c 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -218,7 +218,7 @@ static int copy_argn_to_target(CPUMIPSState *env, int arg_num,
         if (!p) {                               \
             gpr[2] = -1;                        \
             gpr[3] = EFAULT;                    \
-            goto uhi_done;                      \
+            return;                             \
         }                                       \
     } while (0)
 
@@ -228,14 +228,14 @@ static int copy_argn_to_target(CPUMIPSState *env, int arg_num,
         if (!p) {                                       \
             gpr[2] = -1;                                \
             gpr[3] = EFAULT;                            \
-            goto uhi_done;                              \
+            return;                                     \
         }                                               \
         p2 = lock_user_string(addr2);                   \
         if (!p2) {                                      \
             unlock_user(p, addr, 0);                    \
             gpr[2] = -1;                                \
             gpr[3] = EFAULT;                            \
-            goto uhi_done;                              \
+            return;                                     \
         }                                               \
     } while (0)
 
@@ -272,7 +272,7 @@ void helper_do_semihosting(CPUMIPSState *env)
         if (gpr[4] < 3) {
             /* ignore closing stdin/stdout/stderr */
             gpr[2] = 0;
-            goto uhi_done;
+            return;
         }
         gpr[2] = close(gpr[4]);
         gpr[3] = errno_mips(errno);
@@ -302,7 +302,7 @@ void helper_do_semihosting(CPUMIPSState *env)
             gpr[2] = fstat(gpr[4], &sbuf);
             gpr[3] = errno_mips(errno);
             if (gpr[2]) {
-                goto uhi_done;
+                return;
             }
             gpr[2] = copy_stat_to_target(env, &sbuf, gpr[5]);
             gpr[3] = errno_mips(errno);
@@ -314,14 +314,14 @@ void helper_do_semihosting(CPUMIPSState *env)
     case UHI_argnlen:
         if (gpr[4] >= semihosting_get_argc()) {
             gpr[2] = -1;
-            goto uhi_done;
+            return;
         }
         gpr[2] = strlen(semihosting_get_arg(gpr[4]));
         break;
     case UHI_argn:
         if (gpr[4] >= semihosting_get_argc()) {
             gpr[2] = -1;
-            goto uhi_done;
+            return;
         }
         gpr[2] = copy_argn_to_target(env, gpr[4], gpr[5]);
         break;
@@ -369,6 +369,5 @@ void helper_do_semihosting(CPUMIPSState *env)
         fprintf(stderr, "Unknown UHI operation %d\n", op);
         abort();
     }
-uhi_done:
     return;
 }
-- 
2.7.4


