Received: from eggs.gnu.org ([2001:4830:134:3::10]:45559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m32-0004ss-BK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d7m2y-0002B8-27
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:02:12 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d7m2x-0002B1-TP
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:02:07 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so10981094qkh.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 10:02:07 -0700 (PDT)
Date: Mon, 8 May 2017 13:02:05 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170508170205.GG22428@stefanha-x1.localdomain>
References: <20170505101337.4650-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <20170505101337.4650-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/21] Misc patches for 2017-05-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 12:13:16PM +0200, Paolo Bonzini wrote:
> The following changes since commit e619b14746e5d8c0e53061661fd0e1da01fd4d=
60:
>=20
>   Merge remote-tracking branch 'sthibault/tags/samuel-thibault' into stag=
ing (2017-05-02 15:16:29 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/bonzini/qemu.git tags/for-upstream
>=20
> for you to fetch changes up to 95615ce5a1beffff1a5dd3597d8cb6ba83f0010e:
>=20
>   vhost-scsi: create a vhost-scsi-common abstraction (2017-05-05 12:10:00=
 +0200)
>=20
> ----------------------------------------------------------------
> A large set of small patches.  I have not included yet vhost-user-scsi,
> but it'll come in the next pull request.
>=20
> * use GDB XML register description for x86
> * use _Static_assert in QEMU_BUILD_BUG_ON
> * add "R:" to MAINTAINERS and get_maintainers
> * checkpatch improvements
> * dump threading fixes
> * first part of vhost-user-scsi support
> * QemuMutex tracing
> * vmw_pvscsi and megasas fixes
> * sgabios module update
> * use Rev3 (ACPI 2.0) FADT
> * deprecate -hdachs
> * improve -accel documentation
> * hax fix
> * qemu-char GSource bugfix
>=20
> ----------------------------------------------------------------
> Abdallah Bouassida (1):
>       target/i386: Add GDB XML register description support
>=20
> Andreas Grapentin (1):
>       use _Static_assert in QEMU_BUILD_BUG_ON
>=20
> Brian Norris (2):
>       get_maintainer: it's '--pattern-depth', not '-pattern-depth'
>       get_maintainer: --r (list reviewer) is on by default
>=20
> Dr. David Alan Gilbert (1):
>       checkpatch: Disallow glib asserts in main code
>=20
> Fam Zheng (1):
>       dump: Acquire BQL around vm_start() in dump thread
>=20
> Felipe Franciosi (2):
>       libvhost-user: replace vasprintf() to fix build
>       vhost-scsi: create a vhost-scsi-common abstraction
>=20
> Joe Perches (2):
>       get_maintainer: Teach get_maintainer.pl about the new "R:" tag
>       get_maintainer: add subsystem to reviewer output
>=20
> Jose Ricardo Ziviani (1):
>       trace: add qemu mutex lock and unlock trace events
>=20
> P J P (1):
>       vmw_pvscsi: check message ring page count at initialisation
>=20
> Paolo Bonzini (1):
>       sgabios: update for "fix wrong video attrs for int 10h,ah=3D=3D13h"
>=20
> Paul E. McKenney (1):
>       MAINTAINERS: Add "R:" tag for self-appointed reviewers
>=20
> Phil Dennis-Jordan (2):
>       hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest =
OS support.
>       hw/i386: Build-time assertion on pc/q35 reset register being identi=
cal.
>=20
> Prasad J Pandit (1):
>       scsi: avoid an off-by-one error in megasas_mmio_write
>=20
> Thomas Huth (2):
>       vl: deprecate the "-hdachs" option
>       Fix the -accel parameter and the documentation for 'hax'
>=20
> Yu Ning (1):
>       hax: Fix memory mapping de-duplication logic
>=20
> zhanghailiang (1):
>       char: Fix removing wrong GSource that be found by fd_in_tag
>=20
>  MAINTAINERS                           |   2 +
>  chardev/char-fd.c                     |   8 +-
>  chardev/char-io.c                     |  23 ++--
>  chardev/char-io.h                     |   4 +-
>  chardev/char-pty.c                    |   6 +-
>  chardev/char-socket.c                 |   8 +-
>  chardev/char-udp.c                    |   8 +-
>  chardev/char.c                        |   2 +-
>  configure                             |  20 ++++
>  contrib/libvhost-user/libvhost-user.c |   2 +-
>  dump.c                                |   7 ++
>  gdb-xml/i386-32bit-core.xml           |  65 ++++++++++++
>  gdb-xml/i386-64bit-core.xml           |  73 +++++++++++++
>  hw/i386/acpi-build.c                  |  35 +++++-
>  hw/pci-host/piix.c                    |   6 --
>  hw/scsi/Makefile.objs                 |   2 +-
>  hw/scsi/megasas.c                     |  10 +-
>  hw/scsi/vhost-scsi-common.c           | 143 +++++++++++++++++++++++++
>  hw/scsi/vhost-scsi.c                  | 194 ++++++++++------------------=
------
>  hw/scsi/vmw_pvscsi.c                  |   2 +-
>  include/hw/acpi/acpi-defs.h           |  77 +++++++-------
>  include/hw/i386/pc.h                  |   6 ++
>  include/hw/virtio/vhost-scsi-common.h |  48 +++++++++
>  include/hw/virtio/vhost-scsi.h        |  11 +-
>  include/hw/virtio/virtio-scsi.h       |   2 +
>  include/qemu/compiler.h               |   4 +-
>  include/sysemu/char.h                 |   2 +-
>  include/sysemu/dump.h                 |   1 +
>  pc-bios/sgabios.bin                   | Bin 4096 -> 4096 bytes
>  qemu-options.hx                       |  22 ++--
>  roms/sgabios                          |   2 +-
>  scripts/checkpatch.pl                 |  21 ++++
>  scripts/get_maintainer.pl             |  53 +++++++---
>  target/i386/cpu.c                     |  21 +++-
>  target/i386/hax-mem.c                 |  19 +++-
>  tests/acpi-utils.h                    |  10 ++
>  tests/bios-tables-test.c              |  23 +++-
>  util/qemu-thread-posix.c              |  18 +++-
>  util/qemu-thread-win32.c              |  11 +-
>  util/trace-events                     |   4 +
>  vl.c                                  |  25 ++---
>  41 files changed, 705 insertions(+), 295 deletions(-)
>  create mode 100644 gdb-xml/i386-32bit-core.xml
>  create mode 100644 gdb-xml/i386-64bit-core.xml
>  create mode 100644 hw/scsi/vhost-scsi-common.c
>  create mode 100644 include/hw/virtio/vhost-scsi-common.h
> --=20
> 2.12.2
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEKSMAAoJEJykq7OBq3PI0GgH/3thfbfs2+LQH7HQa9CTphOF
wxZD0Gqq+m9BO1j1+r+E2VS1w09VQlHVVpb4MMFH/uVSc9vO4E2Q/+RvUrqr7kkE
b6VXfgvtWq1uJAlNAM7yyPnogGjkInX7QZ4h9RB26PFkrqXaQzELiObOhI4Yd936
B42G3vsjtAvj6IFtQGRLjsAMQk8EDa2O3MfJzlp3J3Nche8uAUmG26LSry0hssLu
qmoyGMyoWKbVgbrV1WijIBGhk+OiNuWAkYZKi0GGnxD5lQzHOCtxmNyYIVOzUOP2
eSGAeXRex99U46NM9PZKuTZH2iM2r/t9c7rFdNxEald/kfohLTZ+fvifP9p92g8=
=wVxh
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
