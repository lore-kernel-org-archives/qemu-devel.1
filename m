Received: from eggs.gnu.org ([209.51.188.92]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7MM-0004g6-C6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7MB-0003oO-Dw
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:28 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 10:45:04 +0200
Message-Id: <20190502084506.8009-6-thuth@redhat.com>
In-Reply-To: <20190502084506.8009-1-thuth@redhat.com>
References: <20190502084506.8009-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/7] tests/qemu-iotests: Remove the
 "_supported_os Linux" line from many tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A lot of tests run fine on FreeBSD and macOS, too - the limitation
to Linux here was likely just copied-and-pasted from other tests.
Thus remove the "_supported_os Linux" line from tests that run
successful in our CI pipelines on FreeBSD and macOS.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/001 | 1 -
 tests/qemu-iotests/002 | 1 -
 tests/qemu-iotests/003 | 1 -
 tests/qemu-iotests/004 | 1 -
 tests/qemu-iotests/007 | 1 -
 tests/qemu-iotests/008 | 1 -
 tests/qemu-iotests/009 | 1 -
 tests/qemu-iotests/010 | 1 -
 tests/qemu-iotests/011 | 1 -
 tests/qemu-iotests/012 | 1 -
 tests/qemu-iotests/015 | 1 -
 tests/qemu-iotests/017 | 1 -
 tests/qemu-iotests/020 | 1 -
 tests/qemu-iotests/021 | 1 -
 tests/qemu-iotests/022 | 1 -
 tests/qemu-iotests/025 | 1 -
 tests/qemu-iotests/026 | 1 -
 tests/qemu-iotests/027 | 1 -
 tests/qemu-iotests/029 | 1 -
 tests/qemu-iotests/031 | 1 -
 tests/qemu-iotests/032 | 1 -
 tests/qemu-iotests/033 | 1 -
 tests/qemu-iotests/035 | 1 -
 tests/qemu-iotests/036 | 1 -
 tests/qemu-iotests/037 | 1 -
 tests/qemu-iotests/042 | 1 -
 tests/qemu-iotests/043 | 1 -
 tests/qemu-iotests/046 | 1 -
 tests/qemu-iotests/047 | 1 -
 tests/qemu-iotests/049 | 1 -
 tests/qemu-iotests/050 | 1 -
 tests/qemu-iotests/051 | 1 -
 tests/qemu-iotests/052 | 1 -
 tests/qemu-iotests/053 | 1 -
 tests/qemu-iotests/054 | 1 -
 tests/qemu-iotests/062 | 1 -
 tests/qemu-iotests/063 | 1 -
 tests/qemu-iotests/066 | 1 -
 tests/qemu-iotests/067 | 1 -
 tests/qemu-iotests/068 | 1 -
 tests/qemu-iotests/069 | 1 -
 tests/qemu-iotests/071 | 1 -
 tests/qemu-iotests/072 | 1 -
 tests/qemu-iotests/073 | 1 -
 tests/qemu-iotests/079 | 1 -
 tests/qemu-iotests/082 | 1 -
 tests/qemu-iotests/085 | 1 -
 tests/qemu-iotests/089 | 1 -
 tests/qemu-iotests/090 | 1 -
 tests/qemu-iotests/094 | 1 -
 tests/qemu-iotests/095 | 1 -
 tests/qemu-iotests/098 | 1 -
 tests/qemu-iotests/102 | 1 -
 tests/qemu-iotests/103 | 1 -
 tests/qemu-iotests/104 | 1 -
 tests/qemu-iotests/105 | 1 -
 tests/qemu-iotests/107 | 1 -
 tests/qemu-iotests/110 | 1 -
 tests/qemu-iotests/111 | 1 -
 tests/qemu-iotests/112 | 1 -
 tests/qemu-iotests/114 | 1 -
 tests/qemu-iotests/115 | 1 -
 tests/qemu-iotests/117 | 1 -
 tests/qemu-iotests/120 | 1 -
 tests/qemu-iotests/125 | 1 -
 tests/qemu-iotests/126 | 1 -
 tests/qemu-iotests/127 | 1 -
 tests/qemu-iotests/133 | 1 -
 tests/qemu-iotests/134 | 1 -
 tests/qemu-iotests/142 | 1 -
 tests/qemu-iotests/143 | 1 -
 tests/qemu-iotests/144 | 1 -
 tests/qemu-iotests/145 | 1 -
 tests/qemu-iotests/153 | 1 -
 tests/qemu-iotests/156 | 1 -
 tests/qemu-iotests/157 | 1 -
 tests/qemu-iotests/158 | 1 -
 tests/qemu-iotests/159 | 1 -
 tests/qemu-iotests/162 | 1 -
 tests/qemu-iotests/170 | 1 -
 tests/qemu-iotests/173 | 1 -
 tests/qemu-iotests/182 | 1 -
 tests/qemu-iotests/183 | 1 -
 tests/qemu-iotests/186 | 1 -
 tests/qemu-iotests/187 | 1 -
 tests/qemu-iotests/190 | 1 -
 tests/qemu-iotests/191 | 1 -
 tests/qemu-iotests/192 | 1 -
 tests/qemu-iotests/195 | 1 -
 tests/qemu-iotests/197 | 1 -
 tests/qemu-iotests/200 | 1 -
 tests/qemu-iotests/214 | 1 -
 tests/qemu-iotests/215 | 1 -
 tests/qemu-iotests/217 | 1 -
 tests/qemu-iotests/227 | 1 -
 tests/qemu-iotests/231 | 1 -
 tests/qemu-iotests/233 | 1 -
 tests/qemu-iotests/240 | 1 -
 tests/qemu-iotests/247 | 1 -
 99 files changed, 99 deletions(-)

