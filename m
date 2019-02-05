Received: from eggs.gnu.org ([209.51.188.92]:35693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSJ-0006SH-Co
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gqoSI-0007xd-MT
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:19:15 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Feb 2019 01:18:34 +0100
Message-Id: <20190205001835.25660-8-philmd@redhat.com>
In-Reply-To: <20190205001835.25660-1-philmd@redhat.com>
References: <20190205001835.25660-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/8] RFC iotests: Disable 209 on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

This test simply hangs with no information on OpenBSD.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/209 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/209 b/tests/qemu-iotests/209
index 259e991ec6..7eb41e4363 100755
--- a/tests/qemu-iotests/209
+++ b/tests/qemu-iotests/209
@@ -23,6 +23,7 @@ from iotests import qemu_img_create, qemu_io, qemu_img_=
verbose, qemu_nbd, \
                     file_path
=20
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
=20
 disk, nbd_sock =3D file_path('disk', 'nbd-sock')
 nbd_uri =3D 'nbd+unix:///exp?socket=3D' + nbd_sock
--=20
2.20.1
