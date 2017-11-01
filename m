Received: from eggs.gnu.org ([2001:4830:134:3::10]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9v9k-0006Fq-G5
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9v9f-0004oU-LE
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:42:16 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  1 Nov 2017 18:42:04 +0300
Message-Id: <20171101154204.27146-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171101154204.27146-1-vsementsov@virtuozzo.com>
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] nbd/server: add assert to
 nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Add an assert here to make last length assignment meaningful and
following return without tail dropping obvious.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nbd/server.c b/nbd/server.c
index 7fcec0af7e..bcf0cdb47c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -423,6 +423,7 @@ static int nbd_negotiate_handle_info(NBDClient *client, uint32_t length,
             break;
         }
     }
+    assert(length == 0);
 
     exp = nbd_export_find(name);
     if (!exp) {
-- 
2.11.1
