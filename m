Received: from eggs.gnu.org ([209.51.188.92]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXfg-0005W7-Q9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXff-0002g1-P0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:54:02 +0100
Message-Id: <20190129175403.18017-18-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 17/18] iotests: Disable 209 on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

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
