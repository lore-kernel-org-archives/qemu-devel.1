Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33D02067D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="PF/TjXQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33D02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joupn-0002TH-SV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msmarduch@digitalocean.com>)
 id 1jouoa-0001vZ-VF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:19:12 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msmarduch@digitalocean.com>)
 id 1jouoY-0006eE-K0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 16:19:12 -0400
Received: by mail-pl1-x641.google.com with SMTP id j4so4661013plk.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=pxbwWo5XWzO8IpihWkUfDIASJ7xv+l6dqrjnT/1bNec=;
 b=PF/TjXQqDITWcQMOB8Zk/BufXKd3AM0SwETAN04L5JNQ1ly1eGg+he6BTX4ePWycbV
 dbZHpgrE2vZFsYcx/MuO5Fd/G3cRvIrQcpAGlDaMT3INQOnzfgochgTKcjG9Ohy25Lde
 RAD3PMk1dLVgmMNT+EzT8ViHMtjVs1JkF7F1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pxbwWo5XWzO8IpihWkUfDIASJ7xv+l6dqrjnT/1bNec=;
 b=PAwIjSHwDj0qi83BJqqwiuWBf8ac/H9/XHeeMtq8/JnFmXWCO6cXJAucH6imXIXd2L
 7rkorhoH1DXJ0xMRrfhSmYnmZ9eyFCgjMdTbF01EdaadRsj1/cefdLSBAEZxMcjVOlVF
 oxxQ6kEwrmPqq51kuTs43lxuPUtoZW//ORy3zHphx4yMCGxP3978zbcSJhqAcsJ6Aemx
 VpHfiOxut04Pzo4p0EFEgwY/J21k16yNTrdsch/tgbTWwgvmIMkbu5ik5Vg0xvQc9WdU
 PTWS1d8xLOzM4mHd6KVIvnQOdSRMUl6IZ1r5NjUwkZhsCHVxqLGuZC8LZccUzFSeUHq+
 /Dug==
X-Gm-Message-State: AOAM532R4iQw8zw4sCqy7dHluClksTvKc+pRYyGtgZUt9OWgd3GCrHSS
 aL3V8Dw2Yor5wS3uYwnPtkEpiw==
X-Google-Smtp-Source: ABdhPJxQzU4l/b9o4ZObmBEuCmcq7CB4ldKAHIeV1OST2bfcfazuFDHZhInG3DzdXImWQN/4xoprPw==
X-Received: by 2002:a17:90a:4f4b:: with SMTP id
 w11mr5359085pjl.11.1593202747757; 
 Fri, 26 Jun 2020 13:19:07 -0700 (PDT)
Received: from msmarduch-ThinkPad-T460s
 ([2600:1700:4a30:84c0:9494:e58a:f7ca:ac1])
 by smtp.gmail.com with ESMTPSA id x8sm12920086pje.31.2020.06.26.13.19.07
 (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
 Fri, 26 Jun 2020 13:19:07 -0700 (PDT)
From: Mario Smarduch <msmarduch@digitalocean.com>
To: qemu-devel@nongnu.org,
	armbru@redhat.com,
	pbonzini@redhat.com
Cc: peter.maydell@linaro.org,
	msmarduch@digitalocean.com
Subject: [PATCH] util/qemu-error: prepend guest name to error message to
 identify affected VM owner
Date: Fri, 26 Jun 2020 13:19:00 -0700
Message-Id: <20200626201900.8876-1-msmarduch@digitalocean.com>
X-Mailer: git-send-email 2.9.3
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=msmarduch@digitalocean.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is followup patch to the one submitted back in Oct, 19

https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg02102.html

My mistake here, I took my eyes of the mailing list after I got the
initial thumbs up. This patch follows up on Markus comments in the
above link.

Purpose of this patch:

We want to print guest name for errors, warnings and info messages. This 
was the first of two patches the second being MCE errors targeting a VM 
with guest name prepended. But in a large fleet we see many other
errors that disable a VM or crash it. In a large fleet and centralized
logging having the guest name enables identify of owner and customer.

Signed-off-by: Mario Smarduch <msmarduch@digitalocean.com>
---
Test verification summary:

a) qemu-system-x86_64 -msg help
  guest-name=<bool (on/off)> - Prepends guest name for error messages but only if -name <guestname> is set otherwise option is ignored

  timestamp=<bool (on/off)>

b) qemu-system-x86_64 -help
-msg [timestamp[=on|off]][,guest-name=[on|off]]
                control error message format
                timestamp=on enables timestamps (default: off)
                guest-name=on enables guest name prefix but only if
                              -name guest option is set (default: off)

