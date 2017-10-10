Received: from eggs.gnu.org ([2001:4830:134:3::10]:38611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4O-00075A-1A
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4L-0002JU-Mz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e1z4L-0002J5-HW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FF5E50EE3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 18:15:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 10 Oct 2017 20:15:35 +0200
Message-Id: <20171010181542.24168-4-quintela@redhat.com>
In-Reply-To: <20171010181542.24168-1-quintela@redhat.com>
References: <20171010181542.24168-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] migration: Make cache size elements use
 the right types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/page_cache.c | 8 ++++----
 migration/page_cache.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/page_cache.c b/migration/page_cache.c
index 381e555ddb..6b2dd77cf0 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -39,12 +39,12 @@ struct CacheItem {
 
 struct PageCache {
     CacheItem *page_cache;
-    unsigned int page_size;
-    int64_t max_num_items;
-    int64_t num_items;
+    size_t page_size;
+    size_t max_num_items;
+    size_t num_items;
 };
 
-PageCache *cache_init(int64_t num_pages, unsigned int page_size)
+PageCache *cache_init(size_t num_pages, size_t page_size)
 {
     int64_t i;
 
diff --git a/migration/page_cache.h b/migration/page_cache.h
index 4fadd0c501..931868b857 100644
--- a/migration/page_cache.h
+++ b/migration/page_cache.h
@@ -28,7 +28,7 @@ typedef struct PageCache PageCache;
  * @num_pages: cache maximal number of cached pages
  * @page_size: cache page size
  */
-PageCache *cache_init(int64_t num_pages, unsigned int page_size);
+PageCache *cache_init(size_t num_pages, size_t page_size);
 
 /**
  * cache_fini: free all cache resources
-- 
2.13.6
