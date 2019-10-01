Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B655C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A90C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A90C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPOY-0007QX-CS
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9f-0006g0-Ce
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9d-0000Sa-Rh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9V-0000Nl-Vx; Tue, 01 Oct 2019 15:49:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EAD03308FC4D;
 Tue,  1 Oct 2019 19:49:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 859BC5D6D0;
 Tue,  1 Oct 2019 19:49:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 61/67] iotests/255: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:09 +0200
Message-Id: <20191001194715.2796-62-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 01 Oct 2019 19:49:40 +0000 (UTC)
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
 tests/qemu-iotests/255     | 20 +++++++++-----------
 tests/qemu-iotests/255.out |  8 --------
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index ff16402268..4e745b68fa 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -21,7 +21,7 @@
 #
=20
 import iotests
-from iotests import imgfmt
+from iotests import imgfmt, create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
@@ -39,8 +39,8 @@ iotests.log('Finishing a commit job with background rea=
ds')
 iotests.log('=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'=
)
 iotests.log('')
=20
-with iotests.FilePath('t.qcow2') as disk_path, \
-     iotests.FilePath('t.qcow2.mid') as mid_path, \
+with iotests.ImagePath('t.qcow2') as disk_path, \
+     iotests.ImagePath('t.qcow2.mid') as mid_path, \
      iotests.FilePath('t.qcow2.base') as base_path, \
      iotests.VM() as vm:
=20
@@ -48,11 +48,10 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("")
=20
     size =3D 128 * 1024 * 1024
-    size_str =3D str(size)
=20
     iotests.create_image(base_path, size)
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, mid_path, size_=
str)
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, disk_path, size=
_str)
+    assert create_test_image(mid_path, size) =3D=3D 0
+    assert create_test_image(disk_path, size) =3D=3D 0
=20
     # Create a backing chain like this:
     # base <- [throttled: bps-read=3D4096] <- mid <- overlay
@@ -91,18 +90,17 @@ iotests.log('Closing the VM while a job is being canc=
elled')
 iotests.log('=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
')
 iotests.log('')
=20
-with iotests.FilePath('src.qcow2') as src_path, \
-     iotests.FilePath('dst.qcow2') as dst_path, \
+with iotests.ImagePath('src.qcow2') as src_path, \
+     iotests.ImagePath('dst.qcow2') as dst_path, \
      iotests.VM() as vm:
=20
     iotests.log('=3D=3D=3D Create images and start VM =3D=3D=3D')
     iotests.log('')
=20
     size =3D 128 * 1024 * 1024
-    size_str =3D str(size)
=20
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, src_path, size_=
str)
-    iotests.qemu_img_log('create', '-f', iotests.imgfmt, dst_path, size_=
str)
+    assert create_test_image(src_path, size) =3D=3D 0
+    assert create_test_image(dst_path, size) =3D=3D 0
=20
     iotests.log(iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write 0 1M'=
,
                                 src_path),
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
index 348909fdef..2e837cbb5f 100644
--- a/tests/qemu-iotests/255.out
+++ b/tests/qemu-iotests/255.out
@@ -3,10 +3,6 @@ Finishing a commit job with background reads
=20
 =3D=3D=3D Create backing chain and start VM =3D=3D=3D
=20
-Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728 clus=
ter_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-
-Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-
 =3D=3D=3D Start background read requests =3D=3D=3D
=20
 =3D=3D=3D Run a commit job =3D=3D=3D
@@ -23,10 +19,6 @@ Closing the VM while a job is being cancelled
=20
 =3D=3D=3D Create images and start VM =3D=3D=3D
=20
-Formatting 'TEST_DIR/PID-src.qcow2', fmt=3Dqcow2 size=3D134217728 cluste=
r_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-
-Formatting 'TEST_DIR/PID-dst.qcow2', fmt=3Dqcow2 size=3D134217728 cluste=
r_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
-
 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
--=20
2.21.0


