Received: from eggs.gnu.org ([2001:4830:134:3::10]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTSDB-0001rY-Ap
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTSD6-0003n4-DK
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:22:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTSD6-0003n0-91
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E535840122BD
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:22:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-1.ams2.redhat.com [10.36.117.1])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C12491117624
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:22:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Jun 2018 15:22:42 +0200
Message-Id: <20180614132242.12970-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] coverity-model: Fix indentation messed up in
 commit 04a0afe5285
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/coverity-model.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
index 48b112393b..2ec753db05 100644
--- a/scripts/coverity-model.c
+++ b/scripts/coverity-model.c
@@ -106,12 +106,12 @@ static int get_keysym(const name2keysym_t *table,
 /* Replay data is considered trusted.  */
 uint8_t replay_get_byte(void)
 {
-     uint8_t byte = 0;
-     if (replay_file) {
-         uint8_t c;
-         byte = c;
-     }
-     return byte;
+    uint8_t byte = 0;
+    if (replay_file) {
+        uint8_t c;
+        byte = c;
+    }
+    return byte;
 }
 
 
-- 
2.17.1
