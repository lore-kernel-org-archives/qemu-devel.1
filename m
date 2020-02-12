Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EA5C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01A5120659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A5120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rbx-00010s-2q
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1raj-0007Zt-Gc
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1raQ-0003sp-A7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:58:09 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1raQ-0003rz-1W
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:57:50 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mf0Je-1jgxlC0qNu-00gb2i; Wed, 12 Feb 2020 13:57:04 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] linux-user: cleanup signal.c
Date: Wed, 12 Feb 2020 13:56:56 +0100
Message-Id: <20200212125658.644558-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212125658.644558-1-laurent@vivier.eu>
References: <20200212125658.644558-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5yQW3PadDMTzB7MqqP37WiutYZusz2vYjt41BNW8gbwyzSkMSpj
 bYq9P9Z+LW3c1LtKL5z/dspzIzdxjjDG/I+R2yYLYJTvduyXencBmmgn9nN9GVwfcS/8ymI
 XgOukRJHwHGgWI1UZOjeLFr3sWtfD5PhSuVvLPFVhZ64ZTmFShR2zoVkFGUqhoVd4T2mL8T
 8QZkyD8KGCl02NI/lLXaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OeJ/U5YmL1g=:u41pPUdVaxdVGy6NWcDx+0
 kyHhQz5Bq0+JFI5K66E+3bYPSIn0ffbjEZkZ6WHsROv4CS5Ja8GZYLR8bRvaAxwQtmGGswxjA
 SJiTUzFXt74C2Jp98LH5mUY0vkYUtIBbyqwgLeWjMVM4dfPxvw+3cmYv/j0QKBZZVx86Dndkg
 524XaLoaUZVAGMzjYelxL0itS6fXac+Rs5IGsaRcZa1N1gfeYjgNNZW5YT9JHkU7WX+kkCcMR
 tfDK4H3On4GRTZz4TkiEu/5HYKfcJH1c+uQ6p7/LX8SQTFu4MA+w5z1/L1ZnAd6lwd46TK0Lk
 0WpC7ahGJTAEPAcMw2x43UsuIeYpruArPUtMsB4tl6vt01xAYFF6Kh6nXZmrS2MTjITPgfgLF
 gr36I33NFy6kuA2oAQZrY1msvS4EzrJxpHXqUwDpbBruRn7nOwccIToVIrEj2wAwVBr1pTbpx
 G1pQ4I7JTb4hAxu0pqk5WQ3F25MM59RNGn9TVLvHvIl04BTpUtZKW/RaBZvJGkFLeqn0QAPPm
 jmmFhC7r60HMb2U7Zxzi71B0zeLd0jqha7eLUgq26MaoCxAbt55nBNu5HFv+wu25pEzsfmg+Y
 MEBRXOulapvwAcEJdm0mIoqB/eiF4p473ym1HwSD+QxaCnJUz93JG0wgN5a/ArFMnNyrHTNyX
 UL1VoPGtwBe5tXq/mdbUMLWBqee4KOoe9Scw459VbOjazHqEZOKHNDcIXlX4QPWyC/sXD2Dus
 Lk4UprUuhJODEKWWFMu5cecZqhUvdIGAFeOgiwIUg2hXtTEFoF0bRSrwFGyKkTkE1MNDMSNqR
 9GOB5Q54+bZFgG+aD16ubJ8mTQ3ZzCL1JnS/y+xuh84aggShfkLOb5KAawMDgmde6N/dC1E
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
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional changes. Prepare the field for future fixes.

Remove memset(.., 0, ...) that is useless on a static array

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

Notes:
    v2: replace i, j by target_sig, host_sig

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


