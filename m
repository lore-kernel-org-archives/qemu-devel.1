Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9Z-0003FI-H0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8A-0007U7-7O
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:08 +0100
Message-Id: <20190311165017.32247-2-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/10] tests/virtio-blk-test: Disable
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
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

tests/virtio-blk-test uses a temporary image file that it deletes while
QEMU is still running, so it can't be reopened when writers are
attached or detached. Disable auto-read-only to keep it always writable.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/virtio-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index b02be0274e..b65365934b 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -751,7 +751,7 @@ static void *virtio_blk_test_setup(GString *cmd_line,=
 void *arg)
     char *tmp_path =3D drive_create();
=20
     g_string_append_printf(cmd_line,
-                           " -drive if=3Dnone,id=3Ddrive0,file=3D%s,form=
at=3Draw "
+                           " -drive if=3Dnone,id=3Ddrive0,file=3D%s,form=
at=3Draw,auto-read-only=3Doff "
                            "-drive if=3Dnone,id=3Ddrive1,file=3Dnull-co:=
//,format=3Draw ",
                            tmp_path);
=20
--=20
2.20.1
