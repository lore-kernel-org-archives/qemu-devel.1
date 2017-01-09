Received: from eggs.gnu.org ([2001:4830:134:3::10]:32831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyr-0002qi-0g
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyp-0000pq-H0
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:37 -0500
Date: Mon, 9 Jan 2017 12:42:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170109014218.GD12515@umbus.fritz.box>
References: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline
In-Reply-To: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/4] ppc: add a IBM 40p machine (RS/6000, PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>


--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2017 at 04:23:39PM +0100, Herv=E9 Poussineau wrote:
> Hi,
>=20
> This patchset adds the emulation of the IBM RS/6000 7020 (40p). The real =
machine is
> able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of OS=
/2 PowerPC,
> Solaris, Linux, NetBSD/PReP ...
>=20
> I've tested current emulation with Open Hack'Ware, OpenBIOS and official =
firmware.
>=20
> Linux kernel starts, and freezes during boot (seems like a problem with t=
he SCSI adapter).
> Windows NT starts up to the point where it wants to change endianness.
> Other OSes have not been tested.
>=20
> This machine is a superset of the 'prep' one, because we know exactly wha=
t is/should
> emulated, and that operating system list running on it is quite wide.
> I hope that 'prep' machine can be deprecated soon and then later removed.
>=20
> Patch 1 is a cleanup, and can probably be committed first.
> Patches 2 to 4  are the real implementation of the IBM 40p.

Applied to ppc-for-2.9, with a slight config tweak to 3/4 to avoid
breaking make check on ppc64.

>=20
> Changes since v2:
> - patch 2: fix mismatch between read and write functions for port 92
> - patch 4: use error_report instead of fprintf/hw_error
>=20
> Changes since v1:
> - removed patches related to display adapter:
>   Let's wait for an emulation of the real display adapter (an S3 Trio), a=
s current
>   VGA adapter already mostly works with Open Hack'Ware and OpenBIOS
> - various changes due to David Gibson's remarks
>=20
> Herv=E9 Poussineau (4):
>   prep: do not use global variable to access nvram
>   prep: add PReP System I/O
>   prep: add IBM RS/6000 7020 (40p) memory controller
>   prep: add IBM RS/6000 7020 (40p) machine emulation
>=20
>  default-configs/ppc-softmmu.mak |   2 +
>  hw/ppc/Makefile.objs            |   2 +
>  hw/ppc/prep.c                   | 233 +++++++++++++++++++++++++++++-
>  hw/ppc/prep_systemio.c          | 303 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
>  hw/ppc/trace-events             |  11 ++
>  6 files changed, 781 insertions(+), 2 deletions(-)
>  create mode 100644 hw/ppc/prep_systemio.c
>  create mode 100644 hw/ppc/rs6000_mc.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcup4AAoJEGw4ysog2bOSsowP/2S2aMShKTov+1EsLJuYFeM/
MgVweW2/1GHw0kTbyC7w5+gnSNi984bby0OiIGnyXsTRsyH4Si62oQNpTC2jXh1d
uzxV/rIDQEswft/UJvOaQsbatdj0ew2H58dQi5XMqdXy6KfzySjuYniOjLogYtw4
Oc4WBZH+BBJP9oIJugI6bVlMIdOj8zZt7RH2xi7dWEe0ObZfxDelVSbpqlbxN3hK
BLZKWFclJMG/2uwJ94cRHMF/n6mXSmR7CrDrtvVxmN1wKeRCS+QfWjzqFKaVTtzz
1hW5t/SlClqXjABOoE81mal8FPOkejUxpPVgIn3jfdMNbcbXxi0/pTZBZLADe7TZ
7vcLjKvv4DyeJ0vSnLBS3AyhtgWYyHXKtebXcHp2JeeCmidGzn9IVNVD1Bt4jYO4
ylA5cZq5rQRBCctkiHM1uW47sLkDbGY+sUxO/RhbaJesyIod75gmIbJvPuNmTKI7
Z9twcUZdAGvtz1xPpy4BfnxvpQm9jLhKHT7/3juvMvUq5jKoU58x0ug+zg5QPfSm
L3yN+V8KlyuOgZNStqkN7306peHOHUxbHLMeaXMDDDHTIG5RWzILd+VlxN6yxz5E
e1YAb53goiuIU/bZr0HbX8AlQq+/ohWC+Tnh3Ewyn/zX0MMuu1bjwLFwfZ2vbit6
ATwf/ayZ4ZzeQKGj9vHX
=cO5K
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--
