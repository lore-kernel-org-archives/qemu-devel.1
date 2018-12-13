Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxo-0005hX-Gh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxl-0002Fd-4V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxj-0001iB-JP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14388307CDE3
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:39 +0100
Message-Id: <20181213184340.24037-32-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/32] qapi: add more conditions to SPICE
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

Now that member can be made conditional, let's make SPICE chardev
conditional:

* spiceport, spicevmc

  Before and after the patch for !CONFIG_SPICE, the error is the
  same ('spiceport' is not a valid char driver name).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181213123724.4866-22-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/char.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 24628331ec..77ed847972 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -332,8 +332,8 @@
 ##
 { 'struct': 'ChardevSpiceChannel',
   'data': { 'type': 'str' },
-  'base': 'ChardevCommon' }
-# TODO: 'if': 'defined(CONFIG_SPICE)'
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevSpicePort:
@@ -346,8 +346,8 @@
 ##
 { 'struct': 'ChardevSpicePort',
   'data': { 'fqdn': 'str' },
-  'base': 'ChardevCommon' }
-# TODO: 'if': 'defined(CONFIG_SPICE)'
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevVC:
@@ -404,10 +404,10 @@
             'testdev': 'ChardevCommon',
             'stdio': 'ChardevStdio',
             'console': 'ChardevCommon',
-            'spicevmc': 'ChardevSpiceChannel',
-# TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' }=
,
-            'spiceport': 'ChardevSpicePort',
-# TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
+            'spicevmc': { 'type': 'ChardevSpiceChannel',
+                          'if': 'defined(CONFIG_SPICE)' },
+            'spiceport': { 'type': 'ChardevSpicePort',
+                           'if': 'defined(CONFIG_SPICE)' },
             'vc': 'ChardevVC',
             'ringbuf': 'ChardevRingbuf',
             # next one is just for compatibility
--=20
2.17.2
