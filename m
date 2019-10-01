Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B22ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 970522168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970522168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPPo-0000B2-BD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9U-0006St-1d
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9S-0000MX-Re
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9M-0000Jo-Tk; Tue, 01 Oct 2019 15:49:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD9A7C0546D5;
 Tue,  1 Oct 2019 19:49:31 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63E0A5C224;
 Tue,  1 Oct 2019 19:49:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 57/67] iotests/245: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:05 +0200
Message-Id: <20191001194715.2796-58-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 01 Oct 2019 19:49:31 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/245 | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 72ab2a248d..af6bc40575 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -24,7 +24,7 @@ import re
 import iotests
 import copy
 import json
-from iotests import qemu_img, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_io
=20
 hd_path =3D [
     os.path.join(iotests.test_dir, 'hd0.img'),
@@ -43,9 +43,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     total_io_cmds =3D 0
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, hd_path[0], '3M')
-        qemu_img('create', '-f', iotests.imgfmt, '-b', hd_path[0], hd_pa=
th[1])
-        qemu_img('create', '-f', iotests.imgfmt, hd_path[2], '3M')
+        create_test_image(hd_path[0], '3M')
+        create_test_image(hd_path[1], backing_file=3Dhd_path[0])
+        create_test_image(hd_path[2], '3M')
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa0  0 1M', hd_pa=
th[0])
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa1 1M 1M', hd_pa=
th[1])
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xa2 2M 1M', hd_pa=
th[2])
@@ -55,9 +55,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def tearDown(self):
         self.vm.shutdown()
         self.check_qemu_io_errors()
-        os.remove(hd_path[0])
-        os.remove(hd_path[1])
-        os.remove(hd_path[2])
+        remove_test_image(hd_path[0])
+        remove_test_image(hd_path[1])
+        remove_test_image(hd_path[2])
=20
     # The output of qemu-io is not returned by vm.hmp_qemu_io() but
     # it's stored in the log and can only be read when the VM has been
@@ -328,7 +328,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
         # First we create a 2MB raw file, and fill each half with a
         # different value
-        qemu_img('create', '-f', 'raw', hd_path[0], '2M')
+        remove_test_image(hd_path[0])
+        create_test_image(hd_path[0], '2M', fmt=3D'raw')
         qemu_io('-f', 'raw', '-c', 'write -P 0xa0  0 1M', hd_path[0])
         qemu_io('-f', 'raw', '-c', 'write -P 0xa1 1M 1M', hd_path[0])
=20
--=20
2.21.0


