Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC8AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AF1222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AF1222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DVZ-0007QN-IF
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUf-0006Xq-1A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUd-0003Mv-RR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:20 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:55905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUd-0003Mf-I5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:19 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mgvj3-1jgkIn3t3V-00hQst; Thu, 13 Feb 2020 13:21:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/5] linux-user: fix TARGET_NSIG and _NSIG uses
Date: Thu, 13 Feb 2020 13:21:06 +0100
Message-Id: <20200213122108.965455-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
References: <20200213122108.965455-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ImjfzA8yN07Xrsgut7wGvlm4lfTs1AoZTmdxsWJtcVvDfms5WBS
 zbCOtzwdYhSiLxZstVw6muo9CkgMU/swgrejmzIHaJd/Uy0DcsRr1TiVeKQSTeKzbLsi7UY
 t0c5lK6TcLccw4Sx1CMnRICi5H3AjufS2VGGDXEJDgkIZ+F8B8BXVvw8K1R4nkb9jxg0nCx
 IwBr0w/foXiZPFY1FBsmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BarVK4u5Zn0=:jxBsOQQDxQGl0vmuRNX3MV
 wXR2zmW1kPxw/lpGBj/YZ0gxP/Rq6yLEDfjkBXrvhpQYMpUqmfA1S5RIu9EYCjBZerNsjATyi
 g+8NM/em/hsoQrAeiMFLSjHoxRiBovkEujndJqXpJyJuzy1DdQ7Kf5JctDZQuZAEH6NsgfGVt
 QsInJz6zXCO1z70mhThBPyGg8dDWbkHj+AhDeeNtTgNmDwGHYe4pOP5/YDNFeX5PErdIXAubt
 g0A8OM3YLkqnC9SuNk9nA+SHdm7ltT5OAucMvJzfoixC0oCg09h8YbrCRkhwbns0ZGt1bS9PL
 JgykOrXym73+/9JTqfZBYKneMP6ZYTNGiNBcFJkDTRnVuUgrVR2DpXP5SFPtImQ+6hgiF9g+8
 oJF4TN6Huz2W7abCBlb/QNRfGQY/6Pf1oE0XjkDczPrE7unYZsuZMt0PitmNRlV0GAuLGL8L9
 jFKmDERUyMa4MJ7BVs3oPbbmXvxtBZCjiNh55Nf8rF78qYsyXMNWq4dUVEt7gktbkmjDAc5GQ
 pg1loNQuLDYS/fybrn+bBTvRtvd/0o37pxMdK1FaEhLJOlg1Q/THghBSsAjwmj/KeWUf4SMTo
 ixz2vJqckozSmWub5Ml75uIgX0x46LHcHx0oY8CzCvNfUeHCVL/Ky6+eK1smie8BFJaBwCJgU
 vzxOwQ9+hVq5r2VhpFoYDs/R/RGlMg+I8eavTxjwBsa6fNvjjMOXx+Y22lrr17iLoVlDxYaOb
 5byd0KuDsu767HoCD1QhVgUAVeKsm5lsBej3H7ia2kJiHILN3JhL4wKFTwhZTLSwwOMRwU1Zr
 h9IUZoeooZHr9rv8I8Fh6bDYXiXqhoxkXFQfTUGTXji1lVSfzAzX1W9wRHy0b34nPyjOJJ0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.

System includes define _NSIG to SIGRTMAX + 1, but
QEMU (like kernel) defines TARGET_NSIG to TARGET_SIGRTMAX.

Fix all the checks involving the signal range.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200212125658.644558-4-laurent@vivier.eu>
---
 linux-user/signal.c | 52 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 246315571c09..c1e664f97a7c 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -30,6 +30,15 @@ static struct target_sigaction sigact_table[TARGET_NSIG];
 static void host_signal_handler(int host_signum, siginfo_t *info,
                                 void *puc);
 
+
+/*
+ * System includes define _NSIG as SIGRTMAX + 1,
+ * but qemu (like the kernel) defines TARGET_NSIG as TARGET_SIGRTMAX
+ * and the first signal is SIGHUP defined as 1
+ * Signal number 0 is reserved for use as kill(pid, 0), to test whether
+ * a process exists without sending it a signal.
+ */
+QEMU_BUILD_BUG_ON(__SIGRTMAX + 1 != _NSIG);
 static uint8_t host_to_target_signal_table[_NSIG] = {
     [SIGHUP] = TARGET_SIGHUP,
     [SIGINT] = TARGET_SIGINT,
@@ -67,19 +76,24 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
     [SIGSYS] = TARGET_SIGSYS,
     /* next signals stay the same */
 };
-static uint8_t target_to_host_signal_table[_NSIG];
 
+static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
+
+/* valid sig is between 1 and _NSIG - 1 */
 int host_to_target_signal(int sig)
 {
-    if (sig < 0 || sig >= _NSIG)
+    if (sig < 1 || sig >= _NSIG) {
         return sig;
+    }
     return host_to_target_signal_table[sig];
 }
 
+/* valid sig is between 1 and TARGET_NSIG */
 int target_to_host_signal(int sig)
 {
-    if (sig < 0 || sig >= _NSIG)
+    if (sig < 1 || sig > TARGET_NSIG) {
         return sig;
+    }
     return target_to_host_signal_table[sig];
 }
 
@@ -100,11 +114,15 @@ static inline int target_sigismember(const target_sigset_t *set, int signum)
 void host_to_target_sigset_internal(target_sigset_t *d,
                                     const sigset_t *s)
 {
-    int i;
+    int host_sig, target_sig;
     target_sigemptyset(d);
-    for (i = 1; i <= TARGET_NSIG; i++) {
-        if (sigismember(s, i)) {
-            target_sigaddset(d, host_to_target_signal(i));
+    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
+        target_sig = host_to_target_signal(host_sig);
+        if (target_sig < 1 || target_sig > TARGET_NSIG) {
+            continue;
+        }
+        if (sigismember(s, host_sig)) {
+            target_sigaddset(d, target_sig);
         }
     }
 }
@@ -122,11 +140,15 @@ void host_to_target_sigset(target_sigset_t *d, const sigset_t *s)
 void target_to_host_sigset_internal(sigset_t *d,
                                     const target_sigset_t *s)
 {
-    int i;
+    int host_sig, target_sig;
     sigemptyset(d);
-    for (i = 1; i <= TARGET_NSIG; i++) {
-        if (target_sigismember(s, i)) {
-            sigaddset(d, target_to_host_signal(i));
+    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
+        host_sig = target_to_host_signal(target_sig);
+        if (host_sig < 1 || host_sig >= _NSIG) {
+            continue;
+        }
+        if (target_sigismember(s, target_sig)) {
+            sigaddset(d, host_sig);
         }
     }
 }
@@ -492,10 +514,10 @@ static void signal_table_init(void)
         if (host_to_target_signal_table[host_sig] == 0) {
             host_to_target_signal_table[host_sig] = host_sig;
         }
-    }
-    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
         target_sig = host_to_target_signal_table[host_sig];
-        target_to_host_signal_table[target_sig] = host_sig;
+        if (target_sig <= TARGET_NSIG) {
+            target_to_host_signal_table[target_sig] = host_sig;
+        }
     }
 }
 
@@ -518,7 +540,7 @@ void signal_init(void)
     act.sa_sigaction = host_signal_handler;
     for(i = 1; i <= TARGET_NSIG; i++) {
 #ifdef TARGET_GPROF
-        if (i == SIGPROF) {
+        if (i == TARGET_SIGPROF) {
             continue;
         }
 #endif
-- 
2.24.1


