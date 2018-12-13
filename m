Received: from eggs.gnu.org ([2001:4830:134:3::10]:47735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQHP-0001t6-Rx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXQHL-0001Dc-Oo
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXQHL-000133-ED
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D18D8EA34
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:39:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 16:37:23 +0400
Message-Id: <20181213123724.4866-22-marcandre.lureau@redhat.com>
In-Reply-To: <20181213123724.4866-1-marcandre.lureau@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 21/22] qapi: add more conditions to SPICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Now that member can be made conditional, let's make SPICE chardev
conditional:

* spiceport, spicevmc

  Before and after the patch for !CONFIG_SPICE, the error is the
  same ('spiceport' is not a valid char driver name).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
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
2.20.0
