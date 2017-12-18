Received: from eggs.gnu.org ([2001:4830:134:3::10]:60262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ej-0002Gb-KH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2ei-0003e6-Pl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:09:01 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:19 -0500
Message-Id: <20171218210819.31576-11-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 10/10] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/curl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 00a9879..35cf417 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -857,6 +857,9 @@ out_noclean:
     qemu_mutex_destroy(&s->mutex);
     g_free(s->cookie);
     g_free(s->url);
+    g_free(s->username);
+    g_free(s->proxyusername);
+    g_free(s->proxypassword);
     qemu_opts_del(opts);
     return -EINVAL;
 }
@@ -955,6 +958,9 @@ static void curl_close(BlockDriverState *bs)
 
     g_free(s->cookie);
     g_free(s->url);
+    g_free(s->username);
+    g_free(s->proxyusername);
+    g_free(s->proxypassword);
 }
 
 static int64_t curl_getlength(BlockDriverState *bs)
-- 
2.9.5
