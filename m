Received: from eggs.gnu.org ([209.51.188.92]:42573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZa-0005TN-Cf
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZZ-0000o5-L9
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 16:37:50 +0100
Message-Id: <20190308153757.25794-2-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/8] tests/virtio-blk-test: Disable
 auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

tests/virtio-blk-test uses a temporary image file that it deletes while
QEMU is still running, so it can't be reopened when writers are
attached or detached. Disable auto-read-only to keep it always writable.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/virtio-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 8d2fc9c710..0e464aeea4 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -72,7 +72,7 @@ static QOSState *pci_test_start(void)
     QOSState *qs;
     const char *arch =3D qtest_get_arch();
     char *tmp_path;
-    const char *cmd =3D "-drive if=3Dnone,id=3Ddrive0,file=3D%s,format=3D=
raw "
+    const char *cmd =3D "-drive if=3Dnone,id=3Ddrive0,file=3D%s,format=3D=
raw,auto-read-only=3Doff "
                       "-drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,fo=
rmat=3Draw "
                       "-device virtio-blk-pci,id=3Ddrv0,drive=3Ddrive0,"
                       "addr=3D%x.%x";
--=20
2.20.1
