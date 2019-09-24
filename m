Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87067C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D68120665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D68120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmgQ-0001rz-He
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iClun-0004iE-Kn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iClul-0004eg-Ol
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iClua-0004Yr-4D; Tue, 24 Sep 2019 10:35:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C15C8AC6F9;
 Tue, 24 Sep 2019 14:35:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFDB360852;
 Tue, 24 Sep 2019 14:35:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests: Make iotest 223 easier to edit
Date: Tue, 24 Sep 2019 09:35:21 -0500
Message-Id: <20190924143522.22902-2-eblake@redhat.com>
In-Reply-To: <20190924143522.22902-1-eblake@redhat.com>
References: <20190924143522.22902-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 24 Sep 2019 14:35:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: nsoffer@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Log the QMP input to qemu, not just the QMP output.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/223     | 48 +++++++++++++++++++++-----------------
 tests/qemu-iotests/223.out | 40 +++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 2ba3d8124b4f..2bcf922df8c4 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -58,6 +58,12 @@ run_qemu()
                           | _filter_actual_image_size
 }

+qemu_cmd()
+{
+    echo " $1" | _filter_testdir
+    _send_qemu_cmd $QEMU_HANDLE "$@"
+}
+
 echo
 echo "=3D=3D=3D Create partially sparse image, then add dirty bitmaps =3D=
=3D=3D"
 echo
@@ -110,39 +116,39 @@ echo "=3D=3D=3D End dirty bitmaps, and start servin=
g image over NBD =3D=3D=3D"
 echo

 _launch_qemu -object iothread,id=3Dio0 2> >(_filter_nbd)
-
-# Intentionally provoke some errors as well, to check error handling
 silent=3D
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"qmp_capabilities"}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
+
+# Intentionally provoke some errors as well, to check error handling
+qemu_cmd '{"execute":"qmp_capabilities"}' "return"
+qemu_cmd '{"execute":"blockdev-add",
   "arguments":{"driver":"qcow2", "node-name":"n",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-blockdev-set-iothread",
+qemu_cmd '{"execute":"x-blockdev-set-iothread",
   "arguments":{"node-name":"n", "iothread":"io0"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"block-dirty-bitmap-disable",
+qemu_cmd '{"execute":"block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "error" # Attempt add without server
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
+qemu_cmd '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
+qemu_cmd '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
 $QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "bitmap":"b"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"nosuch"}}' "error" # Attempt to export missing =
node
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "error" # Attempt to export same name twi=
ce
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2",
   "bitmap":"b2"}}' "error" # enabled vs. read-only
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2",
   "bitmap":"b3"}}' "error" # Missing bitmap
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+qemu_cmd '{"execute":"nbd-server-add",
   "arguments":{"device":"n", "name":"n2", "writable":true,
   "bitmap":"b2"}}' "return"
 $QEMU_NBD_PROG -L -k "$TEST_DIR/nbd"
@@ -172,15 +178,15 @@ echo
 echo "=3D=3D=3D End qemu NBD server =3D=3D=3D"
 echo

-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+qemu_cmd '{"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+qemu_cmd '{"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+qemu_cmd '{"execute":"nbd-server-remove",
   "arguments":{"name":"n2"}}' "error" # Attempt duplicate clean
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "error" # Ag=
ain
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
+qemu_cmd '{"execute":"nbd-server-stop"}' "return"
+qemu_cmd '{"execute":"nbd-server-stop"}' "error" # Again
+qemu_cmd '{"execute":"quit"}' "return"
 wait=3Dyes _cleanup_qemu

 echo
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 23b34fcd202e..8895ea838cbb 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -24,19 +24,50 @@ wrote 2097152/2097152 bytes at offset 2097152

 =3D=3D=3D End dirty bitmaps, and start serving image over NBD =3D=3D=3D

+ {"execute":"qmp_capabilities"}
 {"return": {}}
+ {"execute":"blockdev-add",
+  "arguments":{"driver":"qcow2", "node-name":"n",
+    "file":{"driver":"file", "filename":"TEST_DIR/t.qcow2"}}}
 {"return": {}}
+ {"execute":"x-blockdev-set-iothread",
+  "arguments":{"node-name":"n", "iothread":"io0"}}
 {"return": {}}
+ {"execute":"block-dirty-bitmap-disable",
+  "arguments":{"node":"n", "name":"b"}}
 {"return": {}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
+ {"execute":"nbd-server-start",
+  "arguments":{"addr":{"type":"unix",
+    "data":{"path":"TEST_DIR/nbd"}}}}
 {"return": {}}
+ {"execute":"nbd-server-start",
+  "arguments":{"addr":{"type":"unix",
+    "data":{"path":"TEST_DIR/nbd1"}}}}
 {"error": {"class": "GenericError", "desc": "NBD server already running"=
}}
 exports available: 0
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n", "bitmap":"b"}}
 {"return": {}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch=
 nor node_name=3Dnosuch"}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2",
+  "bitmap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2",
+  "bitmap":"b3"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
+ {"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2", "writable":true,
+  "bitmap":"b2"}}
 {"return": {}}
 exports available: 2
  export: 'n'
@@ -84,11 +115,20 @@ read 2097152/2097152 bytes at offset 2097152

 =3D=3D=3D End qemu NBD server =3D=3D=3D

+ {"execute":"nbd-server-remove",
+  "arguments":{"name":"n"}}
 {"return": {}}
+ {"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}
 {"return": {}}
+ {"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
+ {"execute":"nbd-server-stop"}
 {"return": {}}
+ {"execute":"nbd-server-stop"}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
+ {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}

--=20
2.21.0


