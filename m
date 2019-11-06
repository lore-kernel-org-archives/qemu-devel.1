Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B8AC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D782217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D782217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL1o-0005MA-4y
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSKzw-0003Xi-FJ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSKzv-0002yV-8E
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSKzu-0002xk-VR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:19 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N79q8-1hrtHE3bZ6-017Vs9; Wed, 06 Nov 2019 14:05:17 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/13] linux-user/sparc: Fix cpu_clone_regs_*
Date: Wed,  6 Nov 2019 14:04:55 +0100
Message-Id: <20191106130456.6176-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SZJtkQFvalXdI41SeIQoMMrB0GUeVbZcriSYjspiLcEPONjOKc0
 4PhKd5249RuZ/k5GjTmVj2q0Sf7IhHTkJYwTHThaH1fyYaoxK6+m2YADd46d+1WLPb8VOKz
 Q/CIaxNv81mAgDNhb3I2xwMYVqqe0QPudhZ51sQ6yUICnizwgCY6Sx3K+e2kx68GwmoA5OM
 T5J758/yldGMjXSjYuzvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UZSje5P6C2M=:9QIQB95eNWbVC/706ZRgYY
 qDFsYCwalhcYdDszOb85COLpSwcBbMnl5P2apBnX9u96L4oGtlhK6J+JQ4YkOXsPdOmwJ3zhk
 AeHVZAGzccLhwKKvsw9a5/hcEYtELGGekQDtsLgHKK2RdtH+lqIgkTkhZbyIdB8Lf8NVQVPxW
 vSY2h3Dzg+oWwu0/+65MYVLBNMxqKTSTwGk4UXHNB1UD7aIGoJRAQqZRsQ6FDOqRYeKi6W/7N
 i3bGWvQ3pW9FNu93apTtK9FwkqpxE4d6XHWEFKlI+dCZJhJtauMvxt64iIeHkaMnWH+y37j+N
 NsIkf6DOPaemnaAxjnJsReEUKU9NFTd2iDBK9f4Au0HNTLH/ASwah9ZPoMrUVi/YgHScuGvVn
 OlbMmVtmc+adooX2yyB1ofPbk9VVkFDTU/2l0pyFXKP1QPkiKZnh+mx9p37pWk7rOxwLcd1Jm
 QwkzGaP0tCcYkYaUW9hveifubeop81ySfsvC5RFtpnizC/qe/Se8/BONVKe4jReRaXMI5zCPv
 YfAhV+uwWTd6AgQcYTj6DfQgfWJsW9SDCAUyaYBL3kOgb5+j6nwLz8DR0uJQ9Km1UX06WTEZJ
 4r047lJN5jZi6OBM4QulpqgmS3+W3M+JV2nV6yimVOOVIBvdoJ0mgBSu4tROv0jZl1SxXBNCU
 Qi5PkmgMTBF5cSsfvLnIXRu37gqafSwDwBRxsw4EKxg5crgxk9Y76D8BFnTQHKHOS8wdYbQDp
 LyfLG7OK2hEARjcgtjMSveqjZfEz/QarvEysB/zHJ2Qzex3gRHG7ReKE7EDjN5xf5ELtEumnM
 jNQ3bB9HdvfwFsBvEra5y1ArQEQsahFcFetDAPmK+j1YyYyF1Cpsb5zy0lKmA+8AV0b9Nbg+j
 ZJBdG9pp0Yn6AzK385eg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
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
Message-Id: <20191106113318.10226-12-richard.henderson@linaro.org>
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


