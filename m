Received: from eggs.gnu.org ([2001:4830:134:3::10]:59721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS33E-0003Nw-9i
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS339-0006Rx-Bv
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS339-0006Rg-3V
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:51 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39A2F61B90
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:22 +0100
Message-Id: <20170113144135.5150-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 08/21] qapi: move experimental note down
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

Use a better 'Note:' section, move it below parameters following
guidelines.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/block-core.json | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b42216960..fb5034c3a9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2441,12 +2441,12 @@
 # BlockBackend will be created; otherwise, @node-name is mandatory at th=
e top
 # level and no BlockBackend will be created.
 #
-# This command is still a work in progress.  It doesn't support all
+# For the arguments, see the documentation of BlockdevOptions.
+#
+# Note: This command is still a work in progress.  It doesn't support al=
l
 # block drivers among other things.  Stay away from it unless you want
 # to help with its development.
 #
-# For the arguments, see the documentation of BlockdevOptions.
-#
 # Since: 1.7
 ##
 { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }
@@ -2458,12 +2458,12 @@
 # The command will fail if the node is attached to a device or is
 # otherwise being used.
 #
-# This command is still a work in progress and is considered
+# @node-name: Name of the graph node to delete.
+#
+# Note: This command is still a work in progress and is considered
 # experimental. Stay away from it unless you want to help with its
 # development.
 #
-# @node-name: Name of the graph node to delete.
-#
 # Since: 2.5
 ##
 { 'command': 'x-blockdev-del', 'data': { 'node-name': 'str' } }
@@ -2530,13 +2530,13 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no=
-op.
 #
-# This command is still a work in progress and is considered experimenta=
l.
-# Stay away from it unless you want to help with its development.
-#
 # @device: #optional Block device name (deprecated, use @id instead)
 #
 # @id:     #optional The name or QOM path of the guest device (since: 2.=
8)
 #
+# Note: This command is still a work in progress and is considered exper=
imental.
+# Stay away from it unless you want to help with its development.
+#
 # Since: 2.5
 ##
 { 'command': 'x-blockdev-remove-medium',
@@ -2550,15 +2550,15 @@
 # device's tray must currently be open (unless there is no attached gues=
t
 # device) and there must be no medium inserted already.
 #
-# This command is still a work in progress and is considered experimenta=
l.
-# Stay away from it unless you want to help with its development.
-#
 # @device:    #optional Block device name (deprecated, use @id instead)
 #
 # @id:        #optional The name or QOM path of the guest device (since:=
 2.8)
 #
 # @node-name: name of a node in the block driver state graph
 #
+# Note: This command is still a work in progress and is considered exper=
imental.
+# Stay away from it unless you want to help with its development.
+#
 # Since: 2.5
 ##
 { 'command': 'x-blockdev-insert-medium',
--=20
2.11.0
