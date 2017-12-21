Received: from eggs.gnu.org ([2001:4830:134:3::10]:59067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eS31f-0003WA-N1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eS31a-0004nO-MN
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:44:51 -0500
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:41660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eS31a-0004jC-FO
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 10:44:46 -0500
Received: from player795.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 7357FAF557
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 16:43:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 21 Dec 2017 16:43:45 +0100
Message-ID: <151387102500.6441.11333264832773390059.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9pfs: fix type in *_parse_opts declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

To comply with the QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-handle.c |    2 +-
 hw/9pfs/9p-local.c  |    2 +-
 hw/9pfs/9p-proxy.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index 65b12de230c1..26ac90fc5ce3 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -652,7 +652,7 @@ static void handle_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int handle_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
+static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index e51af87309c6..155834db28e1 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1459,7 +1459,7 @@ static void local_cleanup(FsContext *ctx)
     g_free(data);
 }
 
-static int local_parse_opts(QemuOpts *opts, struct FsDriverEntry *fse)
+static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse)
 {
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 28b20a7c3dfa..652940726e72 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -1111,7 +1111,7 @@ static int connect_namedsocket(const char *path)
     return sockfd;
 }
 
-static int proxy_parse_opts(QemuOpts *opts, struct FsDriverEntry *fs)
+static int proxy_parse_opts(QemuOpts *opts, FsDriverEntry *fs)
 {
     const char *socket = qemu_opt_get(opts, "socket");
     const char *sock_fd = qemu_opt_get(opts, "sock_fd");
