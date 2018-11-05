Received: from eggs.gnu.org ([2001:4830:134:3::10]:51813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwh-0002uK-EZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwZ-0004At-Dt
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:36 +0100
Message-Id: <20181105163744.25139-29-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 28/36] block: Make auto-read-only=on default for
 -drive
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

While we want machine interfaces like -blockdev and QMP blockdev-add to
add as little auto-detection as possible so that management tools are
explicit about their needs, -drive is a convenience option for human
users. Enabling auto-read-only=3Don by default there enables users to use
read-only images for read-only guest devices without having to specify
read-only=3Don explicitly. If they try to attach the image to a read-writ=
e
device, they will still get an error message.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/blockdev.c b/blockdev.c
index fc8794862f..e5b5eb46e2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -590,6 +590,7 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
         qdict_set_default_str(bs_opts, BDRV_OPT_CACHE_NO_FLUSH, "off");
         qdict_set_default_str(bs_opts, BDRV_OPT_READ_ONLY,
                               read_only ? "on" : "off");
+        qdict_set_default_str(bs_opts, BDRV_OPT_AUTO_READ_ONLY, "on");
         assert((bdrv_flags & BDRV_O_CACHE_MASK) =3D=3D 0);
=20
         if (runstate_check(RUN_STATE_INMIGRATE)) {
--=20
2.19.1
