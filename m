Received: from eggs.gnu.org ([2001:4830:134:3::10]:52320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKYw8-0002pg-M9
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKYw6-00068u-IU
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 20:16:44 -0500
Date: Thu, 8 Nov 2018 12:16:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181108011610.GL5575@umbus.fritz.box>
References: <20181030093531.18587-1-agraf@suse.de>
	<655b9090-bb99-2255-5020-d2da2a404bfc@ilande.co.uk>
	<20181107042520.GC5575@umbus.fritz.box>
	<bad5af59-2f6f-0138-2b5c-c2e4fceabb65@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <bad5af59-2f6f-0138-2b5c-c2e4fceabb65@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 05:46:18PM +0000, Mark Cave-Ayland wrote:
> On 07/11/2018 04:25, David Gibson wrote:
>=20
> > On Tue, Oct 30, 2018 at 02:34:46PM +0000, Mark Cave-Ayland wrote:
> >> On 30/10/2018 09:35, Alexander Graf wrote:
> >>
> >>> I haven't really been maintaining any PowerPC code for quite a while =
now,
> >>> so let's reflect reality: David does all the work and embedded PPC is=
 in
> >>> "Odd Fixes" state rather than supported now.
> >>
> >> It was a pleasure working with you, but of course life moves
> >> on... :)
> >=20
> > [snip]
> >>>  New World
> >>> -M: Alexander Graf <agraf@suse.de>
> >>> +M: David Gibson <david@gibson.dropbear.id.au>
> >>>  L: qemu-ppc@nongnu.org
> >>> -S: Maintained
> >>> +S: Odd Fixes
> >>
> >> There was actually a patch floating around to add myself to MAINTAINER=
S for the New
> >> World and Old World machines, but I think it got lost when trying to s=
et up a
> >> sub-maintainer queue with David. I'm happy to look after these
> >> machines for now.
> >=20
> > Yeah, it did.  Still need to sort that out...
>=20
> Okay well as you've still got a ppc-for-3.1 pull pending, I can send a pa=
tch to add
> myself as a maintainer. Should I leave you listed there?

Maybe change me to an "R:" instead of "M:".

> Also I see that Alex also switched the Old World/New World machines to "O=
dd Fixes"
> from "Maintained" - is that correct?

Yes, I think so.  Unless you're volunteering to keep them maintained.

>=20
> >>>  F: hw/ppc/mac_newworld.c
> >>>  F: hw/pci-host/uninorth.c
> >>>  F: hw/pci-bridge/dec.[hc]
> >>> @@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
> >>>  F: include/hw/ppc/mac_dbdma.h
> >>> =20
> >>>  Old World
> >>> -M: Alexander Graf <agraf@suse.de>
> >>> +M: David Gibson <david@gibson.dropbear.id.au>
> >>>  L: qemu-ppc@nongnu.org
> >>> -S: Maintained
> >>> +S: Odd Fixes
> >>>  F: hw/ppc/mac_oldworld.c
> >>>  F: hw/pci-host/grackle.c
> >>>  F: hw/misc/macio/
> >>> @@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
> >>> =20
> >>>  sPAPR
> >>>  M: David Gibson <david@gibson.dropbear.id.au>
> >>> -M: Alexander Graf <agraf@suse.de>
> >>>  L: qemu-ppc@nongnu.org
> >>>  S: Supported
> >>>  F: hw/*/spapr*
> >>> @@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
> >>>  F: tests/acpi-utils.[hc]
> >>> =20
> >>>  ppc4xx
> >>> -M: Alexander Graf <agraf@suse.de>
> >>> +M: David Gibson <david@gibson.dropbear.id.au>
> >>>  L: qemu-ppc@nongnu.org
> >>>  S: Odd Fixes
> >>>  F: hw/ppc/ppc4*.c
> >>> @@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
> >>>  F: include/hw/i2c/ppc4xx_i2c.h
> >>> =20
> >>>  ppce500
> >>> -M: Alexander Graf <agraf@suse.de>
> >>> +M: David Gibson <david@gibson.dropbear.id.au>
> >>>  L: qemu-ppc@nongnu.org
> >>> -S: Supported
> >>> +S: Odd Fixes
> >>>  F: hw/ppc/e500*
> >>>  F: hw/pci-host/ppce500.c
> >>>  F: hw/net/fsl_etsec/
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvjjloACgkQbDjKyiDZ
s5IO8xAA0uHU6gSTw4IaCLk8ySJqyUyoF2FCSyRzdYrcZrJCrmXQs2voAaNMXAG/
VKHepIBdJuvQKu10THKUeD9udsn2pWqqjLUwThLMidolwn8DuUq8sU92cpbxEtNf
XJ5V6FtpqYItnII8VDHpGrNqqYk7jIO9wMiFPO28mbTPpo9C+Bj+tlN5UR7tLGN0
OzgaUY3k9vw6ouZMKsg0WwMPPrneg0BU04UpHUZcuOdUZyP/jMteqcFQqNYs8NWC
ONPD1qfZ122AVjp0ZMHQeyslW74udNMTU79po5wlBkhyJzjafV8jYgBaYqTI42HR
sqcmslzHwE/UGyon/rGM/vlBiHcYdaNF/ZdPYMjwI21kKhKJYlfgGlJPyi5Kpx15
+gjXStA0dd+rk7JLKuzgJEseGEDqkPx5rf/adBe1v+EpYUhySEkf1yjVLLeVDzpE
5zwQ6b9+RgniJN5RD9lwSoZUGT7MDIvjwAMA1FtdRcmxF2UriDsy9VZYw/fWh0hH
b8XTSEC+U6nFUhA0aJVpfxwMerJxuhdcQBosDQ3qAelVTRna1SKO82SXZaaV1yDl
chQqggRS5JzngAKrfjGp9DN7HPVrbntrL/s0DK0HmcEJmcJoZKMi9Bd0dHscDLOD
Y2IHUlTN6IckE0BdDQ6VPZGqHS+sQsjQ002WK9qyibrLSMUjjZU=
=FACw
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
