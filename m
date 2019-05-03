Received: from eggs.gnu.org ([209.51.188.92]:56065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXnx-00056J-Ar
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hMXnv-000094-Ny
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hMXnv-00007T-Ij
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A9883151C52
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 13:00:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  3 May 2019 15:00:28 +0200
Message-Id: <20190503130034.24916-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] Add vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

Hi,

This is the vhost-user-input part of "[PATCH v6 00/11] vhost-user for inp=
ut & GPU".

v2:
- build fixes

v1: (changes since original v6 series)
- add "libvhost-user: fix -Waddress-of-packed-member" & "util: simplify u=
nix_listen()"
- use unix_listen()
- build vhost-user-input by default (when applicable)

Marc-Andr=C3=A9 Lureau (6):
  libvhost-user: fix -Waddress-of-packed-member
  libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
  Add vhost-user-backend
  Add vhost-user-input-pci
  util: simplify unix_listen()
  contrib: add vhost-user-input

 include/hw/virtio/virtio-input.h       |  14 +
 include/sysemu/vhost-user-backend.h    |  57 ++++
 backends/vhost-user.c                  | 209 +++++++++++++
 contrib/libvhost-user/libvhost-user.c  |  10 +-
 contrib/vhost-user-input/main.c        | 393 +++++++++++++++++++++++++
 hw/input/vhost-user-input.c            | 129 ++++++++
 hw/virtio/vhost-user-input-pci.c       |  53 ++++
 util/qemu-sockets.c                    |  18 +-
 MAINTAINERS                            |   4 +
 Makefile                               |  11 +
 Makefile.objs                          |   1 +
 backends/Makefile.objs                 |   2 +
 contrib/vhost-user-input/Makefile.objs |   1 +
 hw/input/Kconfig                       |   5 +
 hw/input/Makefile.objs                 |   1 +
 hw/virtio/Makefile.objs                |   1 +
 16 files changed, 890 insertions(+), 19 deletions(-)
 create mode 100644 include/sysemu/vhost-user-backend.h
 create mode 100644 backends/vhost-user.c
 create mode 100644 contrib/vhost-user-input/main.c
 create mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input-pci.c
 create mode 100644 contrib/vhost-user-input/Makefile.objs

--=20
2.21.0.777.g83232e3864
