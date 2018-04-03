Received: from eggs.gnu.org ([2001:4830:134:3::10]:55415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot6-0006sB-GU
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Ot5-0006dq-LP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 12:34:24 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  3 Apr 2018 18:33:59 +0200
Message-Id: <20180403163400.6307-9-kwolf@redhat.com>
In-Reply-To: <20180403163400.6307-1-kwolf@redhat.com>
References: <20180403163400.6307-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] qemu-iotests: Use ppc64 qemu_arch on
 ppc64le host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

The qemu target does not always correspond to the host machine type. For
example ppc64le machine target is ppc64. Let's introduce "qemu_arch"
variable to store the matching qemu architecture related to the current
architecture and use it when auto-detecting the default qemu binary.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Message-id: 20180329112053.5399-2-ldoktor@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/check         | 4 ++--
 tests/qemu-iotests/common.config | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index ec8033350d..aa94c6c7ea 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -538,8 +538,8 @@ if [ -z "$QEMU_PROG" ]
 then
     if [ -x "$build_iotests/qemu" ]; then
         export QEMU_PROG=3D"$build_iotests/qemu"
-    elif [ -x "$build_root/$arch-softmmu/qemu-system-$arch" ]; then
-        export QEMU_PROG=3D"$build_root/$arch-softmmu/qemu-system-$arch"
+    elif [ -x "$build_root/${qemu_arch}-softmmu/qemu-system-${qemu_arch}=
" ]; then
+        export QEMU_PROG=3D"$build_root/${qemu_arch}-softmmu/qemu-system=
-${qemu_arch}"
     else
         pushd "$build_root" > /dev/null
         for binary in *-softmmu/qemu-system-*
diff --git a/tests/qemu-iotests/common.config b/tests/qemu-iotests/common=
.config
index cdcda54546..102aa6878a 100644
--- a/tests/qemu-iotests/common.config
+++ b/tests/qemu-iotests/common.config
@@ -23,6 +23,7 @@ PATH=3D".:$PATH"
=20
 HOSTOS=3D`uname -s`
 arch=3D`uname -m`
+[[ "$arch" =3D~ "ppc64" ]] && qemu_arch=3Dppc64 || qemu_arch=3D"$arch"
=20
 export PWD=3D`pwd`
=20
--=20
2.13.6
