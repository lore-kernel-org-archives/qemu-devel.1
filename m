Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3420FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4A6217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4A6217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DXW-00021N-7n
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2DUm-0006fc-UR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2DUl-0003S9-9H
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:28 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:49887)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2DUl-0003Qs-03
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:21:27 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQ5nE-1ip4Lx1rV2-00M450; Thu, 13 Feb 2020 13:21:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] linux-user: fix use of SIGRTMIN
Date: Thu, 13 Feb 2020 13:21:07 +0100
Message-Id: <20200213122108.965455-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213122108.965455-1-laurent@vivier.eu>
References: <20200213122108.965455-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MleeMIE0cAxKS0cEfFJvt48rVMBIGdRfm5bSToK1ySZ8kt1ZrX6
 d330DfzWiYOFYbZDh6WkLKq5+ffkq45cl3zmcm3I2f7auDk8kfsZmHQR/s0HL+q4CssYrZ2
 SbWRBkIgL2BgfyQfJC2hVJucVk8x2N1MnGgOE/bkmEClRJTCd3eNwAbaYyACmrR87p3s691
 1mBUdqJquZOaohya2o33A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5Ic2Biv6Ui4=:p9ns19Vsp3jKY/I1OkYLBf
 8vZnag5+r2LBljhPaP9KirU4sgBzLz+80IQ60G/iWaoWtHQ0fZaJ9xyUACEmuTVcp7g5L4/gc
 qSusjP7y6cGdCuYvrWtZdESoupaP0ePdevx4uV/Ky85La8CxbgjN6PQ2S8NRN8gX3bSbOFG0O
 vh5YlZmCE4TDE7XQE5HEKivBEstxqvLVrXzvhx0RTm7C8s2kbWJRrAVT5eXSiIZ7x/jsQmr3a
 n0R9pTBIDVKxDk7u3PGgxYDZDlLofvBUtI47WMJ0KSTKKcTK75ectW2IFU6Am3iael4Vg1bSE
 7ygJvc30IGe7dhgZWClX0C48r7csLSCmV6MYeLEnJCxj4vIS1gVowyNFmIJbwS08a26qZ8RCj
 3Y3ihfBnV+Qb7el+OSifIhzcQsYeFyWrWYftoqpJ/MdMm2Gr5wuLrKl9blEOp1fUYyVE+ADYh
 4vaVeqe7Rmy05rwVlqSjpA5utxV50Zb4LuJoWS028aZ8OwwmkpGCN9LJFgnPuHFsvV5iAqv5O
 uhjI2B62s+t1j87DRLZlAOd6Qv+1mcnVCb2stNT996tjRuolucieTPZ3P8uF9LxV6WBzXCskN
 cCizM2YE7ftN6bOL4keGQzEKavvdd5lBKedB6iBYmRnTwThB7498qgC+md3HwLZtUFSjT8g9d
 8BPl+88xqCkzGjoZ4sAl/AuJB57cgrUVkCapNr5xYRGiBvBsNfnK/3XLtc+f/3+peKVdgCzl2
 ycZfkpsjDH7FzsbL2tUBz5bdF2QV+Rye9aZJls43V9u/FxtKu/mC+FKMMYHF8ixyALgia95po
 6TKXZlTJArUYFUEn4mFhpSnJkhdwYsSQh+EZW5HpdiQu7+LzvKJ/qW2pe9IPGHjTNSqqLWB
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
 Taylor Simson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
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
Reviewed-by: Taylor Simson <tsimpson@quicinc.com>
Tested-by: Taylor Simpson <tsimpson@quicinc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200212125658.644558-5-laurent@vivier.eu>
---
 linux-user/signal.c     | 50 ++++++++++++++++++++++++++++++++++++-----
 linux-user/trace-events |  3 +++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index c1e664f97a7c..046159dd0c5b 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -498,18 +498,30 @@ static int core_dump_signal(int sig)
 
 static void signal_table_init(void)
 {
-    int host_sig, target_sig;
+    int host_sig, target_sig, count;
 
     /*
-     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
-     * host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
+     * Signals are supported starting from TARGET_SIGRTMIN and going up
+     * until we run out of host realtime signals.
+     * glibc at least uses only the lower 2 rt signals and probably
+     * nobody's using the upper ones.
+     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
      * To fix this properly we need to do manual signal delivery multiplexed
      * over a single host signal.
+     * Attempts for configure "missing" signals via sigaction will be
+     * silently ignored.
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
@@ -519,6 +531,15 @@ static void signal_table_init(void)
             target_to_host_signal_table[target_sig] = host_sig;
         }
     }
+
+    if (trace_event_get_state_backends(TRACE_SIGNAL_TABLE_INIT)) {
+        for (target_sig = 1, count = 0; target_sig <= TARGET_NSIG; target_sig++) {
+            if (target_to_host_signal_table[target_sig] == _NSIG) {
+                count++;
+            }
+        }
+        trace_signal_table_init(count);
+    }
 }
 
 void signal_init(void)
@@ -817,6 +838,8 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     int host_sig;
     int ret = 0;
 
+    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);
+
     if (sig < 1 || sig > TARGET_NSIG || sig == TARGET_SIGKILL || sig == TARGET_SIGSTOP) {
         return -TARGET_EINVAL;
     }
@@ -847,6 +870,23 @@ int do_sigaction(int sig, const struct target_sigaction *act,
 
         /* we update the host linux signal state */
         host_sig = target_to_host_signal(sig);
+        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
+        if (host_sig > SIGRTMAX) {
+            /* we don't have enough host signals to map all target signals */
+            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d, ignored\n",
+                          sig);
+            /*
+             * we don't return an error here because some programs try to
+             * register an handler for all possible rt signals even if they
+             * don't need it.
+             * An error here can abort them whereas there can be no problem
+             * to not have the signal available later.
+             * This is the case for golang,
+             *   See https://github.com/golang/go/issues/33746
+             * So we silently ignore the error.
+             */
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


