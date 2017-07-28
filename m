Received: from eggs.gnu.org ([2001:4830:134:3::10]:55151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1db61G-0002R8-Mc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1db61C-0002lF-Tm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1db61C-0002kV-OC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 10:13:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Jul 2017 16:13:07 +0200
Message-Id: <20170728141309.14275-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

The series aims to add --disable-vhost-user configure option, to
disable all vhost-user support.

v2:
- remove some #ifdef, reuse CONFIG_VHOST_NET_USED
- split the patch to have net/vhost-user.c compiled out (adding 2 ifdefs)
- fail if --enable-vhost-user on win32

Marc-Andr=C3=A9 Lureau (2):
  build-sys: add --disable-vhost-user
  build-sys: do not compile net/vhost-user.c if vhost-user is disabled

 hw/net/vhost_net.c                |  4 ++++
 hw/virtio/virtio-pci.c            |  4 ++--
 configure                         | 29 +++++++++++++++++++++++++++--
 default-configs/pci.mak           |  2 +-
 default-configs/s390x-softmmu.mak |  2 +-
 net/Makefile.objs                 |  2 +-
 tests/Makefile.include            |  6 +++---
 7 files changed, 39 insertions(+), 10 deletions(-)

--=20
2.14.0.rc0.1.g40ca67566
