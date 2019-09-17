Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09F0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E9521897
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E9521897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9nn-0002iL-NZ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iA9f8-00026B-VV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iA9f7-0004oL-He
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47500)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iA9f4-0004mY-CP; Tue, 17 Sep 2019 05:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EB2E18C891B;
 Tue, 17 Sep 2019 09:20:37 +0000 (UTC)
Received: from localhost (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F159608C2;
 Tue, 17 Sep 2019 09:20:34 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 11:20:03 +0200
Message-Id: <20190917092004.999-7-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-1-mreitz@redhat.com>
References: <20190917092004.999-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 17 Sep 2019 09:20:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 6/7] iotests: Test driver whitelisting in 136
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  Skip all test cases that require it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/136 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index a46a7b7630..012ea111ac 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -30,7 +30,7 @@ bad_offset =3D bad_sector * 512
 blkdebug_file =3D os.path.join(iotests.test_dir, 'blkdebug.conf')
=20
 class BlockDeviceStatsTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     total_rd_bytes =3D 0
     total_rd_ops =3D 0
     total_wr_bytes =3D 0
@@ -67,6 +67,10 @@ sector =3D "%d"
 ''' % (bad_sector, bad_sector))
         file.close()
=20
+    def required_drivers(self):
+        return [self.test_driver]
+
+    @iotests.skip_if_unsupported(required_drivers)
     def setUp(self):
         drive_args =3D []
         drive_args.append("stats-intervals.0=3D%d" % interval_length)
@@ -76,8 +80,8 @@ sector =3D "%d"
                           (self.account_failed and "on" or "off"))
         drive_args.append("file.image.read-zeroes=3Don")
         self.create_blkdebug_file()
-        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s' %
-                                         (blkdebug_file, self.test_img),
+        self.vm =3D iotests.VM().add_drive('blkdebug:%s:%s://' %
+                                         (blkdebug_file, self.test_drive=
r),
                                          ','.join(drive_args))
         self.vm.launch()
         # Set an initial value for the clock
@@ -337,7 +341,9 @@ class BlockDeviceStatsTestAccountBoth(BlockDeviceStat=
sTestCase):
     account_failed =3D True
=20
 class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in iotests.supported_formats():
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0


