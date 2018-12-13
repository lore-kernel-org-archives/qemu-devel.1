Received: from eggs.gnu.org ([2001:4830:134:3::10]:53275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxr-0005lG-Or
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVxn-0002Rh-TK
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:44:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVxm-0001d7-03
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:43:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBAC73082211
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 18:43:48 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Dec 2018 19:43:22 +0100
Message-Id: <20181213184340.24037-15-armbru@redhat.com>
In-Reply-To: <20181213184340.24037-1-armbru@redhat.com>
References: <20181213184340.24037-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/32] qapi: break long lines at 'data' member
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

Let's break the line before 'data'. While at it, improve a bit
indentation/spacing. (I removed some alignment which are not helping
much readability and become quickly inconsistent)

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181208111606.8505-26-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json |  13 ++--
 qapi/char.json       | 138 +++++++++++++++++++++++++------------------
 qapi/migration.json  |   3 +-
 qapi/misc.json       |   7 ++-
 qapi/net.json        |   3 +-
 qapi/tpm.json        |   5 +-
 qapi/ui.json         |   3 +-
 7 files changed, 101 insertions(+), 71 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d4fe710836..92e0205d91 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1143,8 +1143,10 @@
 # This command is now obsolete and will always return an error since 2.1=
0
 #
 ##
