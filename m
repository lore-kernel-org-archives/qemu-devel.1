Received: from eggs.gnu.org ([2001:4830:134:3::10]:58510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZC-0003cd-JN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fIjZB-00023a-SO
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56528 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fIjZA-000231-T9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 19:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F3F340201A1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 23:41:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 16 May 2018 01:40:16 +0200
Message-Id: <20180515234017.2277-40-quintela@redhat.com>
In-Reply-To: <20180515234017.2277-1-quintela@redhat.com>
References: <20180515234017.2277-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 39/40] migration: Textual fixups for blocktime
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Blank lines and comments as suggested by Eric.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180427111502.9822-1-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qapi/migration.json | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 23ba85ed3a..3ec418dabf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -162,11 +162,13 @@
 #              error strings. (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during postcopy
-#           live migration (Since 2.13)
+#           live migration. This is only present when the postcopy-blocktime
+#           migration capability is enabled. (Since 2.13)
 #
-# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU (Since 2.13)
+# @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU.  This is
+#           only present when the postcopy-blocktime migration capability
+#           is enabled. (Since 2.13)
 #
-
 #
 # Since: 0.14.0
 ##
@@ -368,7 +370,6 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
-#
 # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
 #                 (since 2.12)
 #
-- 
2.17.0
