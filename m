Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7BC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:52:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84712084D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNk13opX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84712084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaep2-0003Rj-1H
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 06:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iaeGM-00055D-Fn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iaeGL-0001qJ-B9
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iaeGL-0001fI-4A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:16:37 -0500
Received: by mail-wr1-x442.google.com with SMTP id i12so34774963wro.5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zc/Us2UPy+ZYepKw32wsK73pj3ubDAEJqzqFzz2dr38=;
 b=bNk13opXUy/BBcjT/3kW4/c2uSMyMpYNYQ9CmTIq/26Tdq/KbL2paSYFMeNgM7z18J
 bcf2HH9ZLrogKmCnjAgbDoLLKl8rhovJBAJfz3HUwyhnOHaH+hlVLKwQKf5iIZ1aNkMw
 N9uYAuqICBy2sQ7YHtfE8NNmrOpWMzr+EqfRUwGCHOQPKTSTM432V9rx3bBhYrZa3LJQ
 ongkRec8xhn9CwM5osdpdpQHTLyJ8McQEedNK23l77TBRZcagK0Rmou5lm4jemHnBEVB
 lzMWGlAwcihDvO4V1WSKoUFMhbTzhPsIrZ1zla6VvNEpcifzh154GM7zJUftfMICYNSW
 GHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Zc/Us2UPy+ZYepKw32wsK73pj3ubDAEJqzqFzz2dr38=;
 b=JTSTcvrNuhWfzNCxrzBdjYHJdhUqEwjn47rcnd5qI/8tXdQL7p3n1tiA/lUtF5nrX4
 xq20HVEuT38ShUP+y4mpsuYb/fePxtTG7C5o5VeXNGiwJO8b9GoWfWNlzqvi5VIbOHDx
 L42LSb5Qk2G7vi6yYLz3YSlYO3AKWuQdlq8HCS4jxNlLRMceGNqyOpjzHIoqa0g/jg1n
 ZLr/xS6B7K4mUYGmSofRInLnjYdhbgI1SU82fMbhJFPZmObbZzW5s+zunQXaB/qY8PiR
 sFDcR6f56Thm9LdDa1o232er6uNmJvouzEi4uBzQzsJHdxGfHljGWZafNH5X6H7Wflg8
 mssA==
X-Gm-Message-State: APjAAAVsUDJ5VIJ4I82a+O0NRLTogCG9YYdAQmfP5jHi955HOzUz7jp/
 GNF2bbOURxdUcl7O57pXXEZbBXOh
X-Google-Smtp-Source: APXvYqx9gmdh1GNHB3k9w0WuklPJFdW6PcCxvmNll2WPR8GqHA85ZTMxyrp7swB9gsQ5YFOisTb0RA==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr6004424wrr.215.1575026193667; 
 Fri, 29 Nov 2019 03:16:33 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id
 i71sm29752969wri.68.2019.11.29.03.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 03:16:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] build: rename CONFIG_LIBCAP to CONFIG_LIBCAP_NG
Date: Fri, 29 Nov 2019 12:16:31 +0100
Message-Id: <20191129111632.22840-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: berrange@redhat.com, dgilbert@redhat.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are using the newer capng library, rename the symbol to match.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             |  2 +-
 qemu-bridge-helper.c  |  6 +++---
 scsi/qemu-pr-helper.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 6099be1d84..afe9393f04 100755
--- a/configure
+++ b/configure
@@ -6759,7 +6759,7 @@ if test "$l2tpv3" = "yes" ; then
   echo "CONFIG_L2TPV3=y" >> $config_host_mak
 fi
 if test "$cap_ng" = "yes" ; then
-  echo "CONFIG_LIBCAP=y" >> $config_host_mak
+  echo "CONFIG_LIBCAP_NG=y" >> $config_host_mak
 fi
 echo "CONFIG_AUDIO_DRIVERS=$audio_drv_list" >> $config_host_mak
 for drv in $audio_drv_list; do
diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index 3d50ec094c..88b26747fc 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -43,7 +43,7 @@
 
 #include "net/tap-linux.h"
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 #include <cap-ng.h>
 #endif
 
@@ -207,7 +207,7 @@ static int send_fd(int c, int fd)
     return sendmsg(c, &msg, 0);
 }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int drop_privileges(void)
 {
     /* clear all capabilities */
@@ -246,7 +246,7 @@ int main(int argc, char **argv)
     int access_allowed, access_denied;
     int ret = EXIT_SUCCESS;
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
     /* if we're run from an suid binary, immediately drop privileges preserving
      * cap_net_admin */
     if (geteuid() == 0 && getuid() != geteuid()) {
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index debb18f4aa..0659ceef09 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -24,7 +24,7 @@
 #include <linux/dm-ioctl.h>
 #include <scsi/sg.h>
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 #include <cap-ng.h>
 #endif
 #include <pwd.h>
@@ -70,7 +70,7 @@ static int num_active_sockets = 1;
 static int noisy;
 static int verbose;
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int uid = -1;
 static int gid = -1;
 #endif
@@ -97,7 +97,7 @@ static void usage(const char *name)
 "                            (default '%s')\n"
 "  -T, --trace [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
 "                            specify tracing options\n"
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 "  -u, --user=USER           user to drop privileges to\n"
 "  -g, --group=GROUP         group to drop privileges to\n"
 #endif
@@ -827,7 +827,7 @@ static void close_server_socket(void)
     num_active_sockets--;
 }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
 static int drop_privileges(void)
 {
     /* clear all capabilities */
@@ -920,7 +920,7 @@ int main(int argc, char **argv)
             pidfile = g_strdup(optarg);
             pidfile_specified = true;
             break;
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
         case 'u': {
             unsigned long res;
             struct passwd *userinfo = getpwnam(optarg);
@@ -1056,7 +1056,7 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }
 
-#ifdef CONFIG_LIBCAP
+#ifdef CONFIG_LIBCAP_NG
     if (drop_privileges() < 0) {
         error_report("Failed to drop privileges: %s", strerror(errno));
         exit(EXIT_FAILURE);
-- 
2.21.0