-{ 'command': 'block_passwd', 'data': {'*device': 'str',
-                                      '*node-name': 'str', 'password': '=
str'} }
+{ 'command': 'block_passwd',
+  'data': { '*device': 'str',
+            '*node-name': 'str',
+            'password': 'str' } }
=20
 ##
 # @block_resize:
@@ -1171,9 +1173,10 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'block_resize', 'data': { '*device': 'str',
-                                       '*node-name': 'str',
-                                       'size': 'int' }}
+{ 'command': 'block_resize',
+  'data': { '*device': 'str',
+            '*node-name': 'str',
+            'size': 'int' } }
=20
 ##
 # @NewImageMode:
diff --git a/qapi/char.json b/qapi/char.json
index 79bac598a0..24628331ec 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -25,9 +25,10 @@
 #
 # Since: 0.14.0
 ##
-{ 'struct': 'ChardevInfo', 'data': {'label': 'str',
-                                  'filename': 'str',
-                                  'frontend-open': 'bool'} }
+{ 'struct': 'ChardevInfo',
+  'data': { 'label': 'str',
+            'filename': 'str',
+            'frontend-open': 'bool' } }
=20
 ##
 # @query-chardev:
@@ -152,7 +153,8 @@
 #
 ##
 { 'command': 'ringbuf-write',
-  'data': {'device': 'str', 'data': 'str',
+  'data': { 'device': 'str',
+            'data': 'str',
            '*format': 'DataFormat'} }
=20
 ##
@@ -202,8 +204,9 @@
 #
 # Since: 2.6
 ##
-{ 'struct': 'ChardevCommon', 'data': { '*logfile': 'str',
-                                       '*logappend': 'bool' } }
+{ 'struct': 'ChardevCommon',
+  'data': { '*logfile': 'str',
+            '*logappend': 'bool' } }
=20
 ##
 # @ChardevFile:
@@ -217,9 +220,10 @@
 #
 # Since: 1.4
 ##
-{ 'struct': 'ChardevFile', 'data': { '*in' : 'str',
-                                   'out' : 'str',
-                                   '*append': 'bool' },
+{ 'struct': 'ChardevFile',
+  'data': { '*in': 'str',
+            'out': 'str',
+            '*append': 'bool' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -232,7 +236,8 @@
 #
 # Since: 1.4
 ##
-{ 'struct': 'ChardevHostdev', 'data': { 'device' : 'str' },
+{ 'struct': 'ChardevHostdev',
+  'data': { 'device': 'str' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -260,15 +265,16 @@
 #
 # Since: 1.4
 ##
-{ 'struct': 'ChardevSocket', 'data': { 'addr'       : 'SocketAddressLega=
cy',
-                                     '*tls-creds'  : 'str',
-                                     '*server'    : 'bool',
-                                     '*wait'      : 'bool',
-                                     '*nodelay'   : 'bool',
-                                     '*telnet'    : 'bool',
-                                     '*tn3270'    : 'bool',
-                                     '*websocket' : 'bool',
-                                     '*reconnect' : 'int' },
+{ 'struct': 'ChardevSocket',
+  'data': { 'addr': 'SocketAddressLegacy',
+            '*tls-creds': 'str',
+            '*server': 'bool',
+            '*wait': 'bool',
+            '*nodelay': 'bool',
+            '*telnet': 'bool',
+            '*tn3270': 'bool',
+            '*websocket': 'bool',
+            '*reconnect': 'int' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -281,8 +287,9 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevUdp', 'data': { 'remote' : 'SocketAddressLegacy',
-                                  '*local' : 'SocketAddressLegacy' },
+{ 'struct': 'ChardevUdp',
+  'data': { 'remote': 'SocketAddressLegacy',
+            '*local': 'SocketAddressLegacy' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -294,7 +301,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevMux', 'data': { 'chardev' : 'str' },
+{ 'struct': 'ChardevMux',
+  'data': { 'chardev': 'str' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -308,7 +316,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevStdio', 'data': { '*signal' : 'bool' },
+{ 'struct': 'ChardevStdio',
+  'data': { '*signal': 'bool' },
   'base': 'ChardevCommon' }
=20
=20
@@ -321,7 +330,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevSpiceChannel', 'data': { 'type'  : 'str' },
+{ 'struct': 'ChardevSpiceChannel',
+  'data': { 'type': 'str' },
   'base': 'ChardevCommon' }
 # TODO: 'if': 'defined(CONFIG_SPICE)'
=20
@@ -334,7 +344,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevSpicePort', 'data': { 'fqdn'  : 'str' },
+{ 'struct': 'ChardevSpicePort',
+  'data': { 'fqdn': 'str' },
   'base': 'ChardevCommon' }
 # TODO: 'if': 'defined(CONFIG_SPICE)'
=20
@@ -350,10 +361,11 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevVC', 'data': { '*width'  : 'int',
-                                 '*height' : 'int',
-                                 '*cols'   : 'int',
-                                 '*rows'   : 'int' },
+{ 'struct': 'ChardevVC',
+  'data': { '*width': 'int',
+            '*height': 'int',
+            '*cols': 'int',
+            '*rows': 'int' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -365,7 +377,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'ChardevRingbuf', 'data': { '*size'  : 'int' },
+{ 'struct': 'ChardevRingbuf',
+  'data': { '*size': 'int' },
   'base': 'ChardevCommon' }
=20
 ##
@@ -375,29 +388,30 @@
 #
 # Since: 1.4 (testdev since 2.2, wctablet since 2.9)
 ##
-{ 'union': 'ChardevBackend', 'data': { 'file'   : 'ChardevFile',
-                                       'serial' : 'ChardevHostdev',
-                                       'parallel': 'ChardevHostdev',
-                                       'pipe'   : 'ChardevHostdev',
-                                       'socket' : 'ChardevSocket',
-                                       'udp'    : 'ChardevUdp',
-                                       'pty'    : 'ChardevCommon',
-                                       'null'   : 'ChardevCommon',
-                                       'mux'    : 'ChardevMux',
-                                       'msmouse': 'ChardevCommon',
-                                       'wctablet' : 'ChardevCommon',
-                                       'braille': 'ChardevCommon',
-                                       'testdev': 'ChardevCommon',
-                                       'stdio'  : 'ChardevStdio',
-                                       'console': 'ChardevCommon',
-                                       'spicevmc': 'ChardevSpiceChannel'=
,
+{ 'union': 'ChardevBackend',
+  'data': { 'file': 'ChardevFile',
+            'serial': 'ChardevHostdev',
+            'parallel': 'ChardevHostdev',
+            'pipe': 'ChardevHostdev',
+            'socket': 'ChardevSocket',
+            'udp': 'ChardevUdp',
+            'pty': 'ChardevCommon',
+            'null': 'ChardevCommon',
+            'mux': 'ChardevMux',
+            'msmouse': 'ChardevCommon',
+            'wctablet': 'ChardevCommon',
+            'braille': 'ChardevCommon',
+            'testdev': 'ChardevCommon',
+            'stdio': 'ChardevStdio',
+            'console': 'ChardevCommon',
+            'spicevmc': 'ChardevSpiceChannel',
 # TODO: { 'type': 'ChardevSpiceChannel', 'if': 'defined(CONFIG_SPICE)' }=
,
-                                       'spiceport': 'ChardevSpicePort',
+            'spiceport': 'ChardevSpicePort',
 # TODO: { 'type': 'ChardevSpicePort', 'if': 'defined(CONFIG_SPICE)' },
-                                       'vc'     : 'ChardevVC',
-                                       'ringbuf': 'ChardevRingbuf',
-                                       # next one is just for compatibil=
ity
-                                       'memory' : 'ChardevRingbuf' } }
+            'vc': 'ChardevVC',
+            'ringbuf': 'ChardevRingbuf',
+            # next one is just for compatibility
+            'memory': 'ChardevRingbuf' } }
=20
 ##
 # @ChardevReturn:
@@ -409,7 +423,8 @@
 #
 # Since: 1.4
 ##
-{ 'struct' : 'ChardevReturn', 'data': { '*pty' : 'str' } }
+{ 'struct' : 'ChardevReturn',
+  'data': { '*pty': 'str' } }
=20
 ##
 # @chardev-add:
@@ -442,8 +457,9 @@
 # <- { "return": { "pty" : "/dev/pty/42" } }
 #
 ##
-{ 'command': 'chardev-add', 'data': {'id'      : 'str',
-                                     'backend' : 'ChardevBackend' },
+{ 'command': 'chardev-add',
+  'data': { 'id': 'str',
+            'backend': 'ChardevBackend' },
   'returns': 'ChardevReturn' }
=20
 ##
@@ -482,8 +498,9 @@
 # <- {"return": {}}
 #
 ##
-{ 'command': 'chardev-change', 'data': {'id'      : 'str',
-                                        'backend' : 'ChardevBackend' },
+{ 'command': 'chardev-change',
+  'data': { 'id': 'str',
+            'backend': 'ChardevBackend' },
   'returns': 'ChardevReturn' }
=20
 ##
@@ -503,7 +520,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'chardev-remove', 'data': {'id': 'str'} }
+{ 'command': 'chardev-remove',
+  'data': { 'id': 'str' } }
=20
 ##
 # @chardev-send-break:
@@ -522,7 +540,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'chardev-send-break', 'data': {'id': 'str'} }
+{ 'command': 'chardev-send-break',
+  'data': { 'id': 'str' } }
=20
 ##
 # @VSERPORT_CHANGE:
@@ -543,4 +562,5 @@
 #
 ##
 { 'event': 'VSERPORT_CHANGE',
-  'data': { 'id': 'str', 'open': 'bool' } }
+  'data': { 'id': 'str',
+            'open': 'bool' } }
diff --git a/qapi/migration.json b/qapi/migration.json
index 38d4c41d88..5fd33316a0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1356,7 +1356,8 @@
 #
 # Since: 3.0
 ##
-{ 'command': 'migrate-recover', 'data': { 'uri': 'str' },
+{ 'command': 'migrate-recover',
+  'data': { 'uri': 'str' },
   'allow-oob': true }
=20
 ##
diff --git a/qapi/misc.json b/qapi/misc.json
index 4211a732f3..8325e0dc9c 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2385,7 +2385,9 @@
 # <- { "return": { "fdset-id": 1, "fd": 3 } }
 #
 ##
-{ 'command': 'add-fd', 'data': {'*fdset-id': 'int', '*opaque': 'str'},
+{ 'command': 'add-fd',
+  'data': { '*fdset-id': 'int',
+            '*opaque': 'str' },
   'returns': 'AddfdInfo' }
=20
 ##
@@ -2657,7 +2659,8 @@
 #    }
 #
 ##
-{'command': 'query-command-line-options', 'data': { '*option': 'str' },
+{'command': 'query-command-line-options',
+ 'data': { '*option': 'str' },
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
=20
diff --git a/qapi/net.json b/qapi/net.json
index 8f99fd911d..a1a0f39f74 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -657,7 +657,8 @@
 #    }
 #
 ##
-{ 'command': 'query-rx-filter', 'data': { '*name': 'str' },
+{ 'command': 'query-rx-filter',
+  'data': { '*name': 'str' },
   'returns': ['RxFilterInfo'] }
=20
 ##
diff --git a/qapi/tpm.json b/qapi/tpm.json
index d50deef5e9..b30323bb6b 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -76,8 +76,9 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
-                                             '*cancel-path' : 'str'} }
+{ 'struct': 'TPMPassthroughOptions',
+  'data': { '*path': 'str',
+            '*cancel-path': 'str' } }
=20
 ##
 # @TPMEmulatorOptions:
diff --git a/qapi/ui.json b/qapi/ui.json
index fd39acb5c3..5ad13248d5 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -598,7 +598,8 @@
 # Notes:  An empty password in this command will set the password to the=
 empty
 #         string.  Existing clients are unaffected by executing this com=
mand.
 ##
-{ 'command': 'change-vnc-password', 'data': {'password': 'str'},
+{ 'command': 'change-vnc-password',
+  'data': { 'password': 'str' },
   'if': 'defined(CONFIG_VNC)' }
=20
 ##
--=20
2.17.2
