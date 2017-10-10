Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y44-0007RG-EP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1y3y-00079S-Aa
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1y3y-000797-1O
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:11:26 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 19:10:55 +0200
Message-Id: <20171010171122.9756-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, f4bug@amsat.org, changpeng.liu@intel.com, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following changes since commit 567d0a19c7998fa366598b83d5a6e5f0759d3e=
a9:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2017-10-10 13:25:46 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/vus-pull-request

for you to fetch changes up to 25f1fe82c64c8c4922254d63195e1d9cffbb0507:

  vhost-user-scsi: remove server_sock from VusDev (2017-10-10 19:06:06 +0=
200)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (27):
  glib-compat: move G_SOURCE_CONTINUE/REMOVE there
  build-sys: fix libvhost-user.a build
  build-sys: make vhost-user-scsi depend on libvhost-user.a
  libvhost-user: drop dependency on glib
  libvhost-user: improve vu_queue_pop() doc
  vhost-user-scsi: use g_strdup()
  vhost-user-scsi: connect unix socket before allocating
  vhost-user-scsi: code style fixes
  vhost-user-scsi: use glib allocation
  vhost-user-scsi: glib calls that allocate don't return NULL
  vhost-user-scsi: also free the gtree
  vhost-user-scsi: remove vdev_scsi_find_by_vu()
  vhost-user-scsi: simplify unix path cleanup
  vhost-user-scsi: use NULL pointer
  vhost-user-scsi: assert() in iscsi_add_lun()
  vhost-user-scsi: remove vdev_scsi_add_iscsi_lun()
  vhost-user-scsi: remove VUS_MAX_LUNS
  vhost-user-scsi: remove unimplemented functions
  vhost-user-scsi: rename VUS types
  vhost-user-scsi: avoid use of iscsi_ namespace
  vhost-user-scsi: don't copy iscsi/scsi-lowlevel.h
  vhost-user-scsi: drop extra callback pointer
  vhost-user-scsi: simplify source handling
  vhost-user-scsi: use glib logging
  libvhost-user: add glib source helper
  vhost-user-scsi: use libvhost-user glib helper
  vhost-user-scsi: remove server_sock from VusDev

 contrib/libvhost-user/libvhost-user-glib.h |  32 ++
 contrib/libvhost-user/libvhost-user.h      |   3 +-
 include/glib-compat.h                      |   7 +
 contrib/libvhost-user/libvhost-user-glib.c | 154 +++++++
 contrib/libvhost-user/libvhost-user.c      |  29 +-
 contrib/vhost-user-scsi/vhost-user-scsi.c  | 629 +++++------------------=
------
 Makefile                                   |   5 +-
 Makefile.objs                              |   1 -
 contrib/libvhost-user/Makefile.objs        |   2 +-
 tests/Makefile.include                     |   2 +-
 10 files changed, 316 insertions(+), 548 deletions(-)
 create mode 100644 contrib/libvhost-user/libvhost-user-glib.h
 create mode 100644 contrib/libvhost-user/libvhost-user-glib.c

--=20
2.15.0.rc0.40.gaefcc5f6f
