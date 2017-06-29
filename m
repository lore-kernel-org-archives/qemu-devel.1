Received: from eggs.gnu.org ([2001:4830:134:3::10]:54939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZjy-00037p-QY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZjt-0002rG-Uq
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34709
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZjt-0002r2-Mm
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDcu0S008721
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bcsuw5p5s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:05 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:44 +0200
In-Reply-To: <1498743831-28676-1-git-send-email-groug@kaod.org>
References: <1498743831-28676-1-git-send-email-groug@kaod.org>
Message-Id: <1498743831-28676-2-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/8] 9pfs: local: remove: use correct path
 component
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Bruce Rogers <brogers@suse.com>

From: Bruce Rogers <brogers@suse.com>

Commit a0e640a8 introduced a path processing error.
Pass fstatat the dirpath based path component instead
of the entire path.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1e78b7c9e961..83952eff0a11 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1100,7 +1100,7 @@ static int local_remove(FsContext *ctx, const char *path)
         goto out;
     }
 
-    if (fstatat(dirfd, path, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
+    if (fstatat(dirfd, name, &stbuf, AT_SYMLINK_NOFOLLOW) < 0) {
         goto err_out;
     }
 
-- 
2.7.5
