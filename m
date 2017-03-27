Received: from eggs.gnu.org ([2001:4830:134:3::10]:53362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYiw-0002yc-5J
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1csYit-0000rY-3H
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:34 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:43883)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1csYis-0000o6-Sw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 13:46:31 -0400
Received: from player796.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7EC5676687
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:46:27 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Mar 2017 19:46:22 +0200
Message-ID: <149063678269.4447.4512988258114498161.stgit@bahia.lan>
In-Reply-To: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] fsdev: don't allow unknown format in
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
