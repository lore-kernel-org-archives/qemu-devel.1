Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADE52075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFsHI2Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADE52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnE5-0000gR-2L
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCd-0007Nh-I9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCa-0001NU-MH
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:51:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so2946719wmj.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eP8IRx33KYKqoe6PrhN3NXzNGwmBRsBzrSybQmnNqbM=;
 b=DFsHI2WrX2bvmPvaYzx4q3vrYDT3aD10kqia+n0n0cLkhAIQvGH7BcatBmpMUgdH5Z
 tHtEcmi5oA67VPWMPu+54In/VSaVz3SExTkDelbfjLCOL4rkSQdwVk7sMi4aTToGZCWn
 YJqrYzAJpGoLzHrmExztamoCKN8ljmDo4w4secV3sIhM7L9BTvQi+qm9lWxgFdUfWTdk
 gThM7iCy2G4HkIC6i+xJsT1NPFpiS/w6kdTjUM5Bh+gVEK4SDZVZtP9gfpZOMDL8JxQl
 1AlTzKKoQJaJIZvWTfe/QS4t3+d15isKpHamSbCggX+cCvCh9nx3803zr+eyrSa/f+/H
 wphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eP8IRx33KYKqoe6PrhN3NXzNGwmBRsBzrSybQmnNqbM=;
 b=OAx8MklhcIF/owXvDIEaWhNZabuWXPlOWAI09Iz1w9rA3wG1fOa3uIhxnUJSimURI6
 Mz5AXlQ7zKcA0K1wW7DG70wGbgCiibzArEOFj72xrSKwL9fJTdybd1KjHPNFwqvcPzFz
 xU5O8LVSohwA+NLoRjKZ/WbXjsFYE29eRAiLU+S3xTLPWYpCimjrSD5fKQI0cXJcxij6
 SYDBAngL6j21MUpPD+JntuOh5jwIYQ7qD1soFx1eCME941kkVYGyW93msqAZ6iEQdVgM
 kW7IHly3y2Xxu2fjInSFJb3lKGx+uKQBYt9UV1+/iBcbcQBxGZs0kxbOPilrjKEG4w0q
 Zh7w==
X-Gm-Message-State: AOAM5307eh3c5xLaSaIjqJnwMIriHwOjjrkDvUEEXQKWIFv2YE0RqZgF
 XUc9UJ2RCgSen/AclhWvOSYKCw==
X-Google-Smtp-Source: ABdhPJzqvbmnlt8MESPNUh64kjEJicRNegOyt85mThr8I355eHjzgmjl6Y8OMw0PQM5x3EQSbbn+HQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr2952305wmh.53.1601038311085;
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm2766046wme.12.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DD701FF87;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  01/19] tools/virtiofsd: add support for --socket-group
Date: Fri, 25 Sep 2020 13:51:29 +0100
Message-Id: <20200925125147.26943-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 takahiro.akashi@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you like running QEMU as a normal user (very common for TCG runs)
but you have to run virtiofsd as a root user you run into connection
problems. Adding support for an optional --socket-group allows the
users to keep using the command line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

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
index e33c81ed41f1..085f9b12a6a3 100644
--- a/docs/tools/virtiofsd.rst
+++ b/docs/tools/virtiofsd.rst
@@ -87,6 +87,10 @@ Options
 
   Listen on vhost-user UNIX domain socket at PATH.
 
+.. option:: --socket-group=GROUP
+
+  Set the vhost-user UNIX domain socket gid to GROUP.
+
 .. option:: --fd=FDNUM
 
   Accept connections from vhost-user UNIX domain socket file descriptor FDNUM.
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index 1240828208ab..492e002181e2 100644
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
index 2dd36ec03b6e..4d1ba2925d1b 100644
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
index 9e5537506c16..7942d3d11a87 100644
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


