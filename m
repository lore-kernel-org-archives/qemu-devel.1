Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB92C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C224C2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C224C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hft1L-0006B0-38
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41978)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfsro-000089-0W
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfsrm-0004k2-A9
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfsrf-0004DJ-VA; Tue, 25 Jun 2019 17:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCA5681DF0;
 Tue, 25 Jun 2019 21:20:18 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E9A61972B;
 Tue, 25 Jun 2019 21:20:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 25 Jun 2019 23:19:55 +0200
Message-Id: <20190625211955.15664-6-mreitz@redhat.com>
In-Reply-To: <20190625211955.15664-1-mreitz@redhat.com>
References: <20190625211955.15664-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 25 Jun 2019 21:20:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/5] iotests: Test driver whitelisting in 136
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  Skip all test cases that require it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/136 | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index af7ffa4540..4ef95517a1 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -28,9 +28,11 @@ op_latency =3D nsec_per_sec // 1000 # See qtest_latenc=
y_ns in accounting.c
 bad_sector =3D 8192
 bad_offset =3D bad_sector * 512
 blkdebug_file =3D os.path.join(iotests.test_dir, 'blkdebug.conf')
+supported_null_drivers =3D [ f for f in iotests.supported_formats()
+                           if f.startswith('null-') ]
=20
 class BlockDeviceStatsTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     total_rd_bytes =3D 0
     total_rd_ops =3D 0
     total_wr_bytes =3D 0
@@ -68,6 +70,10 @@ sector =3D "%d"
         file.close()
=20
     def setUp(self):
+        global supported_null_drivers
+        if self.test_driver not in supported_null_drivers:
+            self.case_skip('%s support missing' % self.test_driver)
+
         drive_args =3D []
         drive_args.append("stats-intervals.0=3D%d" % interval_length)
         drive_args.append("stats-account-invalid=3D%s" %
@@ -75,8 +81,8 @@ sector =3D "%d"
         drive_args.append("stats-account-failed=3D%s" %
                           (self.account_failed and "on" or "off"))
         self.create_blkdebug_file()
-        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s' %
-                                         (blkdebug_file, self.test_img),
+        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s://' %
+                                         (blkdebug_file, self.test_drive=
r),
                                          ','.join(drive_args))
         self.vm.launch()
         # Set an initial value for the clock
@@ -336,7 +342,9 @@ class BlockDeviceStatsTestAccountBoth(BlockDeviceStat=
sTestCase):
     account_failed =3D True
=20
 class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in supported_null_drivers:
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0


