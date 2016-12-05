Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOK-0007Yi-8R
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOF-0006wo-Bq
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOF-0006wK-6C
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:19 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EADDC05AA40
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:12 +0100
Message-Id: <1480956313-31322-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] qapi: use one symbol per line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The documentation parser we are going to add only handles a single
symbol per line.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20161117155504.21843-8-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 10 +++++++---
 qapi/block-core.json |  8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 9c0b46a..918a79f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3612,15 +3612,19 @@
 ##
 # @QKeyCode:
 #
+# @unmapped: since 2.0
+# @pause: since 2.0
+# @ro: since 2.4
+# @kp_comma: since 2.4
+# @kp_equals: since 2.6
+# @power: since 2.6
+#
 # An enumeration of key name.
 #
 # This is used by the send-key command.
 #
 # Since: 1.3.0
 #
-# 'unmapped' and 'pause' since 2.0
-# 'ro' and 'kp_comma' since 2.4
-# 'kp_equals' and 'power' since 2.6
 ##
 { 'enum': 'QKeyCode',
   'data': [ 'unmapped',
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 33bc93a..96d0859 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1712,9 +1712,13 @@
 #
 # Drivers that are supported in block device operations.
 #
-# @host_device, @host_cdrom: Since 2.1
+# @host_device: Since 2.1
+# @host_cdrom: Since 2.1
 # @gluster: Since 2.7
-# @nbd, @nfs, @replication, @ssh: Since 2.8
+# @nbd: Since 2.8
+# @nfs: Since 2.8
+# @replication: Since 2.8
+# @ssh: Since 2.8
 #
 # Since: 2.0
 ##
--=20
2.5.5
