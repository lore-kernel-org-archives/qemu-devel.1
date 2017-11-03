Received: from eggs.gnu.org ([2001:4830:134:3::10]:36111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdtZ-0004Vm-KA
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eAdtW-0005X7-HY
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eAdtW-0005Wq-BH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 11:28:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 Nov 2017 16:28:22 +0100
Message-Id: <20171103152824.21948-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] mux chardev events regression fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kirill.shutemov@linux.intel.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The following patches fix and test the behaviour of mux chardev
events, after a regression introduced in qemu 2.8.0.

v1->v2:
- fix incompatible pointer type warning spotted by patchew

Marc-Andr=C3=A9 Lureau (2):
  chardev: fix backend events regression with mux chardev
  test: add some chardev mux event tests

 include/chardev/char.h |  1 +
 chardev/char-mux.c     |  8 ++++++++
 chardev/char.c         | 18 ++++++++++++------
 tests/test-char.c      | 17 +++++++++++++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

--=20
2.15.0.rc0.40.gaefcc5f6f
