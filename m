Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFceo-0001ev-AW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFcej-0005Vw-SM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:38 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFcej-0005Vg-Ik
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:37:33 -0400
Received: by mail-wm0-x241.google.com with SMTP id k15so23437397wmh.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 01:37:33 -0700 (PDT)
Date: Tue, 30 May 2017 09:37:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530083730.GB11362@stefanha-x1.localdomain>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] QAPI patches for 2017-05-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 02:30:29PM +0200, Markus Armbruster wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-23
>=20
> for you to fetch changes up to 8c1bc1e9d770e7576fc272424dd48eb008ebff39:
>=20
>   qapi-schema: Remove obsolete note from ObjectTypeInfo (2017-05-23 13:28=
:17 +0200)
>=20
> ----------------------------------------------------------------
> QAPI patches for 2017-05-23
>=20
> ----------------------------------------------------------------
> Eduardo Habkost (1):
>       qapi-schema: Remove obsolete note from ObjectTypeInfo
>=20
> Eric Blake (6):
>       shutdown: Simplify shutdown_signal
>       shutdown: Prepare for use of an enum in reset/shutdown_request
>       shutdown: Preserve shutdown cause through replay
>       shutdown: Add source information to SHUTDOWN and RESET
>       shutdown: Expose bool cause in SHUTDOWN and RESET events
>       block: Use QDict helpers for --force-share
>=20
> Greg Kurz (1):
>       scripts/qmp/qom-set: fix the value argument passed to srv.command()
>=20
> Markus Armbruster (1):
>       sockets: Plug memory leak in socket_address_flatten()
>=20
>  hw/acpi/core.c              |  4 +--
>  hw/arm/highbank.c           |  4 +--
>  hw/arm/integratorcp.c       |  2 +-
>  hw/arm/musicpal.c           |  2 +-
>  hw/arm/omap1.c              | 10 ++++---
>  hw/arm/omap2.c              |  2 +-
>  hw/arm/spitz.c              |  2 +-
>  hw/arm/stellaris.c          |  2 +-
>  hw/arm/tosa.c               |  2 +-
>  hw/i386/pc.c                |  2 +-
>  hw/i386/xen/xen-hvm.c       |  9 ++++--
>  hw/input/pckbd.c            |  4 +--
>  hw/ipmi/ipmi.c              |  4 +--
>  hw/isa/lpc_ich9.c           |  2 +-
>  hw/mips/boston.c            |  2 +-
>  hw/mips/mips_malta.c        |  2 +-
>  hw/mips/mips_r4k.c          |  4 +--
>  hw/misc/arm_sysctl.c        |  8 +++---
>  hw/misc/cbus.c              |  2 +-
>  hw/misc/macio/cuda.c        |  4 +--
>  hw/misc/slavio_misc.c       |  4 +--
>  hw/misc/zynq_slcr.c         |  2 +-
>  hw/pci-host/apb.c           |  4 +--
>  hw/pci-host/bonito.c        |  2 +-
>  hw/pci-host/piix.c          |  2 +-
>  hw/ppc/e500.c               |  2 +-
>  hw/ppc/mpc8544_guts.c       |  2 +-
>  hw/ppc/ppc.c                |  2 +-
>  hw/ppc/ppc405_uc.c          |  2 +-
>  hw/ppc/spapr_hcall.c        |  2 +-
>  hw/ppc/spapr_rtas.c         |  4 +--
>  hw/s390x/ipl.c              |  2 +-
>  hw/sh4/r2d.c                |  2 +-
>  hw/timer/etraxfs_timer.c    |  2 +-
>  hw/timer/m48t59.c           |  4 +--
>  hw/timer/milkymist-sysctl.c |  4 +--
>  hw/timer/pxa2xx_timer.c     |  2 +-
>  hw/watchdog/watchdog.c      |  2 +-
>  hw/xenpv/xen_domainbuild.c  |  2 +-
>  hw/xtensa/xtfpga.c          |  2 +-
>  include/sysemu/replay.h     |  3 +-
>  include/sysemu/sysemu.h     | 32 ++++++++++++++++-----
>  kvm-all.c                   |  6 ++--
>  migration/colo.c            |  2 +-
>  migration/savevm.c          |  2 +-
>  os-win32.c                  |  2 +-
>  qapi-schema.json            |  2 --
>  qapi/event.json             | 17 ++++++++---
>  qemu-img.c                  |  7 ++---
>  qemu-io.c                   |  2 +-
>  qmp.c                       |  4 +--
>  replay/replay-internal.h    |  3 +-
>  replay/replay.c             |  9 +++---
>  scripts/qmp/qom-set         |  2 +-
>  target/alpha/sys_helper.c   |  4 +--
>  target/arm/psci.c           |  4 +--
>  target/i386/excp_helper.c   |  2 +-
>  target/i386/hax-all.c       |  6 ++--
>  target/i386/helper.c        |  2 +-
>  target/i386/kvm.c           |  2 +-
>  target/s390x/helper.c       |  2 +-
>  target/s390x/kvm.c          |  4 +--
>  target/s390x/misc_helper.c  |  4 +--
>  target/sparc/int32_helper.c |  2 +-
>  tests/qemu-iotests/071.out  |  4 +--
>  tests/qemu-iotests/081.out  |  2 +-
>  tests/qemu-iotests/087.out  | 12 ++++----
>  tests/qemu-iotests/094.out  |  2 +-
>  tests/qemu-iotests/117.out  |  2 +-
>  tests/qemu-iotests/119.out  |  2 +-
>  tests/qemu-iotests/120.out  |  2 +-
>  tests/qemu-iotests/140.out  |  2 +-
>  tests/qemu-iotests/143.out  |  2 +-
>  tests/qemu-iotests/156.out  |  2 +-
>  trace-events                |  2 +-
>  ui/cocoa.m                  |  2 +-
>  ui/sdl.c                    |  2 +-
>  ui/sdl2.c                   |  4 +--
>  util/qemu-sockets.c         |  4 ++-
>  vl.c                        | 69 ++++++++++++++++++++++++++-------------=
------
>  80 files changed, 204 insertions(+), 159 deletions(-)
>=20
> --=20
> 2.7.4
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLS9KAAoJEJykq7OBq3PIukYH/RmbPRmXRiCVsEadnQnlwLNs
BRzR6j2h1It1MgkpIASpEl0M1/Lv5+KL9OkWw2/dY3JJMpWv8FxRD6U7HG8BDkc0
mEQ6opeGGZAHCPCoxX53P5Aw/sz5shyBFpQbHo9wJxT0eDSKF9jBVJ4EQLGOgsn7
dGtOkS8rixyNubushuB0MSm6xiCP2NR+EM40QZDA5a7jKMn6e9QhizVxmBygToa8
YsQJDCufEb/UU24IP33tgtMmREStmC5Vc+PWIJ0Qr49+lZ/u3XNNAZOAmQCBXfML
LcyKGuJQuQNlldgKRLV0+1kQWI0Nf1osnvxfgnH3MM2eByWIej/OC1/6jaDGeyE=
=KPRz
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
