Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF56C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34A4C2082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A4C2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jNy-0006J2-Au
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j83-0004pm-66
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j81-0002Fn-J1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j81-0002Ey-9k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0Fl9-1iImgj2G6p-00xJsI; Tue, 10 Sep 2019 18:36:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:54 +0200
Message-Id: <20190910163600.19971-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NtEeMdw9DuKI+X6WX5LXmEzAjadMcGIYgavPfh5I8NJkOzZ8DvY
 ghSplZ4Xqz8LuNSAV9kPIKczV4HX7C7iMnjcRQXIRFJEzlVFgsJAC/KrTfjZbaScSYwB7r2
 bggjIDuxFf+L1C/XAGfm56k/NduJuhkFofV9fQa9wYuXkAlxs4SMbp/CbXylxmeWY27Ci0D
 h08X4LVGsMHKLYCJgmn1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jCQJErf8zCs=:2kHPx3A5SREMdlTJDn1RJK
 kDc6ie/WKfcQ+E1UYDL6QvU6im7305NnYLk0V+/KklxT10fCcffZqbry5zGWIsG8XFIycli24
 uKnsr1ksPDCNRrAFfPt6beyeLcp2codxyTbU1KiZbAn8moXDoFIDgdYK9B2HlvmdQtRErV1u9
 wi3F+etByMnBDvd6b85p/v1NauMlK9kBqEMCemeU2F3cV80CwLFhHmosylOgVHLmm3hrqJ3It
 iilhuP0MxvP8W0NyFSvJ1kOUaaB5TzOa0I2Il6q8KPSBUdWuXwMkD6mjmaLV4E4QTQLmlpKYi
 r1m0aiJcRMsxONFcvJD5xp8lLEDS+wTjUukSaz93WOqApH4Sh2AhBR/ez5wnaYZZSqh0jihoS
 hSg2H4nvnlLcqeHKSISJcVipgk9XDhYtt7Fs4FWev3uo6QNjyUSFkmJHUfrf1rvHLByn7kbmW
 6Iif38y4Vi0obq9Zpt/xvwDx0p8zfJG35ImuDr+aKVIcgWrNe1c/SK66DIq75M237bWIi/OUy
 bdeOBdMstJ3OYuI95B78TRs7rMrR722E2vbaYX+wx/uqCL74EXmmUbB4tkc3dnsVe2WaaSsWH
 UOHtXRiEPkF7uNNt6lg2jF5VmvEz1+4OWEBePZY771+as9FoB+ItMZCWStBrfrcEKWJjFH0oY
 niKUblJbAhHOUYQbHVlEfpgPDL+2lV1Z31PfpOHJkrO0mbFlRB7k6Dpa2lVp3dLrgCPEWwo6G
 OHJrHaL75WomGrqB4AqAiGh3DGcqVrcI1gNWXSz22U/JvyF8ITwNYxTIsxFZqgtyLDmCtV+3e
 NgaxLhHO6wT9JGsCh0m/vA1a80vQqu+rOpRga/9SRTWcfzDIWI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 09/15] target/xtensa: linux-user: add call0 ABI
 support
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

Xtensa binaries built for call0 ABI don't rotate register window on
function calls and returns. Invocation of signal handlers from the
kernel is therefore different in windowed and call0 ABIs.
There's currently no way to determine xtensa ELF binary ABI from the
binary itself. Add handler for the -xtensa-abi-call0 command line
parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset.
Check PS.WOE in setup_rt_frame to determine how a signal should be
delivered.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Message-Id: <20190906165713.5558-1-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c          | 11 +++++++++++
 linux-user/xtensa/signal.c | 25 +++++++++++++++++--------
 target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
 target/xtensa/cpu.h        |  3 +++
 4 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 24cb24f0bf8f..27d9a87bc83d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -391,6 +391,13 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+#if defined(TARGET_XTENSA)
+static void handle_arg_abi_call0(const char *arg)
+{
+    xtensa_set_abi_call0();
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -444,6 +451,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
+#if defined(TARGET_XTENSA)
+    {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
+     "",           "assume CALL0 Xtensa ABI"},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 8d54ef3ae34b..590f0313ffe9 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -134,6 +134,8 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
     uint32_t ra;
+    bool abi_call0;
+    unsigned base;
     int i;
 
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
@@ -182,20 +184,27 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
         __put_user(0x00, &frame->retcode[5]);
 #endif
     }
-    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
-    if (xtensa_option_enabled(env->config, XTENSA_OPTION_WINDOWED_REGISTER)) {
-        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
-    }
     memset(env->regs, 0, sizeof(env->regs));
     env->pc = ka->_sa_handler;
     env->regs[1] = frame_addr;
     env->sregs[WINDOW_BASE] = 0;
     env->sregs[WINDOW_START] = 1;
 
-    env->regs[4] = (ra & 0x3fffffff) | 0x40000000;
-    env->regs[6] = sig;
-    env->regs[7] = frame_addr + offsetof(struct target_rt_sigframe, info);
-    env->regs[8] = frame_addr + offsetof(struct target_rt_sigframe, uc);
+    abi_call0 = (env->sregs[PS] & PS_WOE) == 0;
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+
+    if (abi_call0) {
+        base = 0;
+        env->regs[base] = ra;
+    } else {
+        env->sregs[PS] |= PS_WOE | (1 << PS_CALLINC_SHIFT);
+        base = 4;
+        env->regs[base] = (ra & 0x3fffffff) | 0x40000000;
+    }
+    env->regs[base + 2] = sig;
+    env->regs[base + 3] = frame_addr + offsetof(struct target_rt_sigframe,
+                                                info);
+    env->regs[base + 4] = frame_addr + offsetof(struct target_rt_sigframe, uc);
     unlock_user_struct(frame, frame_addr, 1);
     return;
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 76db1741a796..c65dcf9dd782 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -53,6 +53,20 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #endif
 }
 
+#ifdef CONFIG_USER_ONLY
+static bool abi_call0;
+
+void xtensa_set_abi_call0(void)
+{
+    abi_call0 = true;
+}
+
+bool xtensa_abi_call0(void)
+{
+    return abi_call0;
+}
+#endif
+
 /* CPUClass::reset() */
 static void xtensa_cpu_reset(CPUState *s)
 {
@@ -70,10 +84,12 @@ static void xtensa_cpu_reset(CPUState *s)
             XTENSA_OPTION_INTERRUPT) ? 0x1f : 0x10;
     env->pending_irq_level = 0;
 #else
-    env->sregs[PS] =
-        (xtensa_option_enabled(env->config,
-                               XTENSA_OPTION_WINDOWED_REGISTER) ? PS_WOE : 0) |
-        PS_UM | (3 << PS_RING_SHIFT);
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+    if (xtensa_option_enabled(env->config,
+                              XTENSA_OPTION_WINDOWED_REGISTER) &&
+        !xtensa_abi_call0()) {
+        env->sregs[PS] |= PS_WOE;
+    }
 #endif
     env->sregs[VECBASE] = env->config->vecbase;
     env->sregs[IBREAKENABLE] = 0;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0459243e6bb1..b363ffcf1066 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -673,6 +673,9 @@ static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
 {
     return env->system_er;
 }
+#else
+void xtensa_set_abi_call0(void);
+bool xtensa_abi_call0(void);
 #endif
 
 static inline uint32_t xtensa_replicate_windowstart(CPUXtensaState *env)
-- 
2.21.0


