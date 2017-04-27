Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzm-0004ZG-2t
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d3fzi-0000wO-6W
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:54 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:36500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d3fzh-0000uv-VL
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:45:50 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 084D8E8258
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 11:45:46 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 27 Apr 2017 11:45:42 +0200
Message-ID: <149328634220.30266.1628882080436632549.stgit@bahia>
In-Reply-To: <149328633283.30266.4224847428546759127.stgit@bahia>
References: <149328633283.30266.4224847428546759127.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/4] fsdev: don't allow unknown format in
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>

The code only uses well known format strings. An unknown format token is a
bug.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/9p-iov-marshal.c |    4 ++--
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
