Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5498AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C122215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C122215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFP7M-0007Uw-Jb
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9J-0006KM-MF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9I-0000IF-IM
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9F-0000GU-V2; Tue, 01 Oct 2019 15:49:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F82781DE3;
 Tue,  1 Oct 2019 19:49:25 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8865C219;
 Tue,  1 Oct 2019 19:49:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 55/67] iotests/237: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:03 +0200
Message-Id: <20191001194715.2796-56-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 01 Oct 2019 19:49:25 +0000 (UTC)
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
 tests/qemu-iotests/237     | 11 +++++------
 tests/qemu-iotests/237.out |  6 ------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 34ff4b55db..179eae87dc 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -22,7 +22,7 @@
=20
 import math
 import iotests
-from iotests import imgfmt
+from iotests import imgfmt, create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['vmdk'],
                           # All options are ignored
@@ -38,9 +38,9 @@ def blockdev_create(vm, options):
     iotests.log("")
=20
 with iotests.FilePath('t.vmdk') as disk_path, \
-     iotests.FilePath('t.vmdk.1') as extent1_path, \
-     iotests.FilePath('t.vmdk.2') as extent2_path, \
-     iotests.FilePath('t.vmdk.3') as extent3_path, \
+     iotests.ImagePath('t.vmdk.1') as extent1_path, \
+     iotests.ImagePath('t.vmdk.2') as extent2_path, \
+     iotests.ImagePath('t.vmdk.3') as extent3_path, \
      iotests.VM() as vm:
=20
     #
@@ -175,8 +175,7 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     iotests.log("")
=20
     for path in [ extent1_path, extent2_path, extent3_path ]:
-        msg =3D iotests.qemu_img_pipe('create', '-f', imgfmt, path, '0')
-        iotests.log(msg, [iotests.filter_testfiles])
+        assert create_test_image(path, 0) =3D=3D 0
=20
     vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dext1' % (ex=
tent1_path))
     vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dext2' % (ex=
tent2_path))
diff --git a/tests/qemu-iotests/237.out b/tests/qemu-iotests/237.out
index a8c800bfad..c32b970363 100644
--- a/tests/qemu-iotests/237.out
+++ b/tests/qemu-iotests/237.out
@@ -129,12 +129,6 @@ Job failed: Cannot find device=3Dthis doesn't exist =
nor node_name=3Dthis doesn't exi
=20
 =3D=3D=3D Other subformats =3D=3D=3D
=20
-Formatting 'TEST_DIR/PID-t.vmdk.1', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
-
-Formatting 'TEST_DIR/PID-t.vmdk.2', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
-
-Formatting 'TEST_DIR/PID-t.vmdk.3', fmt=3Dvmdk size=3D0 compat6=3Doff hw=
version=3Dundefined
-
 =3D=3D Missing extent =3D=3D
=20
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options"=
: {"driver": "vmdk", "file": "node0", "size": 33554432, "subformat": "mon=
olithicFlat"}}}
--=20
2.21.0


