Received: from eggs.gnu.org ([2001:4830:134:3::10]:59552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS333-0003EM-2P
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS330-0006M9-1B
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS32z-0006Lr-RX
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06E1E7F342
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:16 +0100
Message-Id: <20170113144135.5150-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 02/21] qapi: move QKeyCode doc body at the
 top
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

Following documentation guidelines.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 1d4f27f1a3..bcbf72bf59 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3612,6 +3612,10 @@
 ##
 # @QKeyCode:
 #
+# An enumeration of key name.
+#
+# This is used by the @send-key command.
+#
 # @unmapped: since 2.0
 # @pause: since 2.0
 # @ro: since 2.4
@@ -3622,10 +3626,6 @@
 # @henkan: since 2.9
 # @yen: since 2.9
 #
-# An enumeration of key name.
-#
-# This is used by the send-key command.
-#
 # Since: 1.3.0
 #
 ##
--=20
2.11.0
