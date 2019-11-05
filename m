Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BB0C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3533214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3533214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3P7-0005AV-JJ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3It-000618-SE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Is-0004jS-Mm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Is-0004iA-CY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVubb-1iK7Cp0WWb-00Rmv6; Tue, 05 Nov 2019 19:11:30 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
Date: Tue,  5 Nov 2019 19:11:11 +0100
Message-Id: <20191105181119.26779-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KXxJLT3KNr6WlN9g2QmbVLh3fKF01ZX6oWM+L1NoEM2yYQh4uHR
 xRL2SiIiznF7/I81463rKtj1ZWRoTcTuu75MwbnBp0xkW+GL09AHH6YFjtgEo0cgBcgFPkd
 STZFstoGCnuKG6ItcXjiCGtJnWYO558KcwOzFjWiKCNCDeI+xj6++Y1+R/JryNGgeeGIlwK
 zZ8DEXXOykQog5Jxr/6Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x1c/+OwZYeY=:F12phl1ePT9YhVW7AuWKGJ
 GfEzAYcaLv7jjYuREV9CbAn1ltABmCwoMr5eZ1jSytrNHxYdqVMG/RoZhmHywrWWto+MnBFCb
 rq+jmyFDHwwXWwWuebAFIsDVnqp0i3bBABF1+d39jYD/Fu6PeqN50HBgdWcEE/jYwRF60N0Da
 ad+9/IuuQeyvW0r4WLO1qM6snxSZ3PDQdFOWCrU8zosRzh8kG5v3OZBF+YIu2fv7AwoKQUP7/
 57Hes6bB+1mxXA6nXvL6zdEutwKse08CwKL28RK85UZfbcxRSeMpUHsrFzVVevluVq6GgGp+K
 1Dzf+EeVU4EaquGvYFjuLIWpiBJt0YJUKVm3B65Dm44dvPdkQy71RHWCLqguujEhBniuUipFk
 pVNkJXGNXFa13u0gohXUT2fvGOJlM7oGhuFSCOBRl0fdQjLPtmll6fupiXc3PmhY6Sao/SNzn
 uq0besAVj1lz5DMDRmzrUyg9tgzqNjfFzjPBdgbdkRe4fP/+oyyGfVOaAM1R89qRxYFZfxS2S
 En+Q1RfiDhgFs8dxZoUeuPagWypz+YF78Cf8n/BTGVoI3UFMBNK6YEkkHO8ULYV1fMVUitqiV
 hD/K6hOZs+teTmnL2VMPdObdMCXNFzmvQAXvTpXhaknmj4qbH3DNzOt6oyeQGZDOkRfZV80PV
 68tBcyMYUgyRC5uKwBReEJSinE7WJhFuMk/LF69oO9Q7e/KTZwTeEypjT33KRcawPsKgdh3c9
 ZPS32gH3K+D+3YbcVjrtw7S22pWCNdhTWqg9TB3wjZFsbA07uPz5yWXjMMW0cnEeaClbC+Oaj
 vNrL8+mZ2bT0m+y2/wJZuh21Pcz0UgJIeyTR7fBg1bzzbfdwX56ibwhYhk8+IuwJYwwg3SnBG
 4+GzL3AZEFSeLiQSHldQ==
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

This fixes a naming bug wherein we used "UREG_FP" to access the
stack pointer.  OTOH, the "UREG_FP" constant was also defined
incorrectly such that it *did* reference the stack pointer.

Note that the kernel legitimately uses the name "FP", because it
utilizes the rolled stack window in processing the system call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20191025113921.9412-5-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/sparc/target_cpu.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2ec..b30fbc72c43b 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -41,15 +41,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
 static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
 {
-    return state->regwptr[UREG_FP];
+    return state->regwptr[WREG_SP];
 }
+
 #endif
-- 
2.21.0


