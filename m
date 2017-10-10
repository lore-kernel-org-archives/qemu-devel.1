Received: from eggs.gnu.org ([2001:4830:134:3::10]:38575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4K-00073Q-Nr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e1z4J-0002IG-H3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e1z4J-0002Ht-Bf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D16380B2A
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 18:15:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 10 Oct 2017 20:15:34 +0200
Message-Id: <20171010181542.24168-3-quintela@redhat.com>
In-Reply-To: <20171010181542.24168-1-quintela@redhat.com>
References: <20171010181542.24168-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] migratiom: Remove max_item_age parameter
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

It was not used at all since commit:

27af7d6ea5015e5ef1f7985eab94a8a218267a2b

which replaced its use by the dirty sync count.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/page_cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/page_cache.c b/migration/page_cache.c
index ba984c4858..381e555ddb 100644
--- a/migration/page_cache.c
+++ b/migration/page_cache.c
@@ -41,7 +41,6 @@ struct PageCache {
     CacheItem *page_cache;
     unsigned int page_size;
     int64_t max_num_items;
-    uint64_t max_item_age;
     int64_t num_items;
 };
 
@@ -69,7 +68,6 @@ PageCache *cache_init(int64_t num_pages, unsigned int page_size)
     }
     cache->page_size = page_size;
     cache->num_items = 0;
-    cache->max_item_age = 0;
     cache->max_num_items = num_pages;
 
     DPRINTF("Setting cache buckets to %" PRId64 "\n", cache->max_num_items);
-- 
2.13.6
