Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548E1FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276BA21D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 22:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276BA21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLDu2-0002Oy-4z
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 18:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iLDjq-0007Fz-9W
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iLDjp-0002Yo-3U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 17:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25139)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iLDjm-0002UY-8I; Thu, 17 Oct 2019 17:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4640F30089BA;
 Thu, 17 Oct 2019 21:55:12 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDAD45D9CA;
 Thu, 17 Oct 2019 21:55:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, jsnow@redhat.com,
 qemu-devel@nongnu.org
Subject: [PULL v3 11/19] iotests: add test-case to 165 to test reopening qcow2
 bitmaps to RW
Date: Thu, 17 Oct 2019 17:54:28 -0400
Message-Id: <20191017215436.14252-12-jsnow@redhat.com>
In-Reply-To: <20191017215436.14252-1-jsnow@redhat.com>
References: <20191017215436.14252-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 21:55:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reopening bitmaps to RW was broken prior to previous commit. Check that
it works now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190927122355.7344-4-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/165     | 57 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/165.out |  4 +--
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 5650dc7c87..951ea011a2 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -43,10 +43,10 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         os.remove(disk)
=20
     def mkVm(self):
-        return iotests.VM().add_drive(disk)
+        return iotests.VM().add_drive(disk, opts=3D'node-name=3Dnode0')
=20
     def mkVmRo(self):
-        return iotests.VM().add_drive(disk, opts=3D'readonly=3Don')
+        return iotests.VM().add_drive(disk, opts=3D'readonly=3Don,node-n=
ame=3Dnode0')
=20
     def getSha256(self):
         result =3D self.vm.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -102,6 +102,59 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase)=
:
=20
         self.vm.shutdown()
=20
+    def test_reopen_rw(self):
+        self.vm =3D self.mkVm()
+        self.vm.launch()
+        self.qmpAddBitmap()
+
+        # Calculate hashes
+
+        self.writeRegions(regions1)
+        sha256_1 =3D self.getSha256()
+
+        self.writeRegions(regions2)
+        sha256_2 =3D self.getSha256()
+        assert sha256_1 !=3D sha256_2 # Otherwise, it's not very interes=
ting.
+
+        result =3D self.vm.qmp('block-dirty-bitmap-clear', node=3D'drive=
0',
+                             name=3D'bitmap0')
+        self.assert_qmp(result, 'return', {})
+
+        # Start with regions1
+
+        self.writeRegions(regions1)
+        assert sha256_1 =3D=3D self.getSha256()
+
+        self.vm.shutdown()
+
+        self.vm =3D self.mkVmRo()
+        self.vm.launch()
+
+        assert sha256_1 =3D=3D self.getSha256()
+
+        # Check that we are in RO mode and can't modify bitmap.
+        self.writeRegions(regions2)
+        assert sha256_1 =3D=3D self.getSha256()
+
+        # Reopen to RW
+        result =3D self.vm.qmp('x-blockdev-reopen', **{
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': disk
+            },
+            'read-only': False
+        })
+        self.assert_qmp(result, 'return', {})
+
+        # Check that bitmap is reopened to RW and we can write to it.
+        self.writeRegions(regions2)
+        assert sha256_2 =3D=3D self.getSha256()
+
+        self.vm.shutdown()
+
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/165.out b/tests/qemu-iotests/165.out
index ae1213e6f8..fbc63e62f8 100644
--- a/tests/qemu-iotests/165.out
+++ b/tests/qemu-iotests/165.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
=20
 OK
--=20
2.21.0


