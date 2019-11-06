Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC74C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EC0217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EC0217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSL7v-0006Tj-A4
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSL01-0003hv-Md
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSL00-00032u-Io
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:25 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSL00-00031m-8Q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:05:24 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLi4W-1iAfcW0fNA-00Hj6j; Wed, 06 Nov 2019 14:05:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/13] linux-user/sparc: Use WREG_SP constant in
 sparc/signal.c
Date: Wed,  6 Nov 2019 14:04:50 +0100
Message-Id: <20191106130456.6176-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106130456.6176-1-laurent@vivier.eu>
References: <20191106130456.6176-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F93e5yo2DqTObT6L78NjVj8t1cit52FlwUIZxym5DRzQHRL3uwU
 Cf4foVC6eKSHJOe5z4GecDZyArENAjnWmNHPJm5NH66AoGzYBFviAC0EP5ii+VieL/yIYVU
 vvynRKbd9EgUttwqlf6RCRqRcl4017FMM3/ImJjBQM1fHjYsn+9iG8PdJMZfKotrYbWCXWO
 GFJfi8Jz7j3qe3x2ZA2DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vRZ2ozsTQoE=:Xr3bffh2H56nYZNHwYjnTZ
 /hipQrfP0yE957VAG9XZdCG/2F6+3LPbNwcQnFK/vNN4jBOGkQtMxmNTQl0AgSfB/DhxAGc0y
 MxzITP2nlwkmX5FZXQLZuDNI/6w4iSkgdDsQ4GTa1aOqcij5nRCtndX9wl6zZUHPs8eeBTw13
 GXqPcz+XojdJ1tdVGpybl9HdUYifLK9+7v+Srcxn5WKQYLCC1Vp5vO8woDliuVktTol++1j3I
 xVEV0wFXFVEFP/ExKOCBbQPjxfnhg6gKw59yM+bOMBSe7B8L9yTgdB+nMk2ty1ohGwNryFnaE
 4+ZBQZeGgWYhqN+TPWqpdpqr7uXPlHlimlPd3JfwB3mxKu1OX/NeaWNwIxSC4CElb1ESP6lkT
 hrg7gI9OU9UU1ApRG9VTvPkANe3fs51SGefu9pBXYeYWegqo2NYofmwFcPzI/U82dw5pz5rcS
 elSPtAwfBeh7HhbG+KSNviNdyI60A6op8M06dkNv4eTNmuPOqhXl94sesvJK8oYAwfwgs4V5C
 qVKUwmJVVJhZjk7iA2h0FvBglSzw8jqX2tsUZz7RuKlNhC18cGQmVNYXHzPx9PluMZZ0ricnC
 wDLDKnh77yMS2bWPe7ZPw03bA6GOvOluzqvoZRHoepVXHgwoYhKMhVN1BRkKHI8T7VTzG/H9f
 VnnsUnaXSiOKhFxo4c3IPinWuGpXTx9HLCLjg8q04GoK2EPhxZKkA8wVbyMRNmRd8C84dAhxP
 +lUa1vWht7IMNxhoc1/sA6vAoGydqz3hjs7tw5TzxluK7zM2taDQfoosNKVi4ki1GbOnUaCu4
 ZVBrUeZZWZmLNo0IbbDCucyJwCfJPn8FPZvTEZrfc9uu9NP8MploLjl65V0pnR/MHdI8Fl83c
 gBMdiOkE2+MUlz3CiXiA==
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

s/UREG_FP/WREG_SP/g

This is non-obvious because the UREG_FP constant is fact wrong.
However, the previous search-and-replace patch made it clear that
UREG_FP expands to WREG_O6, and we can see from the enumeration in
target/sparc/cpu.h that WREG_O6 is in fact WREG_SP, the stack pointer.

The UREG_SP define is unused; remove it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191106113318.10226-7-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/signal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index aac37da239c1..e05693f20432 100644
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


