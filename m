Received: from eggs.gnu.org ([2001:4830:134:3::10]:39592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXjFx-0003b1-VT
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXjFu-00053N-QG
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXjFu-00052e-Jo
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B36780C1E
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 07:09:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 19 Jul 2017 09:09:42 +0200
Message-Id: <1500448182-21376-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH] vnc: Clarify documentation of QMP command
 change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, eblake@redhat.com

QMP command

    { "execute": "change",
      "arguments": { "device": "vnc", "target": "password", "arg": PWD } }

behaves just like

    { "execute": "change-vnc-password",
      "arguments": { "password", "arg": PWD } }

Their documentation differs, however.  According to
change-vnc-password's documentation, "an empty password [...] will set
the password to the empty string", while change's documentation claims
"no future logins will be allowed".  The former is actually correct.
Replace the incorrect claim by a reference to change-vnc-password.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 8b015be..58d3a02 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3011,8 +3011,7 @@
 # @arg:    If @device is a block device, then this is an optional format to open
 #          the device with.
 #          If @device is 'vnc' and @target is 'password', this is the new VNC
-#          password to set.  If this argument is an empty string, then no future
-#          logins will be allowed.
+#          password to set.  See change-vnc-password for additional notes.
 #
 # Returns: Nothing on success.
 #          If @device is not a valid block device, DeviceNotFound
-- 
2.7.5
