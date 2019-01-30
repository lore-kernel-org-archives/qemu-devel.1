Received: from eggs.gnu.org ([209.51.188.92]:39706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjT-0006Kc-2H
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gorjS-0005Di-Fi
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:24:55 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 30 Jan 2019 16:24:26 +0100
Message-Id: <20190130152434.17283-3-mreitz@redhat.com>
In-Reply-To: <20190130152434.17283-1-mreitz@redhat.com>
References: <20190130152434.17283-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/10] iotests: Fix 237 for Python 2.x
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

math.ceil() returns an integer on Python 3.x, but a float on Python 2.x.
range() always needs integers, so we need an explicit conversion on 2.x
(which does not hurt on 3.x).

It is not quite clear whether we want to support Python 2.x for any
prolonged time, but this may as well be fixed along with the other
issues some iotests have right now.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/237 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index fe0dd0f461..06897f8c87 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -224,7 +224,7 @@ with iotests.FilePath('t.vmdk') as disk_path, \
             iotests.log("=3D %s %d =3D" % (subfmt, size))
             iotests.log("")
=20
-            num_extents =3D math.ceil(size / 2.0**31)
+            num_extents =3D int(math.ceil(size / 2.0**31))
             extents =3D [ "ext%d" % (i) for i in range(1, num_extents + =
1) ]
=20
             vm.launch()
--=20
2.20.1
