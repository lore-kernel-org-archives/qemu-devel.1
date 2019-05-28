Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D61C04AB6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548F221670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 00:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548F221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVm3X-0000dF-Kt
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 20:02:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVlzp-0006Wh-IY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 19:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hVlzo-0001Uw-AA
	for qemu-devel@nongnu.org; Tue, 28 May 2019 19:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hVlzg-0001IM-Eo; Tue, 28 May 2019 19:59:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E109301988B;
	Tue, 28 May 2019 23:58:59 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F07201715C;
	Tue, 28 May 2019 23:58:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 19:58:42 -0400
Message-Id: <20190528235842.29453-4-jsnow@redhat.com>
In-Reply-To: <20190528235842.29453-1-jsnow@redhat.com>
References: <20190528235842.29453-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 28 May 2019 23:58:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/3] iotests: test external snapshot with bitmap
 copying
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	jsnow@redhat.com, qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This test shows that external snapshots and incremental backups are
friends.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20190517152111.206494-3-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/254     | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/254.out | 52 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 105 insertions(+)
 create mode 100755 tests/qemu-iotests/254
 create mode 100644 tests/qemu-iotests/254.out

diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
new file mode 100755
index 0000000000..33cb80a512
--- /dev/null
+++ b/tests/qemu-iotests/254
@@ -0,0 +1,52 @@
+#!/usr/bin/env python
+#
+# Test external snapshot with bitmap copying.
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
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
+from iotests import qemu_img_create, file_path, log
+
+disk, top =3D file_path('disk', 'top')
+size =3D 1024 * 1024
+
+qemu_img_create('-f', iotests.imgfmt, disk, str(size))
+
+vm =3D iotests.VM().add_drive(disk, opts=3D'node-name=3Dbase')
+vm.launch()
+
+vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3D'bitmap0')
+
+vm.hmp_qemu_io('drive0', 'write 0 512K')
+
+vm.qmp_log('transaction', indent=3D2, actions=3D[
+    {'type': 'blockdev-snapshot-sync',
+     'data': {'device': 'drive0', 'snapshot-file': top,
+              'snapshot-node-name': 'snap'}},
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap0'}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap0',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}}
+], filters=3D[iotests.filter_qmp_testfiles])
+
+result =3D vm.qmp('query-block')['return'][0]
+log("query-block: device =3D {}, node-name =3D {}, dirty-bitmaps:".forma=
t(
+    result['device'], result['inserted']['node-name']))
+log(result['dirty-bitmaps'], indent=3D2)
+
+vm.shutdown()
diff --git a/tests/qemu-iotests/254.out b/tests/qemu-iotests/254.out
new file mode 100644
index 0000000000..d7394cf002
--- /dev/null
+++ b/tests/qemu-iotests/254.out
@@ -0,0 +1,52 @@
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "=
node": "drive0"}}
+{"return": {}}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "device": "drive0",
+          "snapshot-file": "TEST_DIR/PID-top",
+          "snapshot-node-name": "snap"
+        },
+        "type": "blockdev-snapshot-sync"
+      },
+      {
+        "data": {
+          "name": "bitmap0",
+          "node": "snap"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap0",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap0"
+        },
+        "type": "block-dirty-bitmap-merge"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+query-block: device =3D drive0, node-name =3D snap, dirty-bitmaps:
+[
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap0",
+    "persistent": false,
+    "recording": true,
+    "status": "active"
+  }
+]
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2c74deec00..859c4b5e9f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -264,3 +264,4 @@
 249 rw auto quick
 252 rw auto backing quick
 253 rw auto quick
+254 rw auto backing quick
--=20
2.20.1


