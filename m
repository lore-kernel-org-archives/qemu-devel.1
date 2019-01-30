Received: from eggs.gnu.org ([209.51.188.92]:39679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjO-0006Fs-55
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjN-0005CD-5G
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:50 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 30 Jan 2019 16:24:25 +0100
Message-Id: <20190130152434.17283-2-mreitz@redhat.com>
In-Reply-To: <20190130152434.17283-1-mreitz@redhat.com>
References: <20190130152434.17283-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/10] iotests: Re-add filename filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

A previous commit removed the default filters for qmp_log with the
intention to make them explicit; but this happened only for test 206.
There are more tests (for more exotic image formats than qcow2) which
require the filename filter, though.

Note that 237 is still broken for Python 2.x, which is fixed in the next
commit.

Fixes: f8ca8609d8549def45b28e82ecac64adaeee9f12
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/210 | 5 +++--
 tests/qemu-iotests/211 | 5 +++--
 tests/qemu-iotests/212 | 5 +++--
 tests/qemu-iotests/213 | 5 +++--
 tests/qemu-iotests/237 | 5 +++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index d142841e2b..565e3b7b9b 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -27,7 +27,8 @@ iotests.verify_image_format(supported_fmts=3D['luks'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -53,7 +54,7 @@ with iotests.FilePath('t.luks') as disk_path, \
                           'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
-               node_name=3D'imgfile')
+               node_name=3D'imgfile', filters=3D[iotests.filter_qmp_test=
files])
=20
     blockdev_create(vm, { 'driver': imgfmt,
                           'file': 'imgfile',
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 7b7985db6c..5d285450b5 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -27,7 +27,8 @@ iotests.verify_image_format(supported_fmts=3D['vdi'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -51,7 +52,7 @@ with iotests.FilePath('t.vdi') as disk_path, \
                           'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
-               node_name=3D'imgfile')
+               node_name=3D'imgfile', filters=3D[iotests.filter_qmp_test=
files])
=20
     blockdev_create(vm, { 'driver': imgfmt,
                           'file': 'imgfile',
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 95c8810d83..42b74f208b 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -27,7 +27,8 @@ iotests.verify_image_format(supported_fmts=3D['parallel=
s'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -51,7 +52,7 @@ with iotests.FilePath('t.parallels') as disk_path, \
                           'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
-               node_name=3D'imgfile')
+               node_name=3D'imgfile', filters=3D[iotests.filter_qmp_test=
files])
=20
     blockdev_create(vm, { 'driver': imgfmt,
                           'file': 'imgfile',
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 4054439e3c..5604f3cebb 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -27,7 +27,8 @@ iotests.verify_image_format(supported_fmts=3D['vhdx'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -51,7 +52,7 @@ with iotests.FilePath('t.vhdx') as disk_path, \
                           'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
-               node_name=3D'imgfile')
+               node_name=3D'imgfile', filters=3D[iotests.filter_qmp_test=
files])
=20
     blockdev_create(vm, { 'driver': imgfmt,
                           'file': 'imgfile',
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 251771d7fb..fe0dd0f461 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -27,7 +27,8 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=3D['vmdk'])
=20
 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
+                        filters=3D[iotests.filter_qmp_testfiles])
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -54,7 +55,7 @@ with iotests.FilePath('t.vmdk') as disk_path, \
                           'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
-               node_name=3D'imgfile')
+               node_name=3D'imgfile', filters=3D[iotests.filter_qmp_test=
files])
=20
     blockdev_create(vm, { 'driver': imgfmt,
                           'file': 'imgfile',
--=20
2.20.1
