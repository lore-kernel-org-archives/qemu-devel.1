Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE1BC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E792B215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 19:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E792B215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4s9R-0008SM-Ea
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 15:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i4s5J-0004aR-1Z
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i4s5H-0007GH-37
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 15:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i4s5C-00079z-NT; Mon, 02 Sep 2019 15:33:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1257A10F23E5;
 Mon,  2 Sep 2019 19:33:46 +0000 (UTC)
Received: from localhost (ovpn-204-221.brq.redhat.com [10.40.204.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24B235C21A;
 Mon,  2 Sep 2019 19:33:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  2 Sep 2019 21:33:20 +0200
Message-Id: <20190902193320.32233-6-mreitz@redhat.com>
In-Reply-To: <20190902193320.32233-1-mreitz@redhat.com>
References: <20190902193320.32233-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 02 Sep 2019 19:33:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/5] iotests: Test blockdev-create for vpc
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/266     | 153 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/266.out | 137 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 291 insertions(+)
 create mode 100755 tests/qemu-iotests/266
 create mode 100644 tests/qemu-iotests/266.out

diff --git a/tests/qemu-iotests/266 b/tests/qemu-iotests/266
new file mode 100755
index 0000000000..5b35cd67e4
--- /dev/null
+++ b/tests/qemu-iotests/266
@@ -0,0 +1,153 @@
+#!/usr/bin/env python
+#
+# Test VPC and file image creation
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import iotests
+from iotests import imgfmt
+
+
+def blockdev_create(vm, options):
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
+
+    if 'return' in result:
+        assert result['return'] =3D=3D {}
+        vm.run_job('job0')
+
+
+# Successful image creation (defaults)
+def implicit_defaults(vm, file_path):
+    iotests.log("=3D=3D=3D Successful image creation (defaults) =3D=3D=3D=
")
+    iotests.log("")
+
+    # 8 heads, 964 cyls/head, 17 secs/cyl
+    # (Close to 64 MB)
+    size =3D 8 * 964 * 17 * 512
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size })
+
+
+# Successful image creation (explicit defaults)
+def explicit_defaults(vm, file_path):
+    iotests.log("=3D=3D=3D Successful image creation (explicit defaults)=
 =3D=3D=3D")
+    iotests.log("")
+
+    # 16 heads, 964 cyls/head, 17 secs/cyl
+    # (Close to 128 MB)
+    size =3D 16 * 964 * 17 * 512
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'subformat': 'dynamic',
+                          'force-size': False })
+
+
+# Successful image creation (non-default options)
+def non_defaults(vm, file_path):
+    iotests.log("=3D=3D=3D Successful image creation (non-default option=
s) =3D=3D=3D")
+    iotests.log("")
+
+    # Not representable in CHS (fine with force-size=3DTrue)
+    size =3D 1048576
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'subformat': 'fixed',
+                          'force-size': True })
+
+
+# Size not representable in CHS with force-size=3DFalse
+def non_chs_size_without_force(vm, file_path):
+    iotests.log("=3D=3D=3D Size not representable in CHS =3D=3D=3D")
+    iotests.log("")
+
+    # Not representable in CHS (will not work with force-size=3DFalse)
+    size =3D 1048576
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'force-size': False })
+
+
+# Zero size
+def zero_size(vm, file_path):
+    iotests.log("=3D=3D=3D Zero size=3D=3D=3D")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 0 })
+
+
+# Maximum CHS size
+def maximum_chs_size(vm, file_path):
+    iotests.log("=3D=3D=3D Maximum CHS size=3D=3D=3D")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 16 * 65535 * 255 * 512 })
+
+
+# Actual maximum size
+def maximum_size(vm, file_path):
+    iotests.log("=3D=3D=3D Actual maximum size=3D=3D=3D")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 0xff000000 * 512,
+                          'force-size': True })
+
+
+def main():
+    for test_func in [implicit_defaults, explicit_defaults, non_defaults=
,
+                      non_chs_size_without_force, zero_size, maximum_chs=
_size,
+                      maximum_size]:
+
+        with iotests.FilePath('t.vpc') as file_path, \
+             iotests.VM() as vm:
+
+            vm.launch()
+
+            iotests.log('--- Creating empty file ---')
+            blockdev_create(vm, { 'driver': 'file',
+                                  'filename': file_path,
+                                  'size': 0 })
+
+            vm.qmp_log('blockdev-add', driver=3D'file', filename=3Dfile_=
path,
+                       node_name=3D'protocol-node',
+                       filters=3D[iotests.filter_qmp_testfiles])
+            iotests.log('')
+
+            print_info =3D test_func(vm, file_path)
+            iotests.log('')
+
+            vm.shutdown()
+            iotests.img_info_log(file_path)
+
+
+iotests.script_main(main,
+                    supported_fmts=3D['vpc'],
+                    supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/266.out b/tests/qemu-iotests/266.out
new file mode 100644
index 0000000000..b11953e81f
--- /dev/null
+++ b/tests/qemu-iotests/266.out
@@ -0,0 +1,137 @@
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Successful image creation (defaults) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "size": 67125248}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 64 MiB (67125248 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Successful image creation (explicit defaults) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "force-size": false, "size":=
 134250496, "subformat": "dynamic"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 128 MiB (134250496 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Successful image creation (non-default options) =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "force-size": true, "size": =
1048576, "subformat": "fixed"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Size not representable in CHS =3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "force-size": false, "size":=
 1048576}}}
+{"return": {}}
+Job failed: The requested image size cannot be represented in CHS geomet=
ry
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+qemu-img: Could not open 'TEST_IMG': File too small for a VHD header
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Zero size=3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 0 B (0 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Maximum CHS size=3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "size": 136899993600}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 127 GiB (136899993600 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": =
"TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=3D=3D=3D Actual maximum size=3D=3D=3D
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vpc", "file": "protocol-node", "force-size": true, "size": =
2190433320960}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.99 TiB (2190433320960 bytes)
+cluster_size: 2097152
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d95d556414..8b96456278 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -274,3 +274,4 @@
 257 rw
 258 rw quick
 262 rw quick migration
+266 rw quick
--=20
2.21.0


