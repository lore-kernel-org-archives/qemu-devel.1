Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0545C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81F6206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81F6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCrY-0006RB-7u
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36049)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htCq5-00051Q-Ub
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htCq4-0000gE-6c
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htCq1-0000ab-6g; Thu, 01 Aug 2019 11:17:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A1FF3086211;
 Thu,  1 Aug 2019 15:17:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B96E5D712;
 Thu,  1 Aug 2019 15:17:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  1 Aug 2019 17:17:42 +0200
Message-Id: <20190801151744.798-2-kwolf@redhat.com>
In-Reply-To: <20190801151744.798-1-kwolf@redhat.com>
References: <20190801151744.798-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 01 Aug 2019 15:17:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/3] iotests: Move migration helpers to
 iotests.py
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

234 implements functions that are useful for doing migration between two
VMs. Move them to iotests.py so that other test cases can use them, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/234        | 30 +++++++-----------------------
 tests/qemu-iotests/iotests.py | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index c4c26bc21e..34c818c485 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -26,22 +26,6 @@ import os
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 iotests.verify_platform(['linux'])
=20
-def enable_migration_events(vm, name):
-    iotests.log('Enabling migration QMP events on %s...' % name)
-    iotests.log(vm.qmp('migrate-set-capabilities', capabilities=3D[
-        {
-            'capability': 'events',
-            'state': True
-        }
-    ]))
-
-def wait_migration(vm):
-    while True:
-        event =3D vm.event_wait('MIGRATION')
-        iotests.log(event, filters=3D[iotests.filter_qmp_event])
-        if event['data']['status'] =3D=3D 'completed':
-            break
-
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('backing') as backing_path, \
      iotests.FilePath('mig_fifo_a') as fifo_a, \
@@ -62,7 +46,7 @@ with iotests.FilePath('img') as img_path, \
          .add_blockdev('%s,file=3Ddrive0-backing-file,node-name=3Ddrive0=
-backing' % (iotests.imgfmt))
          .launch())
=20
-    enable_migration_events(vm_a, 'A')
+    vm_a.enable_migration_events('A')
=20
     iotests.log('Launching destination VM...')
     (vm_b.add_blockdev('file,filename=3D%s,node-name=3Ddrive0-file' % (i=
mg_path))
@@ -72,7 +56,7 @@ with iotests.FilePath('img') as img_path, \
          .add_incoming("exec: cat '%s'" % (fifo_a))
          .launch())
=20
-    enable_migration_events(vm_b, 'B')
+    vm_b.enable_migration_events('B')
=20
     # Add a child node that was created after the parent node. The rever=
se case
     # is covered by the -blockdev options above.
@@ -85,9 +69,9 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_a.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_a)))
     with iotests.Timeout(3, 'Migration does not complete'):
         # Wait for the source first (which includes setup=3Dsetup)
-        wait_migration(vm_a)
+        vm_a.wait_migration()
         # Wait for the destination second (which does not)
-        wait_migration(vm_b)
+        vm_b.wait_migration()
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
@@ -105,7 +89,7 @@ with iotests.FilePath('img') as img_path, \
          .add_incoming("exec: cat '%s'" % (fifo_b))
          .launch())
=20
-    enable_migration_events(vm_a, 'A')
+    vm_a.enable_migration_events('A')
=20
     iotests.log(vm_a.qmp('blockdev-snapshot', node=3D'drive0-backing',
                          overlay=3D'drive0'))
@@ -114,9 +98,9 @@ with iotests.FilePath('img') as img_path, \
     iotests.log(vm_b.qmp('migrate', uri=3D'exec:cat >%s' % (fifo_b)))
     with iotests.Timeout(3, 'Migration does not complete'):
         # Wait for the source first (which includes setup=3Dsetup)
-        wait_migration(vm_b)
+        vm_b.wait_migration()
         # Wait for the destination second (which does not)
-        wait_migration(vm_a)
+        vm_a.wait_migration()
=20
     iotests.log(vm_a.qmp('query-migrate')['return']['status'])
     iotests.log(vm_b.qmp('query-migrate')['return']['status'])
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index ce74177ab1..91172c39a5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -583,6 +583,22 @@ class VM(qtest.QEMUQtestMachine):
             elif status =3D=3D 'null':
                 return error
=20
+    def enable_migration_events(self, name):
+        log('Enabling migration QMP events on %s...' % name)
+        log(self.qmp('migrate-set-capabilities', capabilities=3D[
+            {
+                'capability': 'events',
+                'state': True
+            }
+        ]))
+
+    def wait_migration(self):
+        while True:
+            event =3D self.event_wait('MIGRATION')
+            log(event, filters=3D[filter_qmp_event])
+            if event['data']['status'] =3D=3D 'completed':
+                break
+
     def node_info(self, node_name):
         nodes =3D self.qmp('query-named-block-nodes')
         for x in nodes['return']:
--=20
2.20.1


