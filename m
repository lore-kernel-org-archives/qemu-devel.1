Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E4C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61F821882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61F821882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3MO-0002Ht-Fa
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3Ir-0005xC-Sl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Iq-0004hM-NH
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:41 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Iq-0004gG-47
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6bwO-1hsB6j20XG-0180M3; Tue, 05 Nov 2019 19:11:31 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] linux-user/sparc: Use WREG_SP constant in sparc/signal.c
Date: Tue,  5 Nov 2019 19:11:13 +0100
Message-Id: <20191105181119.26779-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G1qwgjrVD/d014NPw/Znbc3n9rLZQAeSIeoYcryBJz/i/v6DCpm
 xLG01cL3zJmQtVtIfqtfuAhcQtPWTtU3TrhZDW0Ql/y71wIAg0Eq472DnCnbGvj2KmPF0pV
 NJaw8iJEHiphyG4bD//XL0IvZZVHVkmvvjlija9ngwsM92t5M8k4ekQ//nuugEk1o7djQuc
 VThywpqWFpzvhPgiop/Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HJ60+S/KvfU=:RDwwPbS3NLI6V8kSI77lL+
 z+JgxAN+DgTOCYhhPyBulpLAFPut2XzIOETeXJw+86xBosLSXvoXF51l0rfCGRAqkTBENy6Gr
 u+SeLxfUwGIyOEK0pMbdDjEUdx3obQsZsrw9G3duQ48iBSPa94ia9dJv6QIWjOUlgfJSGya9I
 qb0yhw5sUUh5L4SxljXCyKwVQbwQ+wsUj/nEZHwVSiEMUbfB2zfA24pCRYon0NZVAI8mmFefI
 UoVHtzpsw/GPRh7v9ISniCPTR2aU9TyreWND9OgRkPcmvpPrfUjwBXDuzg8Pr75bYYoLFLIGj
 EeYgCllFgum2G1KEvX25rYnZLn3LpJ/GVYQpqM5AuveFFcQV0LbSig/Fdjn2fZJQUi+suUPzP
 27qaoUZH3AXlq8HPVHjrngrq+9JARkPt56EkCseed0jzLbGqnHAi/AEsSCHSwnfByxYcrmEWn
 LdFb7LJpZQ9u+j5bVj6F/5fyEKNdKTWhnGFpQWsr8prkoXkV6Vr2lg/6LBjTwRklqJ7vrzcI5
 wkF2C9Fw1VkZM6U/I91Xi5vdCpn0lAHEZAyZqNOHWJ9t64mpWAjc0PVtq/tO4QSM9lIBMbi9l
 vJJ8VXdGbpiHtyh/5Jli6zeY8euyUvAOGscwcNJ5Sfz8FSj+XAZS3zXkkvUGH2SyuSDIeOxbe
 aSj/i5FwR1UUcBCd0I6JF5uGdLIP58Hq+KrkH+pJqVLUo4wusowJ0TUxcqYMgNNq8qkZu2nOQ
 GH6QcYjSKHS0NgCiMbQ79vAxQhj4dNf8pgbUPYS31N15vEecCIbLzVpGZUrSqsTzs/CGMWM3S
 tuHJecfPaEI9R03B5SYi/Y5l0+FnXBrNypcLUOMqaDzcUUOIjiHs2VI22STVfb0fRSb23U/dm
 P+ds1RD7eXSBGa1uFxrA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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

s/UREG_FP/WREG_SP/g

This is non-obvious because the UREG_FP constant is fact wrong.
However, the previous search-and-replace patch made it clear that
UREG_FP expands to WREG_O6, and we can see from the enumeration in
target/sparc/cpu.h that WREG_O6 is in fact WREG_SP, the stack pointer.

The UREG_SP define is unused; remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-7-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index a967e2db7307..0db4c5f84fe4 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -104,9 +104,6 @@ struct target_rt_signal_frame {
     qemu_siginfo_fpu_t  fpu_state;
 };
 
-#define UREG_FP        WREG_O6
-#define UREG_SP        WREG_I6
-
 static inline abi_ulong get_sigframe(struct target_sigaction *sa, 
                                      CPUSPARCState *env,
                                      unsigned long framesize)
@@ -201,7 +198,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         goto sigsegv;
 
     /* 3. signal handler back-trampoline and parameters */
-    env->regwptr[UREG_FP] = sf_addr;
+    env->regwptr[WREG_SP] = sf_addr;
     env->regwptr[WREG_O0] = sig;
     env->regwptr[WREG_O1] = sf_addr +
             offsetof(struct target_signal_frame, info);
@@ -255,7 +252,7 @@ long do_sigreturn(CPUSPARCState *env)
     sigset_t host_set;
     int i;
 
-    sf_addr = env->regwptr[UREG_FP];
+    sf_addr = env->regwptr[WREG_SP];
     trace_user_do_sigreturn(env, sf_addr);
     if (!lock_user_struct(VERIFY_READ, sf, sf_addr, 1)) {
         goto segv_and_exit;
-- 
2.21.0


