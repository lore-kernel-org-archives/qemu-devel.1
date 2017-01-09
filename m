Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb27-0001qR-7s
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb26-00034L-E0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cQb26-00033F-95
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79874A794
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:34:46 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  9 Jan 2017 15:34:21 +0100
Message-Id: <20170109143437.30554-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 05/21] qapi: improve TransactionAction doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

TransactionAction is a flat union, document 'type' versions
exhaustively, and sort the members.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 85efdfccd8..ac6352fcf9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1795,28 +1795,29 @@
 # @TransactionAction:
 #
 # A discriminated record of operations that can be performed with
-# @transaction.
+# @transaction. Action @type can be:
 #
-# Since: 1.1
+# - @abort: since 1.6
+# - @block-dirty-bitmap-add: since 2.5
+# - @block-dirty-bitmap-clear: since 2.5
+# - @blockdev-backup: since 2.3
+# - @blockdev-snapshot: since 2.5
+# - @blockdev-snapshot-internal-sync: since 1.7
+# - @blockdev-snapshot-sync: since 1.1
+# - @drive-backup: since 1.6
 #
-# drive-backup since 1.6
-# abort since 1.6
-# blockdev-snapshot-internal-sync since 1.7
-# blockdev-backup since 2.3
-# blockdev-snapshot since 2.5
-# block-dirty-bitmap-add since 2.5
-# block-dirty-bitmap-clear since 2.5
+# Since: 1.1
 ##
 { 'union': 'TransactionAction',
   'data': {
-       'blockdev-snapshot': 'BlockdevSnapshot',
-       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
-       'drive-backup': 'DriveBackup',
-       'blockdev-backup': 'BlockdevBackup',
        'abort': 'Abort',
-       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
        'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
-       'block-dirty-bitmap-clear': 'BlockDirtyBitmap'
+       'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
+       'blockdev-backup': 'BlockdevBackup',
+       'blockdev-snapshot': 'BlockdevSnapshot',
+       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
+       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
+       'drive-backup': 'DriveBackup'
    } }
=20
 ##
--=20
2.11.0
