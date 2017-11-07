Received: from eggs.gnu.org ([2001:4830:134:3::10]:33549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLM-00008X-PP
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLM-0004eR-26
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:40 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:23 -0500
Message-Id: <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

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
