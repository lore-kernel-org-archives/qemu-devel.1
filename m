Received: from eggs.gnu.org ([2001:4830:134:3::10]:40318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOb-0007Dl-DF
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOX-00020G-G9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55216
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOX-0001zx-Ah
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDcfOc051177
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2as73eyn5k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:06 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:31 +0200
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
Message-Id: <1496151640-29919-3-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 02/11] fsdev: don't allow unknown format in
 marshal/unmarshal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

The code only uses well known format strings. An unknown format token is a
bug.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 fsdev/9p-iov-marshal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
index 1d16f8df4bd4..a1c9beddd2e7 100644
--- a/fsdev/9p-iov-marshal.c
+++ b/fsdev/9p-iov-marshal.c
@@ -168,7 +168,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         default:
-            break;
+            g_assert_not_reached();
         }
         if (copied < 0) {
             return copied;
@@ -281,7 +281,7 @@ ssize_t v9fs_iov_vmarshal(struct iovec *in_sg, int in_num, size_t offset,
             break;
         }
         default:
-            break;
+            g_assert_not_reached();
         }
         if (copied < 0) {
             return copied;
-- 
2.7.5
