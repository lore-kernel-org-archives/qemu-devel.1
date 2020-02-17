Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCD8C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2475C2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2475C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hyK-0001E0-7e
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvM-00044A-SW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvK-0007Nz-B1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:47438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvK-0007LD-1X; Mon, 17 Feb 2020 10:03:02 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvF-0007Zt-LG; Mon, 17 Feb 2020 18:02:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/22] qemu-iotests/199: fix style
Date: Mon, 17 Feb 2020 18:02:36 +0300
Message-Id: <20200217150246.29180-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mostly, satisfy pep8 complains.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 40774eed74..de9ba8d94c 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -28,8 +28,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
-class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
+class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         self.vm_a.shutdown()
         self.vm_b.shutdown()
@@ -54,7 +54,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
 
         s = 0
         while s < write_size:
@@ -71,7 +71,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
         s = 0
         while s < write_size:
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
@@ -104,15 +104,16 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
-        result = self.vm_b.qmp('query-block');
+        result = self.vm_b.qmp('query-block')
         while len(result['return'][0]['dirty-bitmaps']) > 1:
             time.sleep(2)
-            result = self.vm_b.qmp('query-block');
+            result = self.vm_b.qmp('query-block')
 
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
 
-        self.assert_qmp(result, 'return/sha256', sha256);
+        self.assert_qmp(result, 'return/sha256', sha256)
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-- 
2.21.0