diff --git a/tests/qemu-iotests/001 b/tests/qemu-iotests/001
index 5d266e170a..d87a535c33 100755
--- a/tests/qemu-iotests/001
+++ b/tests/qemu-iotests/001
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/002 b/tests/qemu-iotests/002
index 7fb85084a1..fd413bce48 100755
--- a/tests/qemu-iotests/002
+++ b/tests/qemu-iotests/002
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/003 b/tests/qemu-iotests/003
index f008c57cdc..ccd3a39dfb 100755
--- a/tests/qemu-iotests/003
+++ b/tests/qemu-iotests/003
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
 size=3D128M
 offset=3D67M
diff --git a/tests/qemu-iotests/004 b/tests/qemu-iotests/004
index 64fab3e714..d308dc4b49 100755
--- a/tests/qemu-iotests/004
+++ b/tests/qemu-iotests/004
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx luks
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/007 b/tests/qemu-iotests/007
index 3ab5490db3..6abd402423 100755
--- a/tests/qemu-iotests/007
+++ b/tests/qemu-iotests/007
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # currently only qcow2 allows for consistency checks using qemu-img
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 # refcount_bits must be at least 4 so we can create ten internal snapsho=
ts
 # (1 bit supports none, 2 bits support two, 4 bits support 14)
 _unsupported_imgopts 'refcount_bits=3D\(1\|2\)[^0-9]'
diff --git a/tests/qemu-iotests/008 b/tests/qemu-iotests/008
index 75067e36ad..2b81b119bf 100755
--- a/tests/qemu-iotests/008
+++ b/tests/qemu-iotests/008
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/009 b/tests/qemu-iotests/009
index bc4b461122..51b200db1d 100755
--- a/tests/qemu-iotests/009
+++ b/tests/qemu-iotests/009
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/010 b/tests/qemu-iotests/010
index 6920408d28..48c533f632 100755
--- a/tests/qemu-iotests/010
+++ b/tests/qemu-iotests/010
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/011 b/tests/qemu-iotests/011
index b4c7e8f799..8b1fce069a 100755
--- a/tests/qemu-iotests/011
+++ b/tests/qemu-iotests/011
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/012 b/tests/qemu-iotests/012
index 2c3b42d9dd..12957285b3 100755
--- a/tests/qemu-iotests/012
+++ b/tests/qemu-iotests/012
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
=20
 # Remove once all tests are fixed to use TEST_IMG_FILE
 # correctly and common.rc sets it unconditionally
