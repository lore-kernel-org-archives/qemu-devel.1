Received: from eggs.gnu.org ([2001:4830:134:3::10]:42927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cqZR6-0007g4-5q
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1cqZR1-0004ld-Rm
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:07:56 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1cqZR1-0004kq-IR
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:07:51 -0400
Date: Wed, 22 Mar 2017 07:07:09 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <1694034280.9874888.1490162829201.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com>
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, mreitz <mreitz@redhat.com>

Pretty awesome news ! Congrat !

So, can we update the wiki changelog ?

http://wiki.qemu-project.org/ChangeLog/2.9

"QMP command blockdev-add is still a work in progress. It doesn't support a=
ll block drivers, it lacks a matching blockdev-del, and more. It might chan=
ge incompatibly."


----- Mail original -----
De: "Markus Armbruster" <armbru@redhat.com>
=C3=80: "qemu-devel" <qemu-devel@nongnu.org>
Cc: "Kevin Wolf" <kwolf@redhat.com>, pkrempa@redhat.com, "mreitz" <mreitz@r=
edhat.com>
Envoy=C3=A9: Mardi 21 Mars 2017 17:57:53
Objet: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and blockde=
v-del supported

It's been a long journey, but here we are.=20

x-blockdev-remove-medium, x-blockdev-insert-medium and=20
x-blockdev-change need a bit more work, so leave them alone for now.=20

Signed-off-by: Markus Armbruster <armbru@redhat.com>=20
---=20
blockdev.c | 4 ++--=20
qapi/block-core.json | 14 +++++---------=20
tests/qemu-iotests/139 | 8 ++++----=20
tests/qemu-iotests/141 | 4 ++--=20
tests/qemu-iotests/147 | 2 +-=20
5 files changed, 14 insertions(+), 18 deletions(-)=20

diff --git a/blockdev.c b/blockdev.c=20
index c5b2c2c..040c152 100644=20
--- a/blockdev.c=20
+++ b/blockdev.c=20
@@ -2835,7 +2835,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)=
=20

bs =3D bdrv_find_node(id);=20
if (bs) {=20
- qmp_x_blockdev_del(id, &local_err);=20
+ qmp_blockdev_del(id, &local_err);=20
if (local_err) {=20
error_report_err(local_err);=20
}=20
@@ -3900,7 +3900,7 @@ fail:=20
visit_free(v);=20
}=20

-void qmp_x_blockdev_del(const char *node_name, Error **errp)=20
+void qmp_blockdev_del(const char *node_name, Error **errp)=20
{=20
AioContext *aio_context;=20
BlockDriverState *bs;=20
diff --git a/qapi/block-core.json b/qapi/block-core.json=20
index 0f132fc..5d913d4 100644=20
--- a/qapi/block-core.json=20
+++ b/qapi/block-core.json=20
@@ -2907,11 +2907,7 @@=20
# BlockBackend will be created; otherwise, @node-name is mandatory at the t=
op=20
# level and no BlockBackend will be created.=20
#=20
-# Note: This command is still a work in progress. It doesn't support all=
=20
-# block drivers among other things. Stay away from it unless you want=20
-# to help with its development.=20
-#=20
-# Since: 1.7=20
+# Since: 2.9=20
#=20
# Example:=20
#=20
@@ -2957,7 +2953,7 @@=20
{ 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true }=20

##=20
-# @x-blockdev-del:=20
+# @blockdev-del:=20
#=20
# Deletes a block device that has been added using blockdev-add.=20
# The command will fail if the node is attached to a device or is=20
@@ -2969,7 +2965,7 @@=20
# experimental. Stay away from it unless you want to help with its=20
# development.=20
#=20
-# Since: 2.5=20
+# Since: 2.9=20
#=20
# Example:=20
#=20
@@ -2985,13 +2981,13 @@=20
# }=20
# <- { "return": {} }=20
#=20
-# -> { "execute": "x-blockdev-del",=20
+# -> { "execute": "blockdev-del",=20
# "arguments": { "node-name": "node0" }=20
# }=20
# <- { "return": {} }=20
#=20
##=20
-{ 'command': 'x-blockdev-del', 'data': { 'node-name': 'str' } }=20
+{ 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }=20

##=20
# @blockdev-open-tray:=20
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139=20
index 6d98e4f..175d8f0 100644=20
--- a/tests/qemu-iotests/139=20
+++ b/tests/qemu-iotests/139=20
@@ -1,6 +1,6 @@=20
#!/usr/bin/env python=20
#=20
-# Test cases for the QMP 'x-blockdev-del' command=20
+# Test cases for the QMP 'blockdev-del' command=20
#=20
# Copyright (C) 2015 Igalia, S.L.=20
# Author: Alberto Garcia <berto@igalia.com>=20
@@ -79,7 +79,7 @@ class TestBlockdevDel(iotests.QMPTestCase):=20
# Delete a BlockDriverState=20
def delBlockDriverState(self, node, expect_error =3D False):=20
self.checkBlockDriverState(node)=20
- result =3D self.vm.qmp('x-blockdev-del', node_name =3D node)=20
+ result =3D self.vm.qmp('blockdev-del', node_name =3D node)=20
if expect_error:=20
self.assert_qmp(result, 'error/class', 'GenericError')=20
else:=20
@@ -173,7 +173,7 @@ class TestBlockdevDel(iotests.QMPTestCase):=20
self.wait_until_completed(id)=20

# Add a BlkDebug node=20
- # Note that the purpose of this is to test the x-blockdev-del=20
+ # Note that the purpose of this is to test the blockdev-del=20
# sanity checks, not to create a usable blkdebug drive=20
def addBlkDebug(self, debug, node):=20
self.checkBlockDriverState(node, False)=20
@@ -191,7 +191,7 @@ class TestBlockdevDel(iotests.QMPTestCase):=20
self.checkBlockDriverState(debug)=20

# Add a BlkVerify node=20
- # Note that the purpose of this is to test the x-blockdev-del=20
+ # Note that the purpose of this is to test the blockdev-del=20
# sanity checks, not to create a usable blkverify drive=20
def addBlkVerify(self, blkverify, test, raw):=20
self.checkBlockDriverState(test, False)=20
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141=20
index 6d8f0a1..27fb1cc 100755=20
--- a/tests/qemu-iotests/141=20
+++ b/tests/qemu-iotests/141=20
@@ -65,7 +65,7 @@ test_blockjob()=20

# We want this to return an error because the block job is still running=20
_send_qemu_cmd $QEMU_HANDLE \=20
- "{'execute': 'x-blockdev-del',=20
+ "{'execute': 'blockdev-del',=20
'arguments': {'node-name': 'drv0'}}" \=20
'error' | _filter_generated_node_ids=20

@@ -75,7 +75,7 @@ test_blockjob()=20
"$3"=20

_send_qemu_cmd $QEMU_HANDLE \=20
- "{'execute': 'x-blockdev-del',=20
+ "{'execute': 'blockdev-del',=20
'arguments': {'node-name': 'drv0'}}" \=20
'return'=20
}=20
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147=20
index 45469c9..cca75c5 100755=20
--- a/tests/qemu-iotests/147=20
+++ b/tests/qemu-iotests/147=20
@@ -57,7 +57,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):=20
filename)=20
break=20

- result =3D self.vm.qmp('x-blockdev-del', node_name=3D'nbd-blockdev')=20
+ result =3D self.vm.qmp('blockdev-del', node_name=3D'nbd-blockdev')=20
self.assert_qmp(result, 'return', {})=20


--=20
2.7.4=20
