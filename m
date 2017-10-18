Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liS-00089v-5p
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e4liR-0005Nk-Ay
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e4liR-0005MW-5T
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C8E785541
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 10:36:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 18 Oct 2017 12:36:26 +0200
Message-Id: <20171018103633.5549-4-quintela@redhat.com>
In-Reply-To: <20171018103633.5549-1-quintela@redhat.com>
References: <20171018103633.5549-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 03/10] migration: Make cache size elements
 use the right types
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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
