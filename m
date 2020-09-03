Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E64C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9E4206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6HgUhoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9E4206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwc8-00049s-DZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL3-0003X5-2s; Thu, 03 Sep 2020 17:00:09 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:45784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwL1-0007Pl-1Y; Thu, 03 Sep 2020 17:00:08 -0400
Received: by mail-oi1-x235.google.com with SMTP id d189so4477963oig.12;
 Thu, 03 Sep 2020 14:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OIsdyV2PRysNfY7ypO8eiajhFecOTZcFODPU4qiwxp8=;
 b=H6HgUhoHtv7MNe8tt7gWCEWnsJ1mX23d3zM819/uHRaWj0MguMhnTp+FzcwsiZAb6I
 3i4F0yjUdkPcsLgb+ahksZd1o2U2OOWVCnpFvOdzsfjhGbhnFv8oe+cs/D3RVD7oM79B
 NLuAzBVU7nXj9yZQ0QPtCUjaAW7PtQM03+CJd1zoFXd/hTRaZ4a7UDyqA+GiI3t3b7C6
 JCHXf6AqKsNR9QWIIc4R6xYtJovbHFFC0hhxysFDgGLOP65YGtYes4tE/WcQByN9sOxA
 auvI4gBkqvxGyActzKeIYh0itCvz3yJDiJn2EQWs5w+odLHyweRL7W2G4UHWOhxm3XYi
 uTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=OIsdyV2PRysNfY7ypO8eiajhFecOTZcFODPU4qiwxp8=;
 b=qFdt8Fmrl2tYpB4m2oCA0VHbu4KKEwJ3WSBP0AFR6M6T3mr6/jIeJTHYbWmZ4f6Vzv
 PxiqFPBy0qPrQLk6704uc3I+71fNLPLUQyQzSrjc6NF9npwyQtEHJGn1pWetG6eQwbgk
 etPJziTqELeTvj9vJtVTpGpt1TZqZdfPyCyoNpPzHyS3IllFKlKZNbzVUm1TtlKWlM3a
 cTig2d50qF4gPYym4Q2qcxVdA3nmYm/3yPLoJxZ48unN+Z4JhIKunGWYXCv7O/lrAcGC
 tIKqBBv2RSDiGMMdggHdxmsGgqtbgFfSI3vf0tOr4MeoEZrYzF03azNlxrToVlyahhx+
 hL6w==
X-Gm-Message-State: AOAM531xGgJIANXfzeHvkCgteR52JbFWvPvwyh3n4kFXLIpsGO428hQU
 EkV6O6e1d5EkML0UdIacsk7yTLY30CI=
X-Google-Smtp-Source: ABdhPJzs7wuKr4APG+r+H6rf/qU3oa+gQO+n5Pc1FoKe7AieBIacr4qorEJZx0imRNUMkvHMjqZ9zA==
X-Received: by 2002:aca:bc57:: with SMTP id m84mr3224265oif.14.1599166805140; 
 Thu, 03 Sep 2020 14:00:05 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l136sm733495oig.7.2020.09.03.14.00.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:04 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/77] virtiofsd: add --rlimit-nofile=NUM option
Date: Thu,  3 Sep 2020 15:58:38 -0500
Message-Id: <20200903205935.27832-21-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Make it possible to specify the RLIMIT_NOFILE on the command-line.
Users running multiple virtiofsd processes should allocate a certain
number to each process so that the system-wide limit can never be
exhausted.

When this option is set to 0 the rlimit is left at its current value.
This is useful when a management tool wants to configure the rlimit
itself.

