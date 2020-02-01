Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD65C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F2720661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F2720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixrvz-0004wd-PC
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixrsy-0001VS-KT
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixrsw-00020a-QD
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixrsw-0001rm-FU
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:26 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGz5f-1ikvSV1O7f-00E5JD; Sat, 01 Feb 2020 13:27:52 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user: cleanup signal.c
Date: Sat,  1 Feb 2020 13:27:44 +0100
Message-Id: <20200201122746.1478003-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
References: <20200201122746.1478003-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7zhL+jA1WW8QN7P25L0DrgsTFWKM/ZP9umW7q9LSBzMk7aFrWYF
 W98x0rXUCb5NCLTjiVRjbaivem1ujtfjPYG0PZl0H3dG5puav6zO7HzczmT0wkIPrO9g88m
 xh7f7tdvUpbP9z9ywnYU7Mb6GPlYEhZOotYDd9xIqaeQFEj9phCfObpEXDNEgNCjl0Kf4n4
 I5vdo/FxqNKu6VWWpsB/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WCaQOZ0tSM0=:GB3r8XpTQPWFFu3o5zkRP/
 2YJjrkwlZOy/Ss2qz3NjaQjzh7VRP6ZUWZQAOmclGm4WFlPFAv+1HEmBEzcLIxpeGskmzAv1S
 16ELu0aqggs/+g31QgojsDdq8/DREBcLZ0nnbz4OTaANrIL3IV+dleyz5QaqBJRPM/UQoiK8q
 v75GDq0vPMdhJ3iHu9cNm2CeobQo93gWt4nIbwjfO9+bhqhboAyedhODOGX1s88db81aemEKR
 eUUEPxKpMlcBUs8lfY1gHXUN2QeKi25IxnXV9got7Z5Ide3R24Vz9jDMo4mJTvXH/SyGyYa+I
 7o9/ncZjJuxoTudiW+V1s1idiXFKXuHOxzD7aDTMjKiWqLMsi5GbwQukUBJqUfWbdKQpXGRcr
 6kPb0Q+6PE9ZCURC0GuXECP6sBvxQL4X+hezuGeR7ZV0fX2pTkZdEFwTDJftAiX3BinyU3nkS
 q8LjuK0GyI7TlbIYW5gzhKSxSxR94GhLL6wBdd3hekwO/wcZ6pVnkGHp+mQqxP7yna20hbJB4
 vwfuS4Jrmv0f3oFo2wbnC8Eq1JuzmmMWLs27akZUxbAVVnulODdiGaV46dDJeBCB7l8/c8a3+
 qYPRd3shD86HXcrEmXy6fKxiiXe+tXnJC5l6OV4KppVY6nPMSHb+QzsLbdY3wNpQcOtTvuUdf
 Y4iwdr6RTkq+UxAmhrLOucrCtp0726IHp0GHH73/U1t8VVMWVecjUpWwKX9pKDJV3ARlAOT5R
 5wWVKT8GLkcPTqkKP36ksC6kcVJz/YkmvBeFys7TjID18TnURvUQqnq/NBH15L31dZSLCMobs
 JKwCZSKDs5cq+Qi4cwIiWOoXgH2exTybIqJIjaYHp3DsHxo9xf/WEkyHyq7Qwr1rFgtuFgS
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

No functionnal changes. Prepare the field for future fixes.

Remove memset(.., 0, ...) that is useless on a static array

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 5ca6d62b15d3..f42a2e1a82a5 100644
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
 
@@ -480,13 +474,18 @@ static int core_dump_signal(int sig)
     }
 }
 
-void signal_init(void)
+static void signal_table_init(void)
 {
-    TaskState *ts = (TaskState *)thread_cpu->opaque;
-    struct sigaction act;
-    struct sigaction oact;
     int i, j;
-    int host_sig;
+
+    /*
+     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
+     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
+     * To fix this properly we need to do manual signal delivery multiplexed
+     * over a single host signal.
+     */
+    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
+    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
 
     /* generate signal conversion tables */
     for(i = 1; i < _NSIG; i++) {
@@ -497,14 +496,22 @@ void signal_init(void)
         j = host_to_target_signal_table[i];
         target_to_host_signal_table[j] = i;
     }
+}
+
+void signal_init(void)
+{
+    TaskState *ts = (TaskState *)thread_cpu->opaque;
+    struct sigaction act;
+    struct sigaction oact;
+    int i;
+    int host_sig;
+
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


