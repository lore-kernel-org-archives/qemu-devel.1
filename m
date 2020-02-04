Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08620C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D472E2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D472E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz22R-000471-1D
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz1jl-0007OS-Ds
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz1jk-0001pY-5R
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:45 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz1jj-0001ma-SJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MStKw-1j7JjN2GLe-00UFah; Tue, 04 Feb 2020 18:11:12 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
Date: Tue,  4 Feb 2020 18:10:53 +0100
Message-Id: <20200204171053.1718013-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204171053.1718013-1-laurent@vivier.eu>
References: <20200204171053.1718013-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VGnP/pTFnc8m9VvJBOJmv749YqgIDfWpmBAn8fYK+N/GwdhnQ9H
 ubNYF8APtbkxvfTv17RJmmLrKAQ+bPUAL68NB1b7PiQIVxsT+kjgS0Op7Dl/4J14sS0vqFX
 8fu59HBOe3Op8gZBAkNlUOxu1unrp3xvWQxG5NMkTMnhyT0qYvYXDKaVM+FFjMj15fEu8qx
 EESvlw3afQYWUuOE7pDlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tm4l63WDylA=:9QvhemgoUWUkKSYE7PUrB9
 xKpF+N2QBwGsL4+8PAE/XVqeLb33nHkSoSBlBBJ/YZC2ie2zxCI731bVS8cKKdYZdrirJVLyd
 DJYeWSOduBD481PSrdfYObzn5Nn1DemF9kSgdk7nFNqRCmjrxFw/RCKp3DnQY9xMU6MJU49WM
 DgMQqq5AHMbld41/8hyQaG4l5y5wx2RR994Pga4WJulg5Qm5+DxZsqSFmt3g6SL51Zkj4TbrP
 fg5neaGjpHzXrFI9N5VDleZCX/OoRk5lz1GGqt1wW6YewpX5wkXWa2DX7Bk7SP4hZhgsGUqi7
 WhaEw05Y/GXuV/1SnE+NtT9ZkOmE1WiEI0XV9Ojkv44ZZf/2ielRVMvN+qathamTL6nMySHCO
 J5Xzoknxs98kYVk3nXMuxnnWfiJHPO4fkq+jDAiZHnLEnhT1pgy6mDQwo0jT5/0BbjEZu8QKE
 PQeY2okPDpfK6FXwviJU1ZMvoogOg/oc9vKnzcw+onMz933ePOzQj6QyvmCsLT5bFiyamuUnJ
 qz65g2CA48PqOMRnLeKVOrqf7YtSvpPbFwdnWnLRAx+flvVPFlTGhJlfjIwA3kG032NSGw1MR
 7h1T1Pk1EtRT5Bh9TtX0e5geo+qC2ROdGs06Pkwc8O1jlQBYlLTG30EkdCDitzQLSBf5OC851
 Byqxd4eiO2PumNzBHzK3Rb5KY0diqq2fGKdNnejgKQ9em5YmSQNPRGiQuIZ2y2uqoJEN9FSpb
 eMcVB2ldfTzHva+7rabLqJB81GSOaUHX6ZtB8Gd4Fsg9ooW/7SEG5WcXhFZK3cmv4bbEWl7nM
 7u/L88QTIAWLcxW3gAhWyeQPFsgL72NkT78ksV1I1KCePurcRcjtCnw3XQfYlEydxPGJKCX
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

Some RT signals can be in use by glibc,
it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).

So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.

Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
      [__SIGRTMIN + X ... SIGRTMAX ]
(SIGRTMIN is __SIGRTMIN + X).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: ignore error when target sig <= TARGET_NSIG but host sig > SIGRTMAX
        replace i, j by target_sig, host_sig
        update signal_table_init() trace message

 linux-user/signal.c     | 37 ++++++++++++++++++++++++++++++-------
 linux-user/trace-events |  3 +++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c1e664f97a7c..e7e5581a016f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -498,18 +498,23 @@ static int core_dump_signal(int sig)
 
 static void signal_table_init(void)
 {
-    int host_sig, target_sig;
+    int host_sig, target_sig, count;
 
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
+    for (host_sig = SIGRTMIN; host_sig <= SIGRTMAX; host_sig++) {
+        target_sig = host_sig - SIGRTMIN + TARGET_SIGRTMIN;
+        if (target_sig <= TARGET_NSIG) {
+            host_to_target_signal_table[host_sig] = target_sig;
+        }
+    }
 
     /* generate signal conversion tables */
+    for (target_sig = 1; target_sig <= TARGET_NSIG; target_sig++) {
+        target_to_host_signal_table[target_sig] = _NSIG; /* poison */
+    }
     for (host_sig = 1; host_sig < _NSIG; host_sig++) {
         if (host_to_target_signal_table[host_sig] == 0) {
             host_to_target_signal_table[host_sig] = host_sig;
@@ -519,6 +524,15 @@ static void signal_table_init(void)
             target_to_host_signal_table[target_sig] = host_sig;
         }
     }
+
+    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
+        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
+            if (target_to_host_signal_table[target_sig] == _NSIG) {
+                count++;
+            }
+        }
+        trace_signal_table_init(count);
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
@@ -847,6 +863,13 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 
         /* we update the host linux signal state */
         host_sig = target_to_host_signal(sig);
+        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
+        if (host_sig > SIGRTMAX) {
+            /* we don't have enough host signals to map all target signals */
+            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d, ignored\n",
+                          sig);
+            return 0;
+        }
         if (host_sig != SIGSEGV && host_sig != SIGBUS) {
             sigfillset(&act1.sa_mask);
             act1.sa_flags = SA_SIGINFO;
diff --git a/linux-user/trace-events b/linux-user/trace-events
index f6de1b8befc0..0296133daeb6 100644
--- a/linux-user/trace-events
+++ b/linux-user/trace-events
@@ -1,6 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # signal.c
+signal_table_init(int i) "number of unavailable signals: %d"
+signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
+signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
 # */signal.c
 user_setup_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
 user_setup_rt_frame(void *env, uint64_t frame_addr) "env=%p frame_addr=0x%"PRIx64
-- 
2.24.1


