Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D79BECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6262F2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6262F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOYt-0003ZJ-31
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7q-0004dI-20
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7o-0007tf-B8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7j-0007nP-I1; Tue, 01 Oct 2019 15:47:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A10373018FC5;
 Tue,  1 Oct 2019 19:47:50 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D78B6012C;
 Tue,  1 Oct 2019 19:47:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 14/67] iotests: Use unsupported_imgopts in Python tests
Date: Tue,  1 Oct 2019 21:46:22 +0200
Message-Id: <20191001194715.2796-15-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 01 Oct 2019 19:47:50 +0000 (UTC)
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

Set unsupported_imgopts as appropriate for all tests that should make
use of it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/044 | 5 ++++-
 tests/qemu-iotests/057 | 4 +++-
 tests/qemu-iotests/065 | 4 +++-
 tests/qemu-iotests/163 | 5 ++++-
 tests/qemu-iotests/165 | 4 +++-
 tests/qemu-iotests/196 | 4 +++-
 tests/qemu-iotests/206 | 5 ++++-
 tests/qemu-iotests/222 | 3 ++-
 tests/qemu-iotests/237 | 4 +++-
 tests/qemu-iotests/242 | 4 +++-
 tests/qemu-iotests/245 | 4 +++-
 tests/qemu-iotests/246 | 5 ++++-
 tests/qemu-iotests/248 | 6 +++++-
 tests/qemu-iotests/254 | 4 +++-
 tests/qemu-iotests/257 | 4 +++-
 15 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 8b2afa2a11..97ba98e628 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -116,4 +116,7 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # These refcount calculations do not work with data_fil=
e or
+                 # with any refcount width but the default (of 16)
+                 unsupported_imgopts=3D['data_file', 'refcount_bits'])
diff --git a/tests/qemu-iotests/057 b/tests/qemu-iotests/057
index 9fbba759b6..f5aa5929dc 100755
--- a/tests/qemu-iotests/057
+++ b/tests/qemu-iotests/057
@@ -257,4 +257,6 @@ class TestSnapshotDelete(ImageSnapshotTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # Snapshots do not work with data_file
+                 unsupported_imgopts=3D['data_file'])
diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 5b21eb96bd..9db9552784 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -130,4 +130,6 @@ TestQMP =3D None
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # Neither of these options would work with compat=3D0.1=
0
+                 unsupported_imgopts=3D['refcount_bits', 'data_file'])
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index d94728e080..92633f1b21 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -168,4 +168,7 @@ ShrinkBaseClass =3D None
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['raw', 'qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # We want to set our own refcount_bits, and that will
+                 # not work with compat=3D0.10
+                 unsupported_imgopts=3D['refcount_bits', 'compat=3D0.10'=
])
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 5650dc7c87..97dd7102c3 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -104,4 +104,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # compat=3D1.1 is needed for dirty bitmaps
+                 unsupported_imgopts=3D['compat=3D0.10'])
diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
index 92fe9244f8..ec4852a19c 100755
--- a/tests/qemu-iotests/196
+++ b/tests/qemu-iotests/196
@@ -64,4 +64,6 @@ class TestInvalidateAutoclear(iotests.QMPTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 # compat=3D1.1 is needed for autoclear flags
+                 unsupported_imgopts=3D['compat=3D0.10'])
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 23ff2f624b..91dd6ee176 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -23,7 +23,10 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          # All options are ignored
+                          unsupported_imgopts=3D['compat=3D0.10', 'refco=
unt_bits',
+                                               'data_file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create',
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 6788979ed3..ffa88d4bb9 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -25,7 +25,8 @@ import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
=20
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k',
-                                          'vhdx', 'raw'])
+                                          'vhdx', 'raw'],
+                          unsupported_imgopts=3D['streamOptimized'])
=20
 patterns =3D [("0x5d", "0",         "64k"),
             ("0xd5", "1M",        "64k"),
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 3758ace0bc..34ff4b55db 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -24,7 +24,9 @@ import math
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['vmdk'])
+iotests.script_initialize(supported_fmts=3D['vmdk'],
+                          # All options are ignored
+                          unsupported_imgopts=3D['subformat'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 21f69a0d2c..333fb8b56c 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -24,7 +24,9 @@ import struct
 from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
     file_path, img_info_log, log, filter_qemu_io
=20
-iotests.script_initialize(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          # compat=3D1.1 is needed for dirty bitmaps
+                          unsupported_imgopts=3D['compat=3D0.10'])
=20
 disk =3D file_path('disk')
 chunk =3D 256 * 1024
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 50544a7836..72ab2a248d 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1002,4 +1002,6 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 if __name__ =3D=3D '__main__':
     iotests.activate_logging()
     iotests.main(supported_fmts=3D["qcow2"],
-                 supported_protocols=3D["file"])
+                 supported_protocols=3D["file"],
+                 # reopen options differ with an external data file
+                 unsupported_imgopts=3D['data_file'])
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index 1d7747d62d..d1364d5901 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -22,7 +22,10 @@
 import iotests
 from iotests import log
=20
-iotests.script_initialize(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          # compat=3D1.1 is needed for dirty bitmaps
+                          unsupported_imgopts=3D['compat=3D0.10'])
+
 size =3D 64 * 1024 * 1024 * 1024
 gran_small =3D 32 * 1024
 gran_large =3D 128 * 1024
diff --git a/tests/qemu-iotests/248 b/tests/qemu-iotests/248
index 781b21b227..0adc4da802 100755
--- a/tests/qemu-iotests/248
+++ b/tests/qemu-iotests/248
@@ -21,7 +21,11 @@
 import iotests
 from iotests import qemu_img_create, qemu_io, file_path, filter_qmp_test=
files
=20
-iotests.script_initialize(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          # With an external data file, we would need
+                          # to impose the limit on @data-file instead
+                          # of @file
+                          unsupported_imgopts=3D['data_file'])
=20
 source, target =3D file_path('source', 'target')
 size =3D 5 * 1024 * 1024
diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 43b40f4f71..0404faf853 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -21,7 +21,9 @@
 import iotests
 from iotests import qemu_img_create, file_path, log
=20
-iotests.script_initialize(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          # compat=3D1.1 is needed for dirty bitmaps
+                          unsupported_imgopts=3D['compat=3D0.10'])
=20
 disk, top =3D file_path('disk', 'top')
 size =3D 1024 * 1024
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index de8b45f094..82c10e9b52 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -526,4 +526,6 @@ def main():
=20
 if __name__ =3D=3D '__main__':
     iotests.script_main(main, supported_fmts=3D['qcow2'],
-                        supported_protocols=3D['file'])
+                        supported_protocols=3D['file'],
+                        # blkdebug does not work with an external data f=
ile
+                        unsupported_imgopts=3D['data_file'])
--=20
2.21.0