diff --git a/tests/qemu-iotests/015 b/tests/qemu-iotests/015
index 5a4063e4f5..eec5387f3d 100755
--- a/tests/qemu-iotests/015
+++ b/tests/qemu-iotests/015
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # actually any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
=20
diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index 83744f29a3..79875de454 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 TEST_OFFSETS=3D"0 4294967296"
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 71fa753b4e..6b0ebb37d2 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/021 b/tests/qemu-iotests/021
index f6555f3b74..f888269fd4 100755
--- a/tests/qemu-iotests/021
+++ b/tests/qemu-iotests/021
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/022 b/tests/qemu-iotests/022
index b68cd64b33..99eb08f57f 100755
--- a/tests/qemu-iotests/022
+++ b/tests/qemu-iotests/022
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format that supports snapshots
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
 TEST_OFFSETS=3D"10485760 4294967296"
 CLUSTER_SIZE=3D"4096"
diff --git a/tests/qemu-iotests/025 b/tests/qemu-iotests/025
index d9a4ebc5e7..e05d833452 100755
--- a/tests/qemu-iotests/025
+++ b/tests/qemu-iotests/025
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt raw qcow2 qed luks
 _supported_proto file sheepdog rbd nfs
-_supported_os Linux
=20
 echo "=3D=3D=3D Creating image"
 echo
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index ca89ad7048..e30243608b 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Currently only qcow2 supports rebasing
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 _default_cache_mode "writethrough"
 _supported_cache_modes "writethrough" "none"
 # The refcount table tests expect a certain minimum width for refcount e=
ntries
diff --git a/tests/qemu-iotests/027 b/tests/qemu-iotests/027
index b7df9701f7..4cb638022a 100755
--- a/tests/qemu-iotests/027
+++ b/tests/qemu-iotests/027
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt vmdk qcow qcow2 qed
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index 5f42f76cc6..94c2713132 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
=20
diff --git a/tests/qemu-iotests/031 b/tests/qemu-iotests/031
index ef92d8eee3..a3c25ec237 100755
--- a/tests/qemu-iotests/031
+++ b/tests/qemu-iotests/031
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 CLUSTER_SIZE=3D65536
=20
diff --git a/tests/qemu-iotests/032 b/tests/qemu-iotests/032
index a1757bb15e..23c216c549 100755
--- a/tests/qemu-iotests/032
+++ b/tests/qemu-iotests/032
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This works for any image format (though unlikely to segfault for raw)
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
 echo
 echo =3D=3D=3D Prepare image =3D=3D=3D
diff --git a/tests/qemu-iotests/033 b/tests/qemu-iotests/033
index cfdf1ec2ba..362a48c0a0 100755
--- a/tests/qemu-iotests/033
+++ b/tests/qemu-iotests/033
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/035 b/tests/qemu-iotests/035
index 46aa835936..ad6fa3115a 100755
--- a/tests/qemu-iotests/035
+++ b/tests/qemu-iotests/035
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
=20
 size=3D6G
diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 1b56394129..f06ff67408 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -43,7 +43,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 # Only qcow2v3 and later supports feature bits
 IMGOPTS=3D"compat=3D1.1"
diff --git a/tests/qemu-iotests/037 b/tests/qemu-iotests/037
index 0781bebefe..819a2a52d2 100755
--- a/tests/qemu-iotests/037
+++ b/tests/qemu-iotests/037
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index a9a7fc3041..0e85b356b7 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
=20
 echo
 echo "=3D=3D Creating zero size image =3D=3D"
diff --git a/tests/qemu-iotests/043 b/tests/qemu-iotests/043
index 9894b154ec..67cc7e74c2 100755
--- a/tests/qemu-iotests/043
+++ b/tests/qemu-iotests/043
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index 95160bea4c..543355c64f 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 CLUSTER_SIZE=3D64k
 size=3D128M
