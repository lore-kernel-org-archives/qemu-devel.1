Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33043C33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D8020661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 12:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D8020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixru3-0002sD-6b
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 07:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ixrsy-0001VU-Ky
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ixrsw-0001zJ-HA
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:27 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55499)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ixrsu-0001pD-Va
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 07:28:26 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzz6s-1jjnGp42nG-00x5A6; Sat, 01 Feb 2020 13:27:54 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user: fix use of SIGRTMIN
Date: Sat,  1 Feb 2020 13:27:46 +0100
Message-Id: <20200201122746.1478003-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
References: <20200201122746.1478003-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uZvkDltmplsVxV9Exg8Kxxvw24erQUxYov1pUBuC/j8lafDsly+
 UilvZAL8JzwbrxsoYImkxI6jyM+z+xlkdme05yogHsUXUSngYLVcmnv+qmilg8LA/KmG/AI
 c6haOJebBNzj0NJBZxA9YrRfLwzpdc2PTyNEx3ta7j/fbmY7WrOEVbFRmLhBKtjrcx/O550
 UOZOY0/8W7o03WlheMmHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sidQ/StkU1M=:NKl/OWvunHRjA7l9h25j5/
 4uO7yHhCvfzU9Nf2urBPcfFBVBVE+Cs5MJ4FwRd32VdB1aI3ElOBA0H5lLFmoMRttXJAEz9jN
 l6Ctb/iiH3MGMui5pH+/zYSYQG0P6WDUvMNt+IEq64f/KP1WIznNRyBqpPrauPQVvCjkJ2X2G
 04Ks/MkbQW6HEusPAtExy+PUxzPLCYKfnYI2V9UYbvtWLklXEiJsVD7oJi54p60ydeYVX75Q7
 F/6f7orWScbWHXhLZYae3vYO7818C21t6nfNODyZ7nYOu9b+dh69+Ff2i5sHYlw/MSKR8o4bE
 TVNIXA5Zbn4Hkd6RTi8wUYa2InqX8OQGixrXpZ2ino/e5m39NPxTSeUZ8ZGTRvbJkh22Isdo7
 liYjJKiVWy2+aJa4YdQamFeKHY/VSXh++0PnMLb5tbyGcted6LKRoyS/tqJ3dxq4biwBRgi3E
 jhzo+Sg79BuH8kW6e0jIaqThW81O25X3QR9sw0VrgbY8WNOG7/DxazV0dIKkRe+zv7Yx2ttLx
 qYjyBZ2PXrF+SPoxKMAAOsGUfY+uw3j/2FS1KVlaSjH4q+VMdn4CGkre7eEGxsgnT1UQCDbyt
 /5qxhWuTikUyYA9iNqeR7NezQiCU+ttRpeDwpHAbh4BR2UabJ/fy/SHV5JziXtcLm+rnkHMyz
 7HGOivOJ2oTdO2HObY+FbFIMAcZuqo2V4hZvDfJSK6dLC8BGvj4tn3uwIiQzidgNM/tdi3P4y
 ckWT+M9w1GOVIzinUpmBqJIrX+ZgK6gGci0QnwqwnDw5CtPaRoJxnsqmTABUgeMUiz21r/xDg
 vmUyJZZSFR3KZD/o/ThR99kfwNxZpfMTrEgTePv8WIpNkbZP4rPtAt52HXBmaKBr0/lcG+z
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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

Some RT signals can be in use by glibc,
it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).

So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.

Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
      [__SIGRTMIN + X ... SIGRTMAX ]
(SIGRTMIN is __SIGRTMIN + X).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/signal.c     | 34 ++++++++++++++++++++++++++++------
 linux-user/trace-events |  3 +++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3491f0a7ecb1..c4abacde49a0 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -501,15 +501,20 @@ static void signal_table_init(void)
     int i, j;
 
     /*
-     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
-     * To fix this properly we need to do manual signal delivery multiplexed
-     * over a single host signal.
+     * some RT signals can be in use by glibc,
+     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
      */
-    host_to_target_signal_table[__SIGRTMIN] = __SIGRTMAX;
-    host_to_target_signal_table[__SIGRTMAX] = __SIGRTMIN;
+    for (i = SIGRTMIN; i <= SIGRTMAX; i++) {
+        j = i - SIGRTMIN + TARGET_SIGRTMIN;
+        if (j <= TARGET_NSIG) {
+            host_to_target_signal_table[i] = j;
+        }
+    }
 
     /* generate signal conversion tables */
+    for (i = 1; i <= TARGET_NSIG; i++) {
+        target_to_host_signal_table[i] = _NSIG; /* poison */
+    }
     for (i = 1; i < _NSIG; i++) {
         if (host_to_target_signal_table[i] == 0) {
             host_to_target_signal_table[i] = i;
@@ -519,6 +524,15 @@ static void signal_table_init(void)
             target_to_host_signal_table[j] = i;
         }
     }
+
+    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
+        for (i = 1, j = 0; i <= TARGET_NSIG; i++) {
+            if (target_to_host_signal_table[i] == _NSIG) {
+                j++;
+            }
+        }
+        trace_signal_table_init(j);
+    }
 }
 
 void signal_init(void)
@@ -817,6 +831,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     int host_sig;
     int ret = 0;
 
+    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
+
     if (sig < 1 || sig > TARGET_NSIG || sig == TARGET_SIGKILL || sig == TARGET_SIGSTOP) {
         return -TARGET_EINVAL;
     }
@@ -847,6 +863,12 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 
         /* we update the host linux signal state */
         host_sig = target_to_host_signal(sig);
+        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
+        if (host_sig > SIGRTMAX) {
+            /* we don't have enough host signals to map all target signals */
+            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d\n", sig);
+            return -TARGET_EINVAL;
+        }
         if (host_sig != SIGSEGV && host_sig != SIGBUS) {
             sigfillset(&act1.sa_mask);
             act1.sa_flags = SA_SIGINFO;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index f6de1b8befc0..eb4b7701c400 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,6 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # signal.c
+signal_table_init(int i) "missing signal number: %d"
+signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
+signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
 # */signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
 user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
-- 
2.24.1


