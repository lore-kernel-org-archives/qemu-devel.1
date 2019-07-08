Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F08C606D1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F7A2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 22:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F7A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkbnE-0003f0-TY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 18:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44088)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hkblG-00025i-Cd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hkblF-0003m7-1W
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 18:05:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hkbl8-0003f6-8v; Mon, 08 Jul 2019 18:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9E4B7FDEC;
 Mon,  8 Jul 2019 22:05:13 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 990091001B01;
 Mon,  8 Jul 2019 22:05:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 18:05:02 -0400
Message-Id: <20190708220502.12977-4-jsnow@redhat.com>
In-Reply-To: <20190708220502.12977-1-jsnow@redhat.com>
References: <20190708220502.12977-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 08 Jul 2019 22:05:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/3] iotests: test bitmap moving inside 254
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Test persistent bitmap copying with and without removal of original
bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/254     | 30 +++++++++++++-
 tests/qemu-iotests/254.out | 82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 8edba91c5d..9a57bccc26 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -1,6 +1,6 @@
 #!/usr/bin/env python
 #
-# Test external snapshot with bitmap copying.
+# Test external snapshot with bitmap copying and moving.
 #
 # Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
 #
@@ -32,6 +32,10 @@ vm =3D iotests.VM().add_drive(disk, opts=3D'node-name=3D=
base')
 vm.launch()
=20
 vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3D'bitmap0')
+vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3D'bitmap1',
+           persistent=3DTrue)
+vm.qmp_log('block-dirty-bitmap-add', node=3D'drive0', name=3D'bitmap2',
+           persistent=3DTrue)
=20
 vm.hmp_qemu_io('drive0', 'write 0 512K')
=20
@@ -39,16 +43,38 @@ vm.qmp_log('transaction', indent=3D2, actions=3D[
     {'type': 'blockdev-snapshot-sync',
      'data': {'device': 'drive0', 'snapshot-file': top,
               'snapshot-node-name': 'snap'}},
+
+    # copy non-persistent bitmap0
     {'type': 'block-dirty-bitmap-add',
      'data': {'node': 'snap', 'name': 'bitmap0'}},
     {'type': 'block-dirty-bitmap-merge',
      'data': {'node': 'snap', 'target': 'bitmap0',
-              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}}
+              'bitmaps': [{'node': 'base', 'name': 'bitmap0'}]}},
+
+    # copy persistent bitmap1, original will be saved to base image
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap1', 'persistent': True}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap1',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap1'}]}},
+
+    # move persistent bitmap1, original will be removed and not saved
+    # to base image
+    {'type': 'block-dirty-bitmap-add',
+     'data': {'node': 'snap', 'name': 'bitmap2', 'persistent': True}},
+    {'type': 'block-dirty-bitmap-merge',
+     'data': {'node': 'snap', 'target': 'bitmap2',
+              'bitmaps': [{'node': 'base', 'name': 'bitmap2'}]}},
+    {'type': 'block-dirty-bitmap-remove',
+     'data': {'node': 'base', 'name': 'bitmap2'}}
 ], filters=3D[iotests.filter_qmp_testfiles])
=20
 result =3D vm.qmp('query-block')['return'][0]
 log("query-block: device =3D {}, node-name =3D {}, dirty-bitmaps:".forma=
t(
     result['device'], result['inserted']['node-name']))
 log(result['dirty-bitmaps'], indent=3D2)
+log("\nbitmaps in backing image:")
+log(result['inserted']['image']['backing-image']['format-specific'] \
+    ['data']['bitmaps'], indent=3D2)
=20
 vm.shutdown()
diff --git a/tests/qemu-iotests/254.out b/tests/qemu-iotests/254.out
index d7394cf002..d185c0532f 100644
--- a/tests/qemu-iotests/254.out
+++ b/tests/qemu-iotests/254.out
@@ -1,5 +1,9 @@
 {"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap0", "=
node": "drive0"}}
 {"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap1", "=
node": "drive0", "persistent": true}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap2", "=
node": "drive0", "persistent": true}}
+{"return": {}}
 {
   "execute": "transaction",
   "arguments": {
@@ -31,6 +35,55 @@
           "target": "bitmap0"
         },
         "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap1",
+          "node": "snap",
+          "persistent": true
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap1",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap1"
+        },
+        "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap2",
+          "node": "snap",
+          "persistent": true
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "bitmaps": [
+            {
+              "name": "bitmap2",
+              "node": "base"
+            }
+          ],
+          "node": "snap",
+          "target": "bitmap2"
+        },
+        "type": "block-dirty-bitmap-merge"
+      },
+      {
+        "data": {
+          "name": "bitmap2",
+          "node": "base"
+        },
+        "type": "block-dirty-bitmap-remove"
       }
     ]
   }
@@ -40,6 +93,24 @@
 }
 query-block: device =3D drive0, node-name =3D snap, dirty-bitmaps:
 [
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap2",
+    "persistent": true,
+    "recording": true,
+    "status": "active"
+  },
+  {
+    "busy": false,
+    "count": 524288,
+    "granularity": 65536,
+    "name": "bitmap1",
+    "persistent": true,
+    "recording": true,
+    "status": "active"
+  },
   {
     "busy": false,
     "count": 524288,
@@ -50,3 +121,14 @@ query-block: device =3D drive0, node-name =3D snap, d=
irty-bitmaps:
     "status": "active"
   }
 ]
+
+bitmaps in backing image:
+[
+  {
+    "flags": [
+      "auto"
+    ],
+    "granularity": 65536,
+    "name": "bitmap1"
+  }
+]
--=20
2.21.0


