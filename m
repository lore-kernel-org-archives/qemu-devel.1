Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erFR7-0001S1-PY
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1erFR4-00049T-Me
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 23:03:17 -0500
Date: Thu, 1 Mar 2018 14:51:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180301035119.GB2264@umbus.fritz.box>
References: <20180228203243.1413-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20180228203243.1413-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv3 00/12] macio: remove legacy macio_init()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 08:32:31PM +0000, Mark Cave-Ayland wrote:
> This patchset eliminates the legacy macio_init() function used to setup t=
he
> ESCC and PIC memory regions and instead allows the macio device to be
> instantiated directly via qdev, wiring up the ESCC internally using sysbu=
s MMIO
> memory regions and the PIC via QOM object links.
>=20
> The biggest surprise in this patchset was the need to QOMify the heathrow
> device which apparently up until now has never required any of these new-=
fangled
> APIs from the last decade such as qdev and QOM.
>=20
> There's still some follow-up work to do with the PCI host bridge wiring b=
ut it
> seems to me that this is a good preparation step.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.12, thanks.

>=20
> v3:
> - Rebase onto master
> - Add extra R-B tags from David and Philippe
> - Add patch 8 to move KVM openpic declarations into separate openpic_kvm.=
h file
>   (fixes compilation of ppc-linux-user)
>=20
> v2:
> - Rebase onto master
> - Add R-B tags from David
> - Rework patch 4 ("heathrow: convert to trace-events") as suggested by Da=
vid
>=20
>=20
> Mark Cave-Ayland (12):
>   macio: embed DBDMA device directly within macio
>   macio: move ESCC device within the macio device
>   heathrow: QOMify heathrow PIC
>   heathrow: convert to trace-events
>   heathrow: change heathrow_pic_init() to return the heathrow device
>   macio: move macio related structures and defines into separate macio.h
>     file
>   mac_oldworld: use object link to pass heathrow PIC object to macio
>   openpic: move KVM-specific declarations into separate openpic_kvm.h
>     file
>   openpic: move OpenPIC state and related definitions to openpic.h
>   mac_newworld: use object link to pass OpenPIC object to macio
>   macio: move setting of CUDA timebase frequency to
>     macio_common_realize()
>   macio: remove macio_init() function
>=20
>  hw/intc/heathrow_pic.c         | 166 +++++++++++++++++++++--------------=
------
>  hw/intc/openpic.c              | 157 -----------------------------------=
---
>  hw/intc/openpic_kvm.c          |   1 +
>  hw/intc/trace-events           |   5 ++
>  hw/misc/macio/macio.c          | 150 +++++++++++++++++------------------=
--
>  hw/ppc/e500.c                  |   1 +
>  hw/ppc/mac.h                   |  10 +--
>  hw/ppc/mac_newworld.c          |  56 +++++---------
>  hw/ppc/mac_oldworld.c          |  50 +++++--------
>  include/hw/intc/heathrow_pic.h |  49 ++++++++++++
>  include/hw/misc/macio/macio.h  |  79 ++++++++++++++++++++
>  include/hw/ppc/openpic.h       | 160 +++++++++++++++++++++++++++++++++++=
+++-
>  include/hw/ppc/openpic_kvm.h   |   7 ++
>  target/ppc/kvm-stub.c          |   2 +-
>  14 files changed, 494 insertions(+), 399 deletions(-)
>  create mode 100644 include/hw/intc/heathrow_pic.h
>  create mode 100644 include/hw/misc/macio/macio.h
>  create mode 100644 include/hw/ppc/openpic_kvm.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqXeLUACgkQbDjKyiDZ
s5Kjyw//aj3Y6ew1zF2f6Il0QcgHJM5tQIk6q5r/0oTYNhYx2k1CG0n9a00TynYk
B8oNwNJl4otVp6fcd7yTsstvx8BGrzA84kTIg++S3shehDlbrnxt70P6UKPy74A0
94YuBiTkR6anQ0sPAEqnO/VM0lLfmKdOdg1bds4UGfKSMkJbzXtMzvYfxjHTAVDG
gCh4PJjn7+1noxUvXcVlWlkCROUBvKhTxWV+t3L+QrC8wkWZCAmmeZV/mnNAcFsq
OWUnsXNKh58Mlb7FDh4IWOD/TMwLqauPtbhal3qBpsmbBhMNo/83zykOlcD4Mw4c
WzKbB2O9TbSlNbRp1loMkyGuvMThDhQgyOBmqwN5I0JJBoFtwmsD8jA1wZfhX2sC
xSP/XrsOp/jou7W3SZGZQS3Ibp9rM2nJHWQAdTS9aM3bBQAKjI8Q1Jmbfk5qwqxs
LjaCygSKEBFC4QUqo8f2XmQjCO4Uenp/RRcGl6LAMcncKCmyQZG5IXHMMJAw1VTV
t2nMA7Ih1Et8F6jihrWqPuFEWNkaMUQ2T5PRDkFi+gxxdhyH/ja71NTQLSK10jIF
0jStLSh0rFnjWf6kfXtZm6C08/VWeiLQ6pM4eAGUJO6hPhEq4CW5G9J+IDJu9gGr
9WU+FSDgcl7mLv0gWsy5P+xqou+QcM13VjSZgpps1u5G0jpQ4Lo=
=XuEY
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
