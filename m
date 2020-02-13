Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC3C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8DCC217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DCC217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DYd-000325-2O
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUo-0006hL-Hm
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUm-0003T5-Un
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:30 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:46313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUm-0003Se-I0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:28 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HmE-1j4xJS1bdC-002rCW; Thu, 13 Feb 2020 13:21:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] linux-user: cleanup signal.c
Date: Thu, 13 Feb 2020 13:21:05 +0100
Message-Id: <20200213122108.965455-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
References: <20200213122108.965455-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SEIsdpIS5khGsUrVlRokoMCc+1TMm3BusnO+gHBgm0QURWBEV6y
 LG7ABpQVJA9fdsxk4wxY9gvSFjmHmv+/PvICcPBtfQZzWSiIWD7nhHeqdwt120N6T7MnCKi
 OBbBUC4086isw2K4SItuP/erZrwvDEuhVQfRjzD/qGfWknDn4Mw3fManHM+YUkZcbbKXClM
 PUttQZV8Van+8AhEPogng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N9WlkuKcuc8=:fMziHU3JDerD1IVs+dYVEI
 pPY/DTdpMptWks6pjC+ddc+bEadxt7ZujCG06qlVW+V8Kc0ID0SbWJQGprq5mFerUmxo6uQ27
 JQ8c0SdHG1Fr2Pld41VXMkUpbQnXaGpRggRLT9kQJDCYHgpW1mhFkugYiUncbGU/bklz/uiHt
 iPXZRdn9H0+/t3wnlYXdceLeRwaKxY9gpXOac6eL9ql3snkmQvQSV0nbbf2+sKzqyrUz5ltDb
 vVYKOr+XRg4HnYFr5ye9qVNX6df78z4RM4B2hAD1Lwahff/dOb7V4EHg6Fl31M43BnhzRr6PB
 38ipZSSUYPoYpyIXzfFw8mruIxRoC8PXe3snrzeq5YUuKx63DKWFg3EEYr6MKFlJto9eqGTCY
 4Dmp2faFKrF4oWyOLkziR9Eqyf10KoUYt5yKzGjRgST0s8IvYIPwt5ic1XWI0c2V6lBWGcUlq
 XJ2AaQtOclrIrLsiDkPyQWm3BXOlL+NEwY6Qx/VdJhP9lc0chGq/CA5dv0wVreYK1EKvor04X
 r+L9mVx+fhaOLKxWAKfDuBRA74DwQl60jfQfgV+vo1qlzkdCaYs0WpNjEE+2AyybumT8XDqlQ
 QmAkGE1pPQqp4atq6McR9SrS0toAhzNaWqd6fW1tUrMpRpSQBUCS+NDp8fXOKNJH1zikFJZl8
 5Pl0GgfXgpj4LsjQf75ZCkpvHcPKRhO6Aa6/maP50CTXv7lvy+npDERMg9WgwmjbjKnybSgjJ
 WKvSe6neT2M1GOUYDK5zg58picuHfFpZErlUMWJY678SxO0NEwTYE/mfr65JuPXMrDFcwF+iS
 m4CqrspD6YDOuowlVzZrFmJZJwe3ZKs+hlVqtiigmUvM/Op6g/HvTeBkQqCYvfbGOiKkza2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional changes. Prepare the field for future fixes.

Remove memset(.., 0, ...) that is useless on a static array

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200212125658.644558-3-laurent@vivier.eu>
---
 linux-user/signal.c | 48 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15d3..246315571c09 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -66,12 +66,6 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
     [SIGPWR] = TARGET_SIGPWR,
     [SIGSYS] = TARGET_SIGSYS,
     /* next signals stay the same */
-    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
-       To fix this properly we need to do manual signal delivery multiplexed
-       over a single host signal.  */
-    [__SIGRTMIN] = __SIGRTMAX,
-    [__SIGRTMAX] = __SIGRTMIN,
 };
 static uint8_t target_to_host_signal_table[_NSIG];
 
@@ -480,31 +474,45 @@ static int core_dump_signal(int sig)
     }
 }
 
+static void signal_table_init(void)
+{
+    int host_sig, target_sig;
+
+    /*
+     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
+     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
+     * To fix this properly we need to do manual signal delivery multiplexed
+     * over a single host signal.
+     */
+    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
+    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
+
+    /* generate signal conversion tables */
+    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
+        if (host_to_target_signal_table[host_sig] == 0) {
+            host_to_target_signal_table[host_sig] = host_sig;
+        }
+    }
+    for (host_sig = 1; host_sig < _NSIG; host_sig++) {
+        target_sig = host_to_target_signal_table[host_sig];
+        target_to_host_signal_table[target_sig] = host_sig;
+    }
+}
+
 void signal_init(void)
 {
     TaskState *ts = (TaskState *)thread_cpu->opaque;
     struct sigaction act;
     struct sigaction oact;
-    int i, j;
+    int i;
     int host_sig;
 
-    /* generate signal conversion tables */
-    for(i = 1; i < _NSIG; i++) {
-        if (host_to_target_signal_table[i] == 0)
-            host_to_target_signal_table[i] = i;
-    }
-    for(i = 1; i < _NSIG; i++) {
-        j = host_to_target_signal_table[i];
-        target_to_host_signal_table[j] = i;
-    }
+    /* initialize signal conversion tables */
+    signal_table_init();
 
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
 
-    /* set all host signal handlers. ALL signals are blocked during
-       the handlers to serialize them. */
-    memset(sigact_table, 0, sizeof(sigact_table));
-
     sigfillset(&act.sa_mask);
     act.sa_flags = SA_SIGINFO;
     act.sa_sigaction = host_signal_handler;
-- 
2.24.1


