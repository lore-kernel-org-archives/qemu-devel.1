Received: from eggs.gnu.org ([2001:4830:134:3::10]:33562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQG-000343-8o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQD-0006Dz-HY
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57392
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQD-0006DX-AG
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:05 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESwZp145790
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:29:03 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fc85k7bde-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:02 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:23 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-7-groug@kaod.org>
Subject: [Qemu-devel] [PULL 06/14] 9pfs: fix type in *_parse_opts
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

To comply with the QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p-handle.c | 2 +-
 hw/9pfs/9p-local.c  | 2 +-
 hw/9pfs/9p-proxy.c  | 2 +-
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
-- 
2.13.6
