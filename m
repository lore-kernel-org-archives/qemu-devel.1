Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAa-0008LV-7A
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cklAZ-0001TW-EP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cklAZ-0001SF-9C
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:51 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:54 +0800
Message-Id: <1488777954-4578-20-git-send-email-jasowang@redhat.com>
In-Reply-To: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
References: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL RESEND 19/19] net/filter-mirror: Follow
 CODING_STYLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
