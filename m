Received: from eggs.gnu.org ([2001:4830:134:3::10]:33061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDufA-0004qG-KC
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDuf5-0002fd-Ic
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:56 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:44272 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDuf5-0002fM-75
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:26:51 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 25 May 2017 18:26:25 +0300
Message-Id: <20170525152628.37628-5-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-1-vsementsov@virtuozzo.com>
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 4/7] common: make get_human_readable_size public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

To be reused from qemu-img check.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qapi.c          | 2 +-
 include/qemu-common.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index a40922ea26..d249d97142 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -524,7 +524,7 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
 
 #define NB_SUFFIXES 4
 
-static char *get_human_readable_size(char *buf, int buf_size, int64_t size)
+char *get_human_readable_size(char *buf, int buf_size, int64_t size)
 {
     static const char suffixes[NB_SUFFIXES] = {'K', 'M', 'G', 'T'};
     int64_t base;
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 387ef520bf..7102ad8dbd 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -152,4 +152,6 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
+char *get_human_readable_size(char *buf, int buf_size, int64_t size);
+
 #endif
-- 
2.11.1
