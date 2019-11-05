Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD96C47E49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6FA214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6FA214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3SR-0000Sh-Vd
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iv-00063a-6y
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iu-0004kP-0N
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:45 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40493)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3It-0004jc-Mn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N18I8-1hmgvt0OEc-012U31; Tue, 05 Nov 2019 19:11:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] linux-user/sparc: Fix cpu_clone_regs_*
Date: Tue,  5 Nov 2019 19:11:18 +0100
Message-Id: <20191105181119.26779-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r0fsDaXcjdF5yek/2ye+ffad8EIzMItAXWG2mxZr0KG49yKk4bM
 r6x5+0N/PsYIKpypyw/IcyzyxzEDV8HuJGD93ticAO5401fkuqNp9E+ppiSfAqi7o71wz/7
 508IDhZdOiFAa1XcyU49aG3qUFueGBIfTEP1mTu921+aEAVAvtqzb88wqzMR3oseiuYXyuR
 LMKSyIFMOpw32BbUVvu4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7vuyFv4tAO0=:E1kQfaPBg84H11y3SJxux9
 Q8oqQUHY3ABsFvwqbbo3gw82DhqjvG3t7z6adjbDb//RYAWdcO0aYcsdnO45ZOQXG9GXCHy+k
 h7Z6NiCTVCoguq+6hJSrr4kaHMlehvPz0dwNZEzoG3Z36Ug1BvJaccsWMrdzu3PBaeq7NK4jE
 A/ZFmCtdL1HhZw/wagK0/MmEJjxERd2AYmIHungteXIIlsrkpTmfBdZLmeHqFXdnpFiThD1k1
 qSDMcM8NE6bdfTCRDkvpAdZtIIdT0JfRhsuVfexSsFXuuFYPI3FyB2nygm9HT4PCvSArEGeWi
 7hI1QipPgORitrxShIHNXy0YltW7zqWgUJkKSBwnW/beifWP2tjvvjQBNqwDbeU5C6GZ8TKd+
 29ABBi2o3oFtmfmmtA31J+qzhUhBmU2RlG8sPaLjTZTZ6fjX5lgPggqqyNPJ3WgG7moNgQebe
 PJY7RcSI3Us2yBzHA9vTX0wYA+yrAn+R5pIDKDMoQFWqr9fx1hrCcKd09bCTRW/WEG8mFxzYi
 wO8PedrBkViRYltXdfIEisvyIpWSkKKNXlcasfv8QP0D59Q5BvEcQviDCFvH2UCwHrrCIBR6M
 bo4hgEKqwBVfDg11kcWTBH80Pur12Y8jw/mYalakU5d7HuIEUTJNz8m3HnW3udKNc1XWEQGWj
 AZk4AWbkaVGmiYqIpMYcNTB+VcJXf61x988U8gLz/g4djL0hM2ONcjLVyaakd836Rbxaw4sk3
 fsOI8T08hKd94P/tXsZeb8XaEVX+8k1jQYmz5fiISdHw31t+4t6ItmHXJIASbUk8k1HX8tHLF
 KLra5I8zkS8MlkJkNWxQyCIN57KcFPGZou75i4Iwi7GGBXZlWkHPQ+wTWQ69E0MlYq8ZCjIES
 82+TS8OQxuPbcipeiR5w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We failed to set the secondary return value in %o1
we failed to advance the PC past the syscall,
we failed to adjust regwptr into the new structure,
we stored the stack pointer into the wrong register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-12-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/target_cpu.h | 43 +++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 8ff706adcef7..14b21589699b 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -23,22 +23,51 @@
 static inline void cpu_clone_regs_child(CPUSPARCState *env, target_ulong newsp,
                                         unsigned flags)
 {
+    /*
+     * After cpu_copy, env->regwptr is pointing into the old env.
+     * Update the new cpu to use its own register window.
+     */
+    env->regwptr = env->regbase + (env->cwp * 16);
+
     if (newsp) {
-        env->regwptr[22] = newsp;
+        /* When changing stacks, do it with clean register windows.  */
+#ifdef TARGET_SPARC64
+        env->cansave = env->nwindows - 2;
+        env->cleanwin = env->nwindows - 2;
+        env->canrestore = 0;
+#else
+        env->wim = 1 << env->cwp;
+#endif
+        /* ??? The kernel appears to copy one stack frame to the new stack. */
+        /* ??? The kernel force aligns the new stack. */
+        env->regwptr[WREG_SP] = newsp;
     }
-    /* syscall return for clone child: 0, and clear CF since
-     * this counts as a success return value.
-     */
-    env->regwptr[0] = 0;
+
+    if (flags & CLONE_VM) {
+        /*
+         * Syscall return for clone child: %o0 = 0 and clear CF since this
+         * counts as a success return value.  Advance the PC past the syscall.
+         * For fork child, all of this happens in cpu_loop, and we must not
+         * do the pc advance twice.
+         */
+        env->regwptr[WREG_O0] = 0;
 #if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
-    env->xcc &= ~PSR_CARRY;
+        env->xcc &= ~PSR_CARRY;
 #else
-    env->psr &= ~PSR_CARRY;
+        env->psr &= ~PSR_CARRY;
 #endif
+        env->pc = env->npc;
+        env->npc = env->npc + 4;
+    }
+
+    /* Set the second return value for the child: %o1 = 1.  */
+    env->regwptr[WREG_O1] = 1;
 }
 
 static inline void cpu_clone_regs_parent(CPUSPARCState *env, unsigned flags)
 {
+    /* Set the second return value for the parent: %o1 = 0.  */
+    env->regwptr[WREG_O1] = 0;
 }
 
 static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
-- 
2.21.0


