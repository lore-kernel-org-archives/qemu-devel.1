Received: from eggs.gnu.org ([2001:4830:134:3::10]:58903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tu-0006UQ-B2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR6tt-00009W-92
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 22:13:14 -0400
Date: Fri, 8 Jun 2018 12:11:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608021139.GC3344@umbus.fritz.box>
References: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20180607171751.11510-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/4] cuda/mos6522 migration fixes
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


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:17:47PM +0100, Mark Cave-Ayland wrote:
> Whilst performing a random migration test for the Mac machines I noticed
> a regression (patch 1) which prevented the loadvm from completing
> successfully. A big thank you to Peter and David on IRC who pointed me
> in the right direction in order to fix the bug.
>=20
> Once that was working I spent a bit more time analysing the migration
> stream and realised that the mos6522 device state wasn't being embedded
> within the CUDA device, but instead being maintained separately which is
> solved by patch 2.
>=20
> Patch 3 is something I noticed whilst rearranging the existing code based
> upon my better understanding of QOM/qdev and ensures that the timer frequ=
ency
> is always set correctly post-migration for the device and its parent clas=
s.
> This leaves no remaining functionality in the mos6522 realize function an=
d so
> allows it to be removed.
>=20
> Finally patch 4 was suggested by Peter on IRC whilst helping me investiga=
te
> the original migration issue, and removes the last remaining user of
> VMSTATE_TIMER_PTR_TEST from the codebase.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0.

>=20
>=20
> Mark Cave-Ayland (4):
>   mos6522: fix vmstate_mos6522_timer version in vmstate_mos6522
>   cuda: embed mos6522_cuda device directly rather than using QOM object
>     link
>   mos6522: move timer frequency initialisation to mos6522_reset
>   mos6522: convert VMSTATE_TIMER_PTR_TEST to VMSTATE_TIMER_PTR
>=20
>  hw/misc/macio/cuda.c         | 50 +++++++++++++++++++-------------------=
------
>  hw/misc/mos6522.c            | 26 ++++++-----------------
>  include/hw/misc/macio/cuda.h | 27 +++++++++++-------------
>  include/hw/misc/mos6522.h    |  4 +++-
>  4 files changed, 42 insertions(+), 65 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ5dkACgkQbDjKyiDZ
s5JZ7g/+OwJ8UKu4DWrnHttJdfeGJnZSnfXl3ateyQiU6SIuv9yl/V923ikDPXbs
3iqcgt25cBlyn3bdr2npgXbTVzbhjoM+nAhW5B+/cXJxRH1AMRhTvCGfPL7AN4wS
Awl8smMJFIkvk3rq7DCT/eJfpVjnxc29GhM7plcULv3yxQSF4MmX51Do/9KrIetI
asbKuQJY1+5RNy6CqlzNat4k5feHxPeVvtFY/HAEqN3KbUAjlRPGAY09AAyK07Vb
kzJBiTyyDgYZUhDXBvt0awGZ5a4V3cTc7T2WXmVN6wOmnCoyAS0ztQnVyFkvmKUc
8pQOQLzwlqZj1r2oz6VQGYC8dJF3DLu19byZ5xQZ3EZv+doMBmwKD0SZpndmpscf
K3V2Jwo68Nin87IjyfGMQrHf7pCy5Fha5W5V0ncAbH6UfL68lQc6hm2BDDg90H7G
0YWglZAtLiZCu8Lvtg5VTjA6GFfbnBC6b5a9YHUYMJxwiUwlUQT2PAiEZ9ckNDaR
zJpAN1jTzAZzr5CCY/LoIg7hM6xtK3+kNNz73vL8L6IXthjjPxbdEFS0FbHHxBvh
vA9bhrA4mY5UQTZta4qYyO587SfjcLqNPwBzKfzUcUCeaFRfLadSAiL0peWnHNO3
1Qzqz91qHQfntH7uJ7ELIZP0PlKyNtLCEMo4YAFTfVvzxysHTWU=
=Wpfg
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
