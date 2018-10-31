Received: from eggs.gnu.org ([2001:4830:134:3::10]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoM-0000es-2c
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoI-0002oZ-NY
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHtoI-0002dV-Bu
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4435C307DAA2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 16:57:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 31 Oct 2018 16:57:24 +0000
Message-Id: <20181031165725.61938-3-dgilbert@redhat.com>
In-Reply-To: <20181031165725.61938-1-dgilbert@redhat.com>
References: <20181031165725.61938-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] qapi: Fix COLOStatus and query-colo-status
 since version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com

From: Zhang Chen <zhangckid@gmail.com>

This structure and command have missed qemu version 3.0, so fix it to sin=
ce version 3.1.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Message-Id: <20181022164118.5502-1-zhangckid@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
 # <- { "return": { "mode": "primary", "active": true, "reason": "request=
" } }
 #
-# Since: 3.0
+# Since: 3.1
 ##
 { 'command': 'query-colo-status',
   'returns': 'COLOStatus' }
--=20
2.19.1
