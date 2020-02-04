Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615B9C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 392732082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392732082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz23P-0005ns-DM
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz1jh-0007ET-OJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz1jg-0001g9-I7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:41 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz1jg-0001dh-8l
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWzXd-1j10k811lR-00XIGO; Tue, 04 Feb 2020 18:11:09 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
Date: Tue,  4 Feb 2020 18:10:52 +0100
Message-Id: <20200204171053.1718013-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204171053.1718013-1-laurent@vivier.eu>
References: <20200204171053.1718013-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:89wBAKLTrp+zE9n8im8ri/9yJNtqGZYzXt8qUsE6KXQlMfNu2oh
 UuwYixD6UQ3NIQ99Eam1WxfBV5mqRrfVSdaimdgs4WEnZkfW2XXwU/H45Jbq25r3Wn8s1Vo
 QwKi4TokRVvuJClEIVg39AN2LL2FVzOeFA13rj7+hK60bT5wPC4o0XAYnBvWyCgS8OMxL0D
 uY/QiR4qySyXW9QpABBPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d4XJ6fcvKvY=:Wx0oyMpPw3fsH+LhQhwbnb
 SH8UrckX18+W0/t0cShLetRBA0/K5kqHkuRDZb2a6rkPkIzcu01zaj0eiC8bZ5XeyKKxnVYnR
 5OkbZ/jUvvA4S9OWa3Ded8PmJ7nTLL+nMWbD+63omzG+svXGEJlri8lkaYx68wAGMpfGIH7Kg
 60w0dkymF4crKCGa6RSm1riI48UiqlrSWR7PFe8huFB+qfurCGJVf2rzG3RcW9WsBlyCu6HUx
 BhpXkl91orLf26hzjfVpXICuThD2Tl9Nzsxq3JjHxvtoa5Nq2HjOufte/xJv8QJVFh3O/UgmY
 jRbRGI9Ckq578t6BwRTPNR4n5JWrKstyXCEqMFB07S41X2MLUKL/+rpjnlDceNv6RjyuwOrfL
 OW6d84KPpFxaNYpJwtr5RRDMlEVkCDFX3kwZCyihwcYWIpZqnceU2lx38DaVn6TJ+30XLaTJu
 eNGuCynNMiYnBcG1K4OyzAiougEn4iAwLhgMCAhu/b5pE1zZB2+mcLChqFD8hLBx7B+/I932q
 mSTNLqllsNBU9NNxDo9W877YKN2i3kvrkzpQqXdHpEOwOmCC3JhDbI+rhv+hggviB4iwuD3af
 d0ONxWizbEFaW4jdaAb20koqKTQkrqIs0vMoObAiK0w2lFP0O/SOMtqtGDQdYUNVOTpxAwXtU
 YsPo7feAhPaxy5uja7TNEow3mnxTYJJYmzeaWWWzhBqjQUiyrlBcFwqhHcnhI5aq+qtaKaHM9
 0C9R8LsTrKIXYfWjNozusLIDwjOzU2dg/Ex+rMpW8esxCRhPSDSNseMu3qv4FW8y/v8skw3jn
 KXvuaDt0Qo9T65dZaSE1EP2HqeSfqPjuFhSYrDa3/DlFR0i2O/jfM0LfrcyY53FbUQPCkUw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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

Notes:
    v2: replace i, j by target_sig, host_sig

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


