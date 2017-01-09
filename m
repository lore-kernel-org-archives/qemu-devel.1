Received: from eggs.gnu.org ([2001:4830:134:3::10]:46295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb25-0001p2-Ev
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cQb22-00031b-OA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cQb22-00031D-I6
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:34:42 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A72113F1FB
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 14:34:42 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  9 Jan 2017 15:34:18 +0100
Message-Id: <20170109143437.30554-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170109143437.30554-1-marcandre.lureau@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 02/21] qapi: move QKeyCode doc body at the
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
index 3bdc6d8869..2990efa95d 100644
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
@@ -3619,10 +3623,6 @@
 # @kp_equals: since 2.6
 # @power: since 2.6
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
