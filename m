Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCH-0000sF-AA
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCE-0001CU-Ab
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25072 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCD-0001Au-Va
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:15 +0300
Message-Id: <20170707152918.23086-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 07/10] nbd/server: fix TRACE in
 nbd_negotiate_send_rep_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Fix wrong order of TRACE arguments.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index e3fd0ca8fe..1eeafccaca 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -139,7 +139,7 @@ static int nbd_negotiate_send_rep_len(QIOChannel *ioc, uint32_t type,
     uint64_t magic;
 
     TRACE("Reply opt=%" PRIx32 " type=%" PRIx32 " len=%" PRIu32,
-          type, opt, len);
+          opt, type, len);
 
     magic = cpu_to_be64(NBD_REP_MAGIC);
     if (nbd_write(ioc, &magic, sizeof(magic), errp) < 0) {
-- 
2.11.1
