Received: from eggs.gnu.org ([2001:4830:134:3::10]:42157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erW-0000RR-AK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g7erS-0002iK-6Q
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g7erR-0002OG-Of
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:58:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  3 Oct 2018 14:57:49 +0400
Message-Id: <20181003105755.10862-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit dafd95053611aa14dda40266857608d12ddce6=
58:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-02 18:27:18 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/chardev-pull-request

for you to fetch changes up to a7077b8e354d90fec26c2921aa2dea85b90dff90:

  chardev: use a child source for qio input source (2018-10-03 14:45:05 +=
0400)

----------------------------------------------------------------
chardev patches

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (6):
  chardev: avoid crash if no associated address
  chardev: remove qemu_chr_fe_read_all() counter
  chardev: unref if underlying chardev has no parent
  char.h: fix gtk-doc comment style
  chardev: mark the calls that allow an implicit mux monitor
  chardev: use a child source for qio input source

 include/chardev/char-fe.h | 81 ++++++++++++++++++---------------------
 include/chardev/char.h    | 81 +++++++++++++++++++++------------------
 chardev/char-fe.c         | 13 ++++---
 chardev/char-io.c         | 48 +++--------------------
 chardev/char-socket.c     |  8 +++-
 chardev/char.c            | 37 ++++++++++++++----
 gdbstub.c                 |  6 ++-
 hw/char/xen_console.c     |  6 ++-
 net/slirp.c               |  6 ++-
 vl.c                      | 10 ++---
 10 files changed, 149 insertions(+), 147 deletions(-)

--=20
2.19.0.271.gfe8321ec05