diff --git a/tests/qemu-iotests/047 b/tests/qemu-iotests/047
index ce81fc6fa7..4528465fb0 100755
--- a/tests/qemu-iotests/047
+++ b/tests/qemu-iotests/047
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
 size=3D128M
=20
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index bc09cd6717..c100d30ed0 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 filter_test_dir()
 {
diff --git a/tests/qemu-iotests/050 b/tests/qemu-iotests/050
index dd7b2c72eb..211fc00797 100755
--- a/tests/qemu-iotests/050
+++ b/tests/qemu-iotests/050
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
=20
 if test "$IMGFMT" =3D qcow2 && test $IMGOPTS =3D ""; then
   IMGOPTS=3Dcompat=3D1.1
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 02ac960da4..a3deb1fcad 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # A compat=3D0.10 image is created in this test which does not support a=
nything
 # other than refcount_bits=3D16
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
diff --git a/tests/qemu-iotests/052 b/tests/qemu-iotests/052
index b3a2dc1143..6e2ecbfe21 100755
--- a/tests/qemu-iotests/052
+++ b/tests/qemu-iotests/052
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
=20
 # Don't do O_DIRECT on tmpfs
 _supported_cache_modes "writeback" "writethrough" "unsafe"
diff --git a/tests/qemu-iotests/053 b/tests/qemu-iotests/053
index 50c62f0f56..e82bb69881 100755
--- a/tests/qemu-iotests/053
+++ b/tests/qemu-iotests/053
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 qcow
 _supported_proto file
-_supported_os Linux
=20
 echo
 echo "=3D=3D Creating single sector image =3D=3D"
diff --git a/tests/qemu-iotests/054 b/tests/qemu-iotests/054
index 0d5e14f847..a8905b60d0 100755
--- a/tests/qemu-iotests/054
+++ b/tests/qemu-iotests/054
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 echo
 echo "creating too large image (1 EB)"
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index ed7400fed2..d5f818fcce 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
 IMGOPTS=3D"compat=3D1.1"
 IMG_SIZE=3D64M
diff --git a/tests/qemu-iotests/063 b/tests/qemu-iotests/063
index 2d5c0ce9fb..fe4892e467 100755
--- a/tests/qemu-iotests/063
+++ b/tests/qemu-iotests/063
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow qcow2 vmdk qed raw
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" \
                      "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse"
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index f480986e35..28f8c98412 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
 # Intentionally create an unaligned image
 IMGOPTS=3D"compat=3D1.1"
diff --git a/tests/qemu-iotests/067 b/tests/qemu-iotests/067
index fda16a6b0d..926c79b37c 100755
--- a/tests/qemu-iotests/067
+++ b/tests/qemu-iotests/067
@@ -32,7 +32,6 @@ status=3D1	# failure is the default!
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # Because anything other than 16 would change the output of query-block
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 881a022107..22f5ca3ba6 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
-_supported_os Linux
=20
 IMGOPTS=3D"compat=3D1.1"
 IMG_SIZE=3D128K
diff --git a/tests/qemu-iotests/069 b/tests/qemu-iotests/069
index 6a8e4aa22e..3974714852 100755
--- a/tests/qemu-iotests/069
+++ b/tests/qemu-iotests/069
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 IMG_SIZE=3D128K
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 7f3e5abd57..1cca9233d0 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/072 b/tests/qemu-iotests/072
index 6f9f247fa5..661b36da2d 100755
--- a/tests/qemu-iotests/072
+++ b/tests/qemu-iotests/072
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt vpc vmdk vhdx vdi qed qcow2 qcow
 _supported_proto file
-_supported_os Linux
=20
 IMG_SIZE=3D64M
=20
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index 990f90acbd..e684b1b780 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
=20
 CLUSTER_SIZE=3D64k
 size=3D128M
diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 1b6594ebef..81f0c21f53 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
=20
 echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
 echo
diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 278511dba4..bbbdf555dc 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
=20
 run_qemu_img()
 {
diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 68cb665987..d40fdab542 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -56,7 +56,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
=20
 # ${1}: unique identifier for the snapshot filename
diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 6609954908..ad029f1f09 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # Because anything other than 16 would change the output of qemu_io -c i=
nfo
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
=20
diff --git a/tests/qemu-iotests/090 b/tests/qemu-iotests/090
index 193bae7d77..9f8cfbb80f 100755
--- a/tests/qemu-iotests/090
+++ b/tests/qemu-iotests/090
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
=20
 IMG_SIZE=3D128K
=20
diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 0bcca77261..9343e09492 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto nbd
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 _make_test_img 64M
diff --git a/tests/qemu-iotests/095 b/tests/qemu-iotests/095
index 18505b7181..58fe174b5e 100755
--- a/tests/qemu-iotests/095
+++ b/tests/qemu-iotests/095
@@ -44,7 +44,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 size_smaller=3D5M
 size_larger=3D100M
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 461144c831..1c1d1c468f 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 IMGOPTS=3D"compat=3D1.1"
=20
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index cedd2b25dc..749ff66b8a 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 IMG_SIZE=3D64K
=20
diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
index 6773e94d9f..554b9de054 100755
--- a/tests/qemu-iotests/103
+++ b/tests/qemu-iotests/103
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
=20
diff --git a/tests/qemu-iotests/104 b/tests/qemu-iotests/104
index 390167bad4..c70f28a9a1 100755
--- a/tests/qemu-iotests/104
+++ b/tests/qemu-iotests/104
@@ -34,7 +34,6 @@ trap "exit \$status" 0 1 2 3 15
=20
 _supported_fmt raw qcow qcow2 qed vdi vmdk vhdx
 _supported_proto generic
-_supported_os Linux
=20
 echo "=3D=3D=3D Check qemu-img info output =3D=3D=3D"
 echo
diff --git a/tests/qemu-iotests/105 b/tests/qemu-iotests/105
index 3b5a596844..3346e8cb25 100755
--- a/tests/qemu-iotests/105
+++ b/tests/qemu-iotests/105
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 vmdk vhdx qed
 _supported_proto generic
-_supported_os Linux
 _unsupported_imgopts "subformat=3DtwoGbMaxExtentFlat" \
                      "subformat=3DtwoGbMaxExtentSparse"
=20
diff --git a/tests/qemu-iotests/107 b/tests/qemu-iotests/107
index fcd5a24dfe..268ba27688 100755
--- a/tests/qemu-iotests/107
+++ b/tests/qemu-iotests/107
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file nfs
-_supported_os Linux
=20
=20
 IMG_SIZE=3D64K
diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..4318341ac5 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 TEST_IMG_REL=3D$(basename "$TEST_IMG")
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 57395be64c..490a5bbcb5 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_supported_os Linux
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 $QEMU_IMG create -f $IMGFMT -b "$TEST_IMG.inexistent" "$TEST_IMG" 2>&1 \
diff --git a/tests/qemu-iotests/112 b/tests/qemu-iotests/112
index 6d81c75a9c..706c10b600 100755
--- a/tests/qemu-iotests/112
+++ b/tests/qemu-iotests/112
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # This test will set refcount_bits on its own which would conflict with =
the
 # manual setting; compat will be overridden as well
 _unsupported_imgopts refcount_bits 'compat=3D0.10'
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index f36b88f3f3..f90a744fc0 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
=20
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
index 7ed347010f..9ed3cb6a83 100755
--- a/tests/qemu-iotests/115
+++ b/tests/qemu-iotests/115
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
 # This test relies on refcounts being 64 bits wide (which does not work =
with
 # compat=3D0.10)
 _unsupported_imgopts 'refcount_bits=3D\([^6]\|.\([^4]\|$\)\)' 'compat=3D=
0.10'
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 0af0f31c5a..f37b34f8b1 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 _make_test_img 64k
=20
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ca95b9276e..e9b4fbb009 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
=20
 _make_test_img 64M
diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 212dcd8f0d..dc4b8f5fb9 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -44,7 +44,6 @@ get_image_size_on_host()
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 if [ -z "$TEST_IMG_FILE" ]; then
     TEST_IMG_FILE=3D$TEST_IMG
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..580fae5d62 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -37,7 +37,6 @@ _supported_fmt qcow qcow2 qed vmdk
 # colons which separate a protocol prefix from the rest and colons which=
 are
 # just part of the filename, so we cannot test protocols which require a=
 prefix)
 _supported_proto file
-_supported_os Linux
=20
 echo
 echo '=3D=3D=3D Testing plain files =3D=3D=3D'
diff --git a/tests/qemu-iotests/127 b/tests/qemu-iotests/127
index 3e941f74d4..b64926ab31 100755
--- a/tests/qemu-iotests/127
+++ b/tests/qemu-iotests/127
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 IMG_SIZE=3D64K
=20
diff --git a/tests/qemu-iotests/133 b/tests/qemu-iotests/133
index 1f6056d144..6f7cacc091 100755
--- a/tests/qemu-iotests/133
+++ b/tests/qemu-iotests/133
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG.base"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index e9e3e84c2a..141a2eaa7e 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index d9b98cf60a..6b62271876 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 # We test all cache modes anyway, but O_DIRECT needs to be supported
 _default_cache_mode none
diff --git a/tests/qemu-iotests/143 b/tests/qemu-iotests/143
index c223867cb3..92249ac8da 100755
--- a/tests/qemu-iotests/143
+++ b/tests/qemu-iotests/143
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
 keep_stderr=3Dy \
 _launch_qemu 2> >(_filter_nbd)
diff --git a/tests/qemu-iotests/144 b/tests/qemu-iotests/144
index 15157f33d7..011ed4f2bc 100755
--- a/tests/qemu-iotests/144
+++ b/tests/qemu-iotests/144
@@ -46,7 +46,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 size=3D512M
=20
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index 28878dc8a1..9427549651 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
 _make_test_img 1M
=20
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 08ad8a6730..c969a1a16f 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -62,7 +62,6 @@ _check_ofd || _notrun "OFD lock not available"
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 _run_cmd()
 {
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 8d134029c6..2ffa3ca942 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -49,7 +49,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
=20
 # Create source disk
 TEST_IMG=3D"$TEST_IMG.backing" _make_test_img 1M
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index 69b25cab30..7cbac38099 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 8c0928a7f9..ba4db6116a 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
-_supported_os Linux
=20
=20
 size=3D128M
diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 29066eebde..2557140ac2 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
=20
 TEST_SIZES=3D"5 512 1024 1999 1K 64K 1M"
diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 2e9947fd9a..4e5ed74fd5 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
=20
 _supported_fmt generic
-_supported_os Linux
=20
 test_ssh=3D$($QEMU_IMG --help | grep '^Supported formats:.* ssh\( \|$\)'=
)
 [ "$test_ssh" =3D "" ] && _notrun "ssh support required"
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 7deb7563c9..05dd6ed6c3 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
 _unsupported_fmt luks
=20
 echo
diff --git a/tests/qemu-iotests/173 b/tests/qemu-iotests/173
index 47036a5564..9e2fa2e73c 100755
--- a/tests/qemu-iotests/173
+++ b/tests/qemu-iotests/173
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto nfs
-_supported_os Linux
=20
 size=3D100M
=20
diff --git a/tests/qemu-iotests/182 b/tests/qemu-iotests/182
index ff3d7e7ec1..fd7627fb65 100755
--- a/tests/qemu-iotests/182
+++ b/tests/qemu-iotests/182
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 size=3D32M
=20
diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 93b7bd798a..fbe5a99beb 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -44,7 +44,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 raw qed quorum
 _supported_proto file
-_supported_os Linux
=20
 size=3D64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index 5dd2177b89..7e7d45babc 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/187 b/tests/qemu-iotests/187
index a45addde09..2fcef9e2bd 100755
--- a/tests/qemu-iotests/187
+++ b/tests/qemu-iotests/187
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 size=3D64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/190 b/tests/qemu-iotests/190
index e1c1d407f0..eb766ad09f 100755
--- a/tests/qemu-iotests/190
+++ b/tests/qemu-iotests/190
@@ -41,7 +41,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # See 178 for more extensive tests across more formats
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 echo "=3D=3D Huge file =3D=3D"
 echo
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index 1ea908ce3d..528022e8d8 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -43,7 +43,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 size=3D64M
=20
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index 158086f9d2..84d1ed7cfa 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
=20
 if [ "$QEMU_DEFAULT_MACHINE" !=3D "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/195 b/tests/qemu-iotests/195
index bd1b71ae5e..ef7b9a94e2 100755
--- a/tests/qemu-iotests/195
+++ b/tests/qemu-iotests/195
@@ -39,7 +39,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
index 2c664793f4..383d7d7f61 100755
--- a/tests/qemu-iotests/197
+++ b/tests/qemu-iotests/197
@@ -51,7 +51,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Test is supported for any backing file; but we force qcow2 for our wra=
pper.
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
=20
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 1c0f8cafc2..72d431f251 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -42,7 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
=20
 BACKING_IMG=3D"${TEST_DIR}/backing.img"
 TEST_IMG=3D"${TEST_DIR}/test.img"
diff --git a/tests/qemu-iotests/214 b/tests/qemu-iotests/214
index c1a452ff9a..21ec8a2ad8 100755
--- a/tests/qemu-iotests/214
+++ b/tests/qemu-iotests/214
@@ -36,7 +36,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 # Repairing the corrupted image requires qemu-img check to store a
 # refcount up to 3, which requires at least two refcount bits.
diff --git a/tests/qemu-iotests/215 b/tests/qemu-iotests/215
index 7b063d7cfa..958c14f5a0 100755
--- a/tests/qemu-iotests/215
+++ b/tests/qemu-iotests/215
@@ -48,7 +48,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Test is supported for any backing file; but we force qcow2 for our wra=
pper.
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
 # LUKS support may be possible, but it complicates things.
 _unsupported_fmt luks
=20
diff --git a/tests/qemu-iotests/217 b/tests/qemu-iotests/217
index f5482bb669..58a78a6098 100755
--- a/tests/qemu-iotests/217
+++ b/tests/qemu-iotests/217
@@ -37,7 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This test is specific to qcow2
 _supported_fmt qcow2
 _supported_proto file
-_supported_os Linux
=20
 # This test needs clusters with at least a refcount of 2 so that
 # OFLAG_COPIED is not set.  refcount_bits=3D1 is therefore unsupported.
diff --git a/tests/qemu-iotests/227 b/tests/qemu-iotests/227
index 10cf144eb0..bdd727a721 100755
--- a/tests/qemu-iotests/227
+++ b/tests/qemu-iotests/227
@@ -38,7 +38,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto file
-_supported_os Linux
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/231 b/tests/qemu-iotests/231
index 5b2cbab9ac..c0b053ac30 100755
--- a/tests/qemu-iotests/231
+++ b/tests/qemu-iotests/231
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt generic
 _supported_proto rbd
-_supported_os Linux
=20
 BOGUS_CONF=3D${TEST_DIR}/ceph-$$.conf
 touch "${BOGUS_CONF}"
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index b8b6c8cc4c..5855f94b9a 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -47,7 +47,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw qcow2
 _supported_proto file
 # If porting to non-Linux, consider using socat instead of ss in common.=
nbd
-_supported_os Linux
 _require_command QEMU_NBD
=20
 nbd_server_set_tcp_port
diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index d3e663ed65..b4cf95096d 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -33,7 +33,6 @@ status=3D1	# failure is the default!
=20
 _supported_fmt generic
 _supported_proto generic
-_supported_os Linux
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/247 b/tests/qemu-iotests/247
index fc50eb5dc1..546a794d3d 100755
--- a/tests/qemu-iotests/247
+++ b/tests/qemu-iotests/247
@@ -40,7 +40,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Requires backing files and .bdrv_change_backing_file support
 _supported_fmt qcow2 qed
 _supported_proto file
-_supported_os Linux
=20
 size=3D128M
=20
--=20
2.21.0
