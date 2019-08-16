Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD46C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139E02086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139E02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYg1-0002Nm-5X
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdJ-0008IA-IQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdI-0003ZU-3E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdF-0003Vz-8h; Fri, 16 Aug 2019 05:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C80F86D;
 Fri, 16 Aug 2019 09:34:48 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 849D55C1D6;
 Fri, 16 Aug 2019 09:34:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:27 +0200
Message-Id: <20190816093439.14262-5-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 16 Aug 2019 09:34:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/16] iotests: Move migration helpers to
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

234 implements functions that are useful for doing migration between two
VMs. Move them to iotests.py so that other test cases can use them, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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


