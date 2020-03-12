Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E715C5ACBF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66547206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 10:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgpLSYwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66547206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCLIJ-0001cK-HD
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 06:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jCLHl-0001DY-AM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jCLHj-0007Y0-S7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:41:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jCLHj-0007Xl-Kp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 06:41:51 -0400
Received: by mail-wm1-x343.google.com with SMTP id n8so5511933wmc.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LLFZrAobltgmvU6vJlk0C1lJO1F1EEmqYIwXBsGSKfs=;
 b=bgpLSYwU1oaYIXTZNNsLCl6uhLkgTrLY0+0239Nqp1qWHQlB7xiuZOrjBBGVz+atUo
 6Dovzo6TkKkiD/OBS8Co1DH6MOYvmOJxb3Klj7OsK3+Ed6dIzc0aB0K68+BjTvZJaZqO
 d3cFvhOZF0O2CR8R+ftngf1pYU1LQGPZyd+2abq3mmAGv9jC4GRJA6uEKVLFBWB54T4N
 f/kDtSy7z1H6jQHUqLpZFnI8n/YzDF2W45CDL3j91px90iind4wSipANg1lXEpjX7oad
 dnb5aZA0Q856eKTbmPLl61LZHydKNz0zgnGMKWoG/yXeJSY2xoUDKwI6rKE1d4F03t+4
 HQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LLFZrAobltgmvU6vJlk0C1lJO1F1EEmqYIwXBsGSKfs=;
 b=mgy3NaxrXgqZ5l5vtoQCQSxzo7mTv0BnSq9IX6kQgy8iAPGab9HO0VVgWXK/bgNX42
 bdrywclXE81QE6anWSK+FoqojSkSUkvcLEFQgU+sCvep5/isVBDZJS3RnZMytyoesS+a
 n3st8X8djX2gBsGkV4dwEKEPu+G6eKCygr6iqyPBlyttQoGLIYUu27G7fLCmUetZgWtw
 tuTIiy24tjWdFegpZZqV3W6OKPbaEss2LmNKjprBTIBOmiT30aglTzPfsCycz+1m9Xm7
 DoWRmJywcwPYlwptHtAMpX+0B9ftYCb4O5Uk5ENrpKBLfC9uBe+AwESlYOd17nk4zgY0
 MNjg==
X-Gm-Message-State: ANhLgQ3YEdIFXpyl6ROFh+bEwscZl7x+HrU5i18bqINmRNu/uuFnAZbi
 6RbW0U4PyVPvxojqMlaoMBLiMQ==
X-Google-Smtp-Source: ADFU+vuDyISQ7PavORnR+PNxv0MtvejMBrNGQXZLzb3tldhjIaxSW21kwpbY5mRPSYlEIaBHxUnH2g==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr4143395wml.97.1584009710297; 
 Thu, 12 Mar 2020 03:41:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f207sm13047158wme.9.2020.03.12.03.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 03:41:49 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7CDBB1FF7E;
 Thu, 12 Mar 2020 10:41:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tools/virtiofsd: add support for --socket-group
Date: Thu, 12 Mar 2020 10:41:42 +0000
Message-Id: <20200312104142.21259-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you like running QEMU as a normal user (very common for TCG runs)
but you have to run virtiofsd as a root user you run into connection
problems. Adding support for an optional --socket-group allows the
users to keep using the command line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v1
  - tweak documentation and commentary
---
 docs/tools/virtiofsd.rst        |  4 ++++
 tools/virtiofsd/fuse_i.h        |  1 +
 tools/virtiofsd/fuse_lowlevel.c |  6 ++++++
 tools/virtiofsd/fuse_virtio.c   | 20 ++++++++++++++++++--
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
index 378594c422a..5a8246b74f8 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -85,6 +85,10 @@ Options
 
   Listen on vhost-user UNIX domain socket at PATH.
 
+.. option:: --socket-group=GROUP
+
+  Set the vhost-user UNIX domain socket gid to GROUP.
+
 .. option:: --fd=FDNUM
 
   Accept connections from vhost-user UNIX domain socket file descriptor FDNUM.
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1240828208a..492e002181e 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -68,6 +68,7 @@ struct fuse_session {
     size_t bufsize;
     int error;
     char *vu_socket_path;
+    char *vu_socket_group;
     int   vu_listen_fd;
     int   vu_socketfd;
     struct fv_VuDev *virtio_dev;
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
index 2dd36ec03b6..4d1ba2925d1 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -2523,6 +2523,7 @@ static const struct fuse_opt fuse_ll_opts[] = {
     LL_OPTION("--debug", debug, 1),
     LL_OPTION("allow_root", deny_others, 1),
     LL_OPTION("--socket-path=%s", vu_socket_path, 0),
+    LL_OPTION("--socket-group=%s", vu_socket_group, 0),
     LL_OPTION("--fd=%d", vu_listen_fd, 0),
     LL_OPTION("--thread-pool-size=%d", thread_pool_size, 0),
     FUSE_OPT_END
@@ -2630,6 +2631,11 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
                  "fuse: --socket-path and --fd cannot be given together\n");
         goto out4;
     }
+    if (se->vu_socket_group && !se->vu_socket_path) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: --socket-group can only be used with --socket-path\n");
+        goto out4;
+    }
 
     se->bufsize = FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEADER_SIZE;
 
diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3b6d16a0417..331f9fc65c5 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -31,6 +31,8 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
+#include <sys/types.h>
+#include <grp.h>
 #include <unistd.h>
 
 #include "contrib/libvhost-user/libvhost-user.h"
@@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_session *se)
 
     /*
      * Unfortunately bind doesn't let you set the mask on the socket,
-     * so set umask to 077 and restore it later.
+     * so set umask appropriately and restore it later.
      */
-    old_umask = umask(0077);
+    if (se->vu_socket_group) {
+        old_umask = umask(S_IROTH | S_IWOTH | S_IXOTH);
+    } else {
+        old_umask = umask(S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IWOTH | S_IXOTH);
+    }
     if (bind(listen_sock, (struct sockaddr *)&un, addr_len) == -1) {
         fuse_log(FUSE_LOG_ERR, "vhost socket bind: %m\n");
         close(listen_sock);
         umask(old_umask);
         return -1;
     }
+    if (se->vu_socket_group) {
+        struct group *g = getgrnam(se->vu_socket_group);
+        if (g) {
+            if (!chown(se->vu_socket_path, -1, g->gr_gid)) {
+                fuse_log(FUSE_LOG_WARNING,
+                         "vhost socket failed to set group to %s (%d)\n",
+                         se->vu_socket_group, g->gr_gid);
+            }
+        }
+    }
     umask(old_umask);
 
     if (listen(listen_sock, 1) == -1) {
-- 
2.20.1


