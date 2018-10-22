Received: from eggs.gnu.org ([2001:4830:134:3::10]:35037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gEdGs-0007nJ-QO
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gEdGo-0002V0-Qe
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:41:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gEdGo-0002P5-I8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 12:41:34 -0400
Received: by mail-pg1-x541.google.com with SMTP id 32-v6so8101169pgu.2
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 09:41:34 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 23 Oct 2018 00:41:18 +0800
Message-Id: <20181022164118.5502-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH] qapi: Fix COLOStatus and query-colo-status
 since version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>

This structure and command have missed qemu version 3.0, so fix it to since version 3.1.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 0928f4b727..38d4c41d88 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1317,7 +1317,7 @@
 #
 # @reason: describes the reason for the COLO exit.
 #
-# Since: 3.0
+# Since: 3.1
 ##
 { 'struct': 'COLOStatus',
   'data': { 'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
@@ -1334,7 +1334,7 @@
 # -> { "execute": "query-colo-status" }
 # <- { "return": { "mode": "primary", "active": true, "reason": "request" } }
 #
-# Since: 3.0
+# Since: 3.1
 ##
 { 'command': 'query-colo-status',
   'returns': 'COLOStatus' }
-- 
2.17.GIT
