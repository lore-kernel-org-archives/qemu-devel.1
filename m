Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE32C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C652064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C652064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hug0p-0007xC-5s
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hufzk-0006Be-Uf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hufzj-0005zx-Qx
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:38:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hufzh-0005xT-J0; Mon, 05 Aug 2019 12:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEDD53083391;
 Mon,  5 Aug 2019 16:37:56 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79B1960C05;
 Mon,  5 Aug 2019 16:37:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 18:37:39 +0200
Message-Id: <20190805163740.23616-7-mreitz@redhat.com>
In-Reply-To: <20190805163740.23616-1-mreitz@redhat.com>
References: <20190805163740.23616-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 05 Aug 2019 16:37:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 6/7] iotests: Test unaligned blocking mirror
 write
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190805113526.20319-1-mreitz@redhat.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/151     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 1bb74d67c4..ad7359fc8d 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -114,6 +114,31 @@ class TestActiveMirror(iotests.QMPTestCase):
     def testActiveIOFlushed(self):
         self.doActiveIO(True)
=20
+    def testUnalignedActiveIO(self):
+        # Fill the source image
+        result =3D self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
+
+        # Start the block job (very slowly)
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             filter_node_name=3D'mirror-node',
+                             device=3D'source-node',
+                             target=3D'target-node',
+                             sync=3D'full',
+                             copy_mode=3D'write-blocking',
+                             buf_size=3D(1048576 // 4),
+                             speed=3D1)
+        self.assert_qmp(result, 'return', {})
+
+        # Start an unaligned request to a dirty area
+        result =3D self.vm.hmp_qemu_io('source', 'write -P 2 %i 1' % (10=
48576 + 42))
+
+        # Let the job finish
+        result =3D self.vm.qmp('block-job-set-speed', device=3D'mirror',=
 speed=3D0)
+        self.assert_qmp(result, 'return', {})
+        self.complete_and_wait(drive=3D'mirror')
+
+        self.potential_writes_in_flight =3D False
=20
=20
 if __name__ =3D=3D '__main__':
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
=20
 OK
--=20
2.21.0


