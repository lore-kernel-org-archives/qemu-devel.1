Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90072C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C8320661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C8320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixrwz-0005tF-Lw
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixrsy-0001VT-KM
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixrsw-00020n-R8
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:40997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixrsw-0001we-GP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:26 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McY0L-1jY12a0a8D-00cuwv; Sat, 01 Feb 2020 13:27:53 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
Date: Sat,  1 Feb 2020 13:27:45 +0100
Message-Id: <20200201122746.1478003-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
References: <20200201122746.1478003-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A58pRxSyC0i9mJW78ERtAsZVHvI/IaDIu97TPpAlAYdv2/nJEwY
 oIwJojyPw1l2BL6e8aPOAcqyPDncfx81RcVXk8kYWAjHEyBAz+yEzyy7iNN85R4BGftZsTd
 IxBaqdtxwLiP9MK9Z1+qE2mYvN6qCuMoTLxZC1dGfeXY0oNypQ2fvNyGWLiysEZv9wnQecS
 Pak5EYHgowxuyUpFSA0TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:noddaypDHQQ=:Ez3ZNKXuZLW+nzmbn1m4aA
 QlWc8UzdQZIlUbAKFQNBIvXlVlqQp4MNSy/yoAnlOlZRZ1HOMRNtIlbEv4XOk9YUT6vBSQVXb
 Q8vg/M3i5Gn1XWjJbkRwJ6c792rL4HRRxVmq8SMJTpmuJ+aBPdrbBVIbOA1eEctd9Uo6weZSu
 GyfARXKHteLqQ3S+n+0yl+UKwCX123hKFFbKg5I8mu6p5gUeurF1aVxryX3KcOZVas91TSG/k
 aMIf7lVbQ2OdQVJaxtPnzuXDKDkfYGQPfa0wJLhxEgYwCFc9R2q8odvQgNZYYGO9dhjjKHY03
 Z6jjAI0+eNdGxV/3Ec1kMoTGu+bh9smlRyC6VqGuAdokViGlNWeoYvqf9gKz3y5AtPk8rVhMK
 nBVxkfz9SjsLEqsHigXKrO44tWrv/+cQ0oZUJouzl7/lKGa9gWs1kMHc33h7JMby7CMAuMt15
 DcE4tOiDoKMIHZAnemMMiYAzVVZ0UgJuIg1MYLX+scqYfvM3NIbXF+SttSwQjNnk55HZLhvec
 b0M2zkY9e4o9hceY6t2F3zWgPm8NUiJ7oagmCxBwZ/ysWsMBFWggYP65io3D90kJ8qrDKRE5c
 D6uNPFRrZRaCUNVAOBnB9nr14eS1ORwxSO532thIp6K2/GGG7fTjhRGoDy7TAgqz1bh/2MTXU
 R14TiHceMnniFcYZEjMKPU5MNPR9057MtyScoJlOQ1IhEzjuyQmIti4iw51dV5aGW7QKlTxMZ
 /+bEe9lLGyPhbsG9kubCQUDvvAI7j4TiQtFzKbCcy8upI33UoG4zgDNbd3ty3pyMnLLVItYUI
 AiXVCfH+uLffkc0N3R5+56yUFZji2snC+7pPo7ioD7ri/+TThJ66eaGo0P3iZ55pJsx/fJA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.

System includes define _NSIG to SIGRTMAX + 1, but
QEMU (like kernel) defines TARGET_NSIG to TARGET_SIGRTMAX.

Fix all the checks involving the signal range.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 51 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index f42a2e1a82a5..3491f0a7ecb1 100644
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
+    int i, j;
     target_sigemptyset(d);
-    for (i = 1; i <= TARGET_NSIG; i++) {
+    for (i = 1; i < _NSIG; i++) {
+        j = host_to_target_signal(i);
+        if (j < 1 || j > TARGET_NSIG) {
+            continue;
+        }
         if (sigismember(s, i)) {
-            target_sigaddset(d, host_to_target_signal(i));
+            target_sigaddset(d, j);
         }
     }
 }
@@ -122,11 +140,15 @@ void host_to_target_sigset(target_sigset_t *d, const sigset_t *s)
 void target_to_host_sigset_internal(sigset_t *d,
                                     const target_sigset_t *s)
 {
-    int i;
+    int i, j;
     sigemptyset(d);
     for (i = 1; i <= TARGET_NSIG; i++) {
+        j = target_to_host_signal(i);
+        if (j < 1 || j >= _NSIG) {
+            continue;
+        }
         if (target_sigismember(s, i)) {
-            sigaddset(d, target_to_host_signal(i));
+            sigaddset(d, j);
         }
     }
 }
@@ -488,13 +510,14 @@ static void signal_table_init(void)
     host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
 
     /* generate signal conversion tables */
-    for(i = 1; i < _NSIG; i++) {
-        if (host_to_target_signal_table[i] == 0)
+    for (i = 1; i < _NSIG; i++) {
+        if (host_to_target_signal_table[i] == 0) {
             host_to_target_signal_table[i] = i;
-    }
-    for(i = 1; i < _NSIG; i++) {
+        }
         j = host_to_target_signal_table[i];
-        target_to_host_signal_table[j] = i;
+        if (j <= TARGET_NSIG) {
+            target_to_host_signal_table[j] = i;
+        }
     }
 }
 
@@ -517,7 +540,7 @@ void signal_init(void)
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


