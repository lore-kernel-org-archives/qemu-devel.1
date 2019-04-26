Received: from eggs.gnu.org ([209.51.188.92]:52342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtL-0005Cr-6o
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtK-0003Ot-FG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:13449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJwtK-0003Nl-78
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:34 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri, 26 Apr 2019 17:07:29 +0800
Message-Id: <20190426090730.2691-3-chen.zhang@intel.com>
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
References: <20190426090730.2691-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] migration/colo.h: Remove obsolete codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 include/migration/colo.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index ddebe0ad27..f6fbe23ec9 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -22,8 +22,6 @@ enum colo_event {
     COLO_EVENT_FAILOVER,
 };
 
-void colo_info_init(void);
-
 void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
-- 
2.17.GIT