The default behavior remains unchanged: try to set the limit to
1,000,000 file descriptors if the current rlimit is lower.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200501140644.220940-2-stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
(cherry picked from commit 6dbb716877728ce4eb51619885ef6ef4ada9565f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tools/virtiofsd/fuse_lowlevel.h  |  1 +
 tools/virtiofsd/helper.c         | 23 +++++++++++++++++++++++
 tools/virtiofsd/passthrough_ll.c | 22 ++++++++--------------
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
index 8f6d705b5c..562fd5241e 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1777,6 +1777,7 @@ struct fuse_cmdline_opts {
     int syslog;
     int log_level;
     unsigned int max_idle_threads;
+    unsigned long rlimit_nofile;
 };
 
 /**
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 819c2bc13c..dc59f38af0 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -23,6 +23,8 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/param.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include <unistd.h>
 
 #define FUSE_HELPER_OPT(t, p)                       \
@@ -53,6 +55,7 @@ static const struct fuse_opt fuse_helper_opts[] = {
     FUSE_HELPER_OPT("subtype=", nodefault_subtype),
     FUSE_OPT_KEY("subtype=", FUSE_OPT_KEY_KEEP),
     FUSE_HELPER_OPT("max_idle_threads=%u", max_idle_threads),
+    FUSE_HELPER_OPT("--rlimit-nofile=%lu", rlimit_nofile),
     FUSE_HELPER_OPT("--syslog", syslog),
     FUSE_HELPER_OPT_VALUE("log_level=debug", log_level, FUSE_LOG_DEBUG),
     FUSE_HELPER_OPT_VALUE("log_level=info", log_level, FUSE_LOG_INFO),
@@ -171,6 +174,9 @@ void fuse_cmdline_help(void)
            "                               default: no_writeback\n"
            "    -o xattr|no_xattr          enable/disable xattr\n"
            "                               default: no_xattr\n"
+           "    --rlimit-nofile=<num>      set maximum number of file descriptors\n"
+           "                               (0 leaves rlimit unchanged)\n"
+           "                               default: 1,000,000 if the current rlimit is lower\n"
            );
 }
 
@@ -191,11 +197,28 @@ static int fuse_helper_opt_proc(void *data, const char *arg, int key,
     }
 }
 
+static unsigned long get_default_rlimit_nofile(void)
+{
+    rlim_t max_fds = 1000000; /* our default RLIMIT_NOFILE target */
+    struct rlimit rlim;
+
+    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
+        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
+        exit(1);
+    }
+
+    if (rlim.rlim_cur >= max_fds) {
+        return 0; /* we have more fds available than required! */
+    }
+    return max_fds;
+}
+
 int fuse_parse_cmdline(struct fuse_args *args, struct fuse_cmdline_opts *opts)
 {
     memset(opts, 0, sizeof(struct fuse_cmdline_opts));
 
     opts->max_idle_threads = 10;
+    opts->rlimit_nofile = get_default_rlimit_nofile();
     opts->foreground = 1;
 
     if (fuse_opt_parse(args, opts, fuse_helper_opts, fuse_helper_opt_proc) ==
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 4c35c95b25..f7b9c1d20c 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2707,24 +2707,18 @@ static void setup_sandbox(struct lo_data *lo, struct fuse_session *se,
     setup_seccomp(enable_syslog);
 }
 
-/* Raise the maximum number of open file descriptors */
-static void setup_nofile_rlimit(void)
+/* Set the maximum number of open file descriptors */
+static void setup_nofile_rlimit(unsigned long rlimit_nofile)
 {
-    const rlim_t max_fds = 1000000;
-    struct rlimit rlim;
-
-    if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
-        fuse_log(FUSE_LOG_ERR, "getrlimit(RLIMIT_NOFILE): %m\n");
-        exit(1);
-    }
+    struct rlimit rlim = {
+        .rlim_cur = rlimit_nofile,
+        .rlim_max = rlimit_nofile,
+    };
 
-    if (rlim.rlim_cur >= max_fds) {
+    if (rlimit_nofile == 0) {
         return; /* nothing to do */
     }
 
-    rlim.rlim_cur = max_fds;
-    rlim.rlim_max = max_fds;
-
     if (setrlimit(RLIMIT_NOFILE, &rlim) < 0) {
         /* Ignore SELinux denials */
         if (errno == EPERM) {
@@ -2977,7 +2971,7 @@ int main(int argc, char *argv[])
 
     fuse_daemonize(opts.foreground);
 
-    setup_nofile_rlimit();
+    setup_nofile_rlimit(opts.rlimit_nofile);
 
     /* Must be before sandbox since it wants /proc */
     setup_capng();
-- 
2.17.1


