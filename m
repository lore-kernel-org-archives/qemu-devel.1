Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoI-0004zU-G9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoH-0005O2-Ky
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCzoH-0005Nl-FE
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:33 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:56 +0800
Message-Id: <1495507439-1784-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] net/filter-mirror.c: Remove duplicate check
 code.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

The s->outdev have checked in filter_mirror_set_outdev().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-mirror.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 72fa7c2..fd0322f 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -194,12 +194,6 @@ static void filter_mirror_setup(NetFilterState *nf, Error **errp)
     MirrorState *s = FILTER_MIRROR(nf);
     Chardev *chr;
 
-    if (!s->outdev) {
-        error_setg(errp, "filter mirror needs 'outdev' "
-                   "property set");
-        return;
-    }
-
     chr = qemu_chr_find(s->outdev);
     if (chr == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-- 
2.7.4
