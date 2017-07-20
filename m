Received: from eggs.gnu.org ([2001:4830:134:3::10]:54784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6J6-0005Y5-Dt
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dY6J3-0004uo-BE
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dY6J3-0004uC-5h
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BBDBC0467C1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:55:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 20 Jul 2017 09:55:25 +0200
Message-Id: <20170720075526.7383-2-kraxel@redhat.com>
In-Reply-To: <20170720075526.7383-1-kraxel@redhat.com>
References: <20170720075526.7383-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] vnc: Clarify documentation of QMP command
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

QMP command

    { "execute": "change",
      "arguments": { "device": "vnc", "target": "password", "arg": PWD } =
}

behaves just like

    { "execute": "change-vnc-password",
      "arguments": { "password", "arg": PWD } }

Their documentation differs, however.  According to
change-vnc-password's documentation, "an empty password [...] will set
the password to the empty string", while change's documentation claims
"no future logins will be allowed".  The former is actually correct.
Replace the incorrect claim by a reference to change-vnc-password.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 1500448182-21376-1-git-send-email-armbru@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi-schema.json | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 8b015bee2e..58d3a0209f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3011,8 +3011,7 @@
 # @arg:    If @device is a block device, then this is an optional format=
 to open
 #          the device with.
 #          If @device is 'vnc' and @target is 'password', this is the ne=
w VNC
-#          password to set.  If this argument is an empty string, then n=
o future
-#          logins will be allowed.
+#          password to set.  See change-vnc-password for additional note=
s.
 #
 # Returns: Nothing on success.
 #          If @device is not a valid block device, DeviceNotFound
--=20
2.9.3
