Received: from eggs.gnu.org ([2001:4830:134:3::10]:33510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLsz6-0004Vu-HH
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLsz5-0008A5-Gb
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:21:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
Date: Thu, 24 May 2018 13:20:44 -0300
MIME-Version: 1.0
In-Reply-To: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="VUMm4I5lFivifHcKgPF0DN1avdjuLnq13"
Subject: Re: [Qemu-devel] [PATCH] prep: fix keyboard for the 40p machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VUMm4I5lFivifHcKgPF0DN1avdjuLnq13
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au
Message-ID: <0d9436e3-9514-8d78-9c39-7d7da75ea8e8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] prep: fix keyboard for the 40p machine
References: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180524053958.5554-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/24/2018 02:39 AM, Mark Cave-Ayland wrote:
> Commit 72d3d8f052 "hw/isa/superio: Add a keyboard/mouse controller (804=
2)"
> added an 8042 keyboard device to the PC87312 superio device to replace =
that
> being used by the prep machine.
>=20
> Unfortunately this commit didn't do the same for the 40p machine which =
broke
> the keyboard by registering two 8042 keyboard devices at the same addre=
ss.

Oops sorry... I have this fixed in the following up series after SuperIO
cleanup, which is SouthBridge cleanup, involving a good rework of the
PIIX and I82378 chipsets, using Herv=C3=A9 Poussineau patches.
But I have 2 more prioritary series to finish before returning to this
one :/

> Resolve this by similarly removing the 8042 keyboard from the 40p machi=
ne as
> done for the prep machine in commit 72d3d8f052.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks for fixing this (too bad there are no keyboard qtests and this
got unnoticed).

> ---
>  hw/ppc/prep.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index a1e7219db6..be4db6a687 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -770,7 +770,6 @@ static void ibm_40p_init(MachineState *machine)
> =20
>      /* add some more devices */
>      if (defaults_enabled()) {
> -        isa_create_simple(isa_bus, TYPE_I8042);
>          m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
> =20
>          dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));
>=20


--VUMm4I5lFivifHcKgPF0DN1avdjuLnq13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsG5lwACgkQ4+MsLN6t
wN4VohAAvSLry+Z972otHYNok7at1Z8puo5loHFqsR7CD1ird9O4hJZjShfJ83kf
BG0N9to+UzfeUgOBieAcd/qSqJb5HsEqL4Z1jIjr92NZNzgrEZdjMQByms9343T9
dZVKQDMsWELjywFhq4fpu3kYRkXS0FmSkFXDYze1Q8C0Dd5MQSBHiVE5/mdef8Fi
q3EtJxg0eUbOR+D00kFk/2ESko2x+Pk/ffcVLZN1hY30bdY6topANwIkolCXnDrh
NEOOSgVcpaCWi5Pmf638xPi0N1rzYUxW/Ehqy1jVK8ttPbdUBIeXgTQciCDvCnD1
91Saz03thqVncdMt09zNODR2ElcKS2DrrDWVfyzp8QvNs+dSFuLDu151T24RqlNX
HeBtIbLIwuy6je5vuIxQsFZ0khW1G6us/WBoscPafU4zlLb9Gw/YdzvMsn5D0jWM
CABUzqkJ3wvBFiBtEa5HQyKNM3xnh+2l/DrvBfFn+zz/mZ7x00BrRFc7pYMcfnN3
jYx96PpZCcF4L6HrXfLeVCQKDYD2gnuj10CiTNr30LVaAxrqvEMFvI6zLgu6rPe9
tqBx9CqOAN48Hh1IHzrZeJXA+G+XzSZQK/OzscWPt5rsxNFkQIbLlHzkWlMeTxAI
DAOkkF95Uhrngbsizfi9weL3G2gfdlm0lN0wd2IAnfftnbZuxCY=
=6v/8
-----END PGP SIGNATURE-----

--VUMm4I5lFivifHcKgPF0DN1avdjuLnq13--
