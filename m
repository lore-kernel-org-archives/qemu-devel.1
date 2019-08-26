Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5BFC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:19:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C44720850
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plc1VHR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C44720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2JaL-0002Ob-Ju
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 14:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2JYh-0001uj-DD
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i2JYf-0008BP-1H
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:17:39 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i2JYe-0008AL-Pg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 14:17:36 -0400
Received: by mail-lf1-x142.google.com with SMTP id u29so138582lfk.7
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=wdJwEuUkcno83FruS61ZvZ6FYsame+08uboq+h6DH/M=;
 b=Plc1VHR/NdqjE4GLLvByUQTXouMTTlqc3DP2TAlExufczyGBJ+aSrTZkBjAamK91eD
 eL1eKqVJtB9+IEk6h8x8mkTqMLa05U6wg3PkgTGB+/4H17uN2psuOewnTb5D0+VZJAVu
 6v5OMynMqfULRcBQ4Laqs2teXKPG+RpyDhuB4QRkAXSsvBKHUHT2T2EHMZxs1EJX8FZe
 +5MERKRmE9dKXQDd+Z98PMFMBAeo4N9Vl8U8u7/DJTiYLPSw0rPJxqh7u7oXE0EgYPXb
 bPlOafqxIil/+qjcSHbkOpqq8G3ewahcfKgiTfshuAcqU4khVH7p/y8fMFjubqI+/4b2
 nVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=wdJwEuUkcno83FruS61ZvZ6FYsame+08uboq+h6DH/M=;
 b=SLa8s/yltQmsB4RsyEWB/hpNtaZ2Ok0nQrc90ZUChh94gKik/eOu4ViC8hi7b/Cid9
 etmPISVuyYHMtfuc0yyCq48cuVrJmy0AiUown5fJSjd8WffWar+CZZ0GN1X8twDIG5xn
 4B6MV1k5dHqZagXxGR3mVUrJVJLAMqGUCmQbOrxVz/3Q5x3XSJZCULkXhyPPEHtus80U
 csej6gzwDeG2GDd+VOTZxDl3OJJznal7wt9ClkB4dAHhIhNql7iXfhfC90mZi/UT5Wha
 +F0aEZnmxLM5GwNN6SXGjShUOqxLsBBtRHiXj+tO6Jn/JW+0qRgQ2x+3VkDPxWqAgeyt
 0Jxw==
X-Gm-Message-State: APjAAAWF9tohvWyHPBRc8Oftr7b4h7+EvG8X31tcE7vzAbXMpx5pJIJC
 lJHBM+Z7VNqcftMahw4MdO4rSlbw4es=
X-Google-Smtp-Source: APXvYqwRVlrVsjd9Cs/xkYtd6jdh0UtBpsUFRTTUanIypuyOhdurtQgNfjDj4kq0w92tUsGPPi2LjA==
X-Received: by 2002:a19:c6d5:: with SMTP id w204mr7150412lff.53.1566843454817; 
 Mon, 26 Aug 2019 11:17:34 -0700 (PDT)
Received: from octofox.cadence.com
 (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
 by smtp.gmail.com with ESMTPSA id c89sm2106825ljf.83.2019.08.26.11.17.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 11:17:34 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 11:17:23 -0700
Message-Id: <20190826181723.14008-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: [Qemu-devel] [PATCH v2] target/xtensa: linux-user: add call0 ABI
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xtensa binaries built for call0 ABI don't rotate register window on
function calls and returns. Invocation of signal handlers from the
kernel is therefore different in windowed and call0 ABIs.
There's currently no way to determine xtensa ELF binary ABI from the
binary itself. Add handler for the --xtensa-abi-call0 command line
parameter/QEMU_XTENSA_ABI_CALL0 envitonment variable to the qemu-user
and record ABI choice. Use it to initialize PS.WOE in xtensa_cpu_reset
and in setup_rt_frame to determine how a signal should be delivered.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- move handling of QEMU_XTENSA_ABI_CALL0 to linux-user/main.c
- check xtensa_abi_call0 instead of PS.WOE in the setup_rt_frame

 linux-user/main.c          | 17 +++++++++++++++++
 linux-user/xtensa/signal.c | 23 +++++++++++++++--------
 target/xtensa/cpu.c        | 24 ++++++++++++++++++++----
 target/xtensa/cpu.h        |  3 +++
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20fc..9e50b2d2a92f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -393,6 +393,13 @@ static void handle_arg_trace(const char *arg)
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
@@ -446,6 +453,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
+#if defined(TARGET_XTENSA)
+    {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
+     "",           "assume CALL0 Xtensa ABI"},
+#endif
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -710,6 +721,12 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+#if defined(TARGET_XTENSA)
+    if (getenv("QEMU_XTENSA_ABI_CALL0")) {
+        xtensa_set_abi_call0();
+    }
+#endif
+
     target_environ = envlist_to_environ(envlist, NULL);
     envlist_free(envlist);
 
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 8d54ef3ae34b..7753a37aa67a 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -134,6 +134,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     abi_ulong frame_addr;
     struct target_rt_sigframe *frame;
     uint32_t ra;
+    unsigned base;
     int i;
 
     frame_addr = get_sigframe(ka, env, sizeof(*frame));
@@ -182,20 +183,26 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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
+    env->sregs[PS] = PS_UM | (3 << PS_RING_SHIFT);
+
+    if (xtensa_abi_call0()) {
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
2.11.0


