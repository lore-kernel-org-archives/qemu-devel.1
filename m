Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D73C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E186206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E186206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKfA-0008CG-AZ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hiKMg-0005ZQ-H0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hiKMf-00086V-Eb
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33937)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hiKMf-00085l-4x
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7yuz-1iciKo1zT1-0155SS; Tue, 02 Jul 2019 17:06:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:05:44 +0200
Message-Id: <20190702150545.1872-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702150545.1872-1-laurent@vivier.eu>
References: <20190702150545.1872-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LpFHEjXWJe5+hRGgrK2NrzsSaOpSu+hwWG7OjaIimd1T4tX+Csn
 Ie3vTDldEy5z4aVrkRr7tJFm5yWBYoyRXzYFicWRoNEtLp6i/m0IJMzyPsTtn9nQrfvIxgO
 StvzYFVcZQ5L3VjU6PN9pfndmRbedeQac+eJouMmSfxzr+F5BwA2Y5iQABQIj7y2Fz81LZz
 tVPB+ELlzZtVsjrDEFh2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NMXCd/tQnw=:xw0KuALeq6XT6z+GFu9Sa+
 3FztXlRi7XXH6N8EnlXRinkrvISFoa04CrpzQndcj6gnLYz79EGrnFiRyIlr3knOi41mYHAeZ
 Tb88AuJP3MTY5ix55X++LHr1wF4yv0031gmvV29bYs+KIIgQmxC+2oAczF1YAdxPkJN4SkK8x
 HfX5fzOkNEzhlEayEH2qRmoEk4q6vp13xpthSHHLT5SejwnuMERto1Pbv9bB8ay2aDCy0YZWy
 StXte9neNiraZwUESDVNjHOQ/hcx+lbIdqMSZUUY99j2XQGcWdNPFga4BzFVnUO70S6GMgcVp
 JIjuTFTezan7kJ8tKvvBU5Xl6+wz4h4gNbCI4beY0WDPASChpfwS+ijti/FYTjg/3OxQ+R0zr
 he0ZxmqjPRVRL4XN2eIOkx4QtEtJUCYZMKzgIPcW9qabKNg0LPeiI8HgnNWdIHhiKzWfYyqCz
 sSMUXmVGyxzPuPsaN1/ToPKXunOjNzAAgFtDt3TJ7mYWyJLi3mtV6SJ3ifPt5ducGP14d4Pgk
 t+5T41xmrTiizKI0eOcS53tfrnM2XLo0+2enar04qRAyVY45+LZGsLPIqfhqhOng2JXm5P5/E
 4AZE4dj497SYGv2ME4Uhv+geDqwqw0+k2hfjqGX0qeg1i5XJc9hmz0pXzh/Bv0wxnUFYpWYoT
 yn4Ptv3w9T/DQI7dPFi7/VwPtCzCdZIUeS+Q6lvmkufhZJUfMS7kEKTtL6HKM2imM1qHwMO5q
 XfAFV/WMZgoD+khoKeIi2AB41gYSiCquhvd/Sg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 5/6] linux-user: Handle EXCP_FPE properly for
 MIPS
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Yunqiang Su <ysu@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Handle EXCP_FPE properly for MIPS in cpu loop.

Note that a vast majority of FP instructions are not affected by
the absence of the code in this patch, as they use alternative code
paths for handling floating point exceptions (see, for example,
invocations of update_fcr31()) - they rely on softfloat library for
keeping track on exceptions that needs to be raised. However, there
are few MIPS FP instructions (an example is CTC1) that use function
do_raise_exception() directly, and they need the case that is added
in this patch to propagate the FPE exception as designed.

The code is based on kernel's function force_fcr31_sig() in
arch/mips/kernel.traps.c.

Reported-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1561718618-20218-6-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/cpu_loop.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 43ba26754736..0ba894fa7aa5 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -540,6 +540,23 @@ done_syscall:
             info.si_code = TARGET_ILL_ILLOPC;
             queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
             break;
+        case EXCP_FPE:
+            info.si_signo = TARGET_SIGFPE;
+            info.si_errno = 0;
+            info.si_code = TARGET_FPE_FLTUNK;
+            if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INVALID) {
+                info.si_code = TARGET_FPE_FLTINV;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_DIV0) {
+                info.si_code = TARGET_FPE_FLTDIV;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_OVERFLOW) {
+                info.si_code = TARGET_FPE_FLTOVF;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_UNDERFLOW) {
+                info.si_code = TARGET_FPE_FLTUND;
+            } else if (GET_FP_CAUSE(env->active_fpu.fcr31) & FP_INEXACT) {
+                info.si_code = TARGET_FPE_FLTRES;
+            }
+            queue_signal(env, info.si_signo, QEMU_SI_FAULT, &info);
+            break;
         /* The code below was inspired by the MIPS Linux kernel trap
          * handling code in arch/mips/kernel/traps.c.
          */
-- 
2.21.0


