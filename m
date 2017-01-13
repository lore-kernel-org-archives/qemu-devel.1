Received: from eggs.gnu.org ([2001:4830:134:3::10]:59581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS333-0003El-RA
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cS333-0006NP-15
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cS332-0006N4-S2
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 09:41:44 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F35CD3D94D
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 14:41:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 15:41:18 +0100
Message-Id: <20170113144135.5150-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170113144135.5150-1-marcandre.lureau@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 04/21] qapi: improve device_add schema
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

'device_add' is still incomplete for now, but we can fix a few
arguments:
- 'bus' is a common argument, regardless of the device
- 'id' is an optional argument

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi-schema.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index c18a59fefc..70e32570e8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2292,7 +2292,7 @@
 #
 # @bus: #optional the device's parent bus (device tree path)
 #
-# @id: the device's ID, must be unique
+# @id: #optional the device's ID, must be unique
 #
 # Additional arguments depend on the type.
 #
@@ -2322,7 +2322,7 @@
 # Since: 0.13
 ##
 { 'command': 'device_add',
-  'data': {'driver': 'str', 'id': 'str'},
+  'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
   'gen': false } # so we can get the additional arguments
=20
 ##
--=20
2.11.0