c) man qemu
       -msg [timestamp[=on|off]][,guest-name[=on|off]]
              Control error message format.

              timestamp=on|off
                     Prefix messages with a timestamp. Default is off.

              guest-name=on|off
                     Prefix  messages  with guest name but only if -name guest
                     option is set otherwise the option is ignored. Default is
                     off.
d) command options
./x86_64-softmmu/qemu-system-x86_64 -msg timestamp
2020-06-26T01:01:23.140294Z qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp,guest-name
2020-06-26T01:02:30.301431Z qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp,guest-name \
                                    -name guest=DROPLET-123
2020-06-26T01:04:37.720380Z DROPLET-1234 qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=off,guest-name=off \
                                    -name guest=DROPLET-123
qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=on,guest-name=off \
                                    -name guest=DROPLET-123
2020-06-26T01:06:33.888859Z qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=off,guest-name=on \
                                    -name guest=DROPLET-123
DROPLET-1234 qemu-system-x86_64: Testing ERROR...

./x86_64-softmmu/qemu-system-x86_64 -msg timestamp=on,guest-name=on \
                                    -name guest=DROPLET-123
2020-06-26T01:09:31.116283Z DROPLET-1234 qemu-system-x86_64: Testing ERROR... 


 include/qemu/error-report.h |  2 ++
 qemu-options.hx             | 12 +++++++++---
 softmmu/vl.c                |  9 +++++++++
 util/qemu-error.c           |  7 +++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 87532d8596..a5ad95ff1b 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -75,5 +75,7 @@ void error_init(const char *argv0);
 const char *error_get_progname(void);
 
 extern bool error_with_timestamp;
+extern bool error_with_guestname;
+extern const char *error_guest_name;
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 93bde2bbc8..ff75510b7c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4290,16 +4290,22 @@ HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
-    "-msg timestamp[=on|off]\n"
+    "-msg [timestamp[=on|off]][,guest-name=[on|off]]\n"
     "                control error message format\n"
-    "                timestamp=on enables timestamps (default: off)\n",
+    "                timestamp=on enables timestamps (default: off)\n"
+    "                guest-name=on enables guest name prefix but only if\n"
+    "                              -name guest option is set (default: off)\n",
     QEMU_ARCH_ALL)
 SRST
-``-msg timestamp[=on|off]``
+``-msg [timestamp[=on|off]][,guest-name[=on|off]]``
     Control error message format.
 
     ``timestamp=on|off``
         Prefix messages with a timestamp. Default is off.
+
+    ``guest-name=on|off``
+        Prefix messages with guest name but only if -name guest option is set
+        otherwise the option is ignored. Default is off.
 ERST
 
 DEF("dump-vmstate", HAS_ARG, QEMU_OPTION_dump_vmstate,
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06ede..3f7aad89c3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -389,6 +389,12 @@ static QemuOptsList qemu_msg_opts = {
             .name = "timestamp",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "guest-name",
+            .type = QEMU_OPT_BOOL,
+            .help = "Prepends guest name for error messages but only if "
+                    "-name guest is set otherwise option is ignored\n",
+        },
         { /* end of list */ }
     },
 };
@@ -1109,6 +1115,7 @@ static void realtime_init(void)
 static void configure_msg(QemuOpts *opts)
 {
     error_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
+    error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
 }
 
 
@@ -3578,6 +3585,8 @@ void qemu_init(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
+                /* Capture guest name if -msg guest-name is used later */
+                error_guest_name = qemu_opt_get(opts, "guest");
                 break;
             case QEMU_OPTION_prom_env:
                 if (nb_prom_envs >= MAX_PROM_ENVS) {
diff --git a/util/qemu-error.c b/util/qemu-error.c
index dac7c7dc50..017288b6c9 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -26,6 +26,8 @@ typedef enum {
 
 /* Prepend timestamp to messages */
 bool error_with_timestamp;
+bool error_with_guestname;
+const char *error_guest_name;
 
 int error_printf(const char *fmt, ...)
 {
@@ -213,6 +215,11 @@ static void vreport(report_type type, const char *fmt, va_list ap)
         g_free(timestr);
     }
 
+    /* Only prepend guest name if -msg guest-name and -name guest=... are set */
+    if (error_with_guestname && error_guest_name && !cur_mon) {
+        error_printf("%s ", error_guest_name);
+    }
+
     print_loc();
 
     switch (type) {
-- 
2.17.1


