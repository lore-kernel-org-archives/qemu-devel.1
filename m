Received: from eggs.gnu.org ([2001:4830:134:3::10]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cjHvK-00016y-NN
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cjHvH-0003GI-Dx
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 23:01:02 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 2 Mar 2017 11:59:30 +0800
Message-ID: <1488427170-28050-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/filter-mirror: Follow CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index aa0aa98..72fa7c2 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -49,7 +49,7 @@ static int filter_mirror_send(CharBackend *chr_out,
 {
     int ret = 0;
     ssize_t size = 0;
-    uint32_t len =  0;
+    uint32_t len = 0;
     char *buf;
 
     size = iov_size(iov, iovcnt);
@@ -77,8 +77,9 @@ err:
     return ret < 0 ? ret : -EIO;
 }
 
-static void
-redirector_to_filter(NetFilterState *nf, const uint8_t *buf, int len)
+static void redirector_to_filter(NetFilterState *nf,
+                                 const uint8_t *buf,
+                                 int len)
 {
     struct iovec iov = {
         .iov_base = (void *)buf,
-- 
2.7.4
