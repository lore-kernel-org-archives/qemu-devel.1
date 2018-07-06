Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORm-0000Fx-Dl
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORl-0001FG-FN
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORl-0001Ct-AG
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9C6D4022414
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:52 +0200
Message-Id: <20180706105753.26700-27-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 26/27] qapi: add more conditions to SPICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Now that member can be made conditional, let's make SPICE chardev
conditional:

* spiceport, spicevmc

  Before and after the patch for !CONFIG_SPICE, the error is the
  same ('spiceport' is not a valid char driver name).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/char.json | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index b7b2a05766..54e3b970f6 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -319,8 +319,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
-  'base': 'ChardevCommon' }
-# TODO: 'if': 'defined(CONFIG_SPICE)'
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevSpicePort:
@@ -332,8 +332,8 @@
 # Since: 1.5
 ##
 { 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
-  'base': 'ChardevCommon' }
-# TODO: 'if': 'defined(CONFIG_SPICE)'
+  'base': 'ChardevCommon',
+  'if': 'defined(CONFIG_SPICE)' }
=20
 ##
 # @ChardevVC:
@@ -387,10 +387,10 @@
                                        'testdev': 'ChardevCommon',
                                        'stdio'  : 'ChardevStdio',
                                        'console': 'ChardevCommon',
-                                       'spicevmc': 'ChardevSpiceChannel'=
,
-# TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' }=
,
-                                       'spiceport': 'ChardevSpicePort',
-# TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
+                                       'spicevmc': { 'type': 'ChardevSpi=
ceChannel',
+                                                     'if': 'defined(CONF=
IG_SPICE)' },
+                                       'spiceport': { 'type': 'ChardevSp=
icePort',
+                                                      'if': 'defined(CON=
FIG_SPICE)' },
                                        'vc'     : 'ChardevVC',
                                        'ringbuf': 'ChardevRingbuf',
                                        # next one is just for compatibil=
ity
--=20
2.18.0.rc1
