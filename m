Received: from eggs.gnu.org ([2001:4830:134:3::10]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGJx-0006mF-I4
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGJw-0005DS-Gn
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:04:45 -0400
Date: Tue, 3 Oct 2017 15:36:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003043646.GE3260@umbus.fritz.box>
References: <1506790175-581-1-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fWddYNRDgTk9wQGZ"
Content-Disposition: inline
In-Reply-To: <1506790175-581-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] macio: add missing registers to
 VMStateDescription
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


--fWddYNRDgTk9wQGZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2017 at 05:49:35PM +0100, Mark Cave-Ayland wrote:
> Commit 4f7265f "ppc/ide/macio: Add missing registers" added two extra mac=
io
> registers but forgot to add them to the corresponding VMStateDescription.
>=20
> The version number is bumped accordingly, although this will have little
> effect given that the Mac machines are practically unmigratable.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Merged to ppc-for-2.11.  As you say, none of the Mac machines really
work for migration at the moment, so bumping the version (and
therefore notionally breaking backwards migration) isn't an issue.

> ---
>  hw/ide/macio.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
> index ce194c6..2e043ef 100644
> --- a/hw/ide/macio.c
> +++ b/hw/ide/macio.c
> @@ -353,12 +353,14 @@ static const MemoryRegionOps pmac_ide_ops =3D {
> =20
>  static const VMStateDescription vmstate_pmac =3D {
>      .name =3D "ide",
> -    .version_id =3D 4,
> +    .version_id =3D 5,
>      .minimum_version_id =3D 0,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_IDE_BUS(bus, MACIOIDEState),
>          VMSTATE_IDE_DRIVES(bus.ifs, MACIOIDEState),
>          VMSTATE_BOOL(dma_active, MACIOIDEState),
> +        VMSTATE_UINT32(timing_reg, MACIOIDEState),
> +        VMSTATE_UINT32(irq_reg, MACIOIDEState),
>          VMSTATE_END_OF_LIST()
>      }
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fWddYNRDgTk9wQGZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTE94ACgkQbDjKyiDZ
s5LVlRAA0lM2RvY9E9YDcXeqLT3EvB7aBPPa/hmEaAICs/4J5UiEm7xF5ujUxmpb
IeZry7DmQGB9DcDyxkCJaXG5qaDsUnf+J1TMnsRvSI9PFTGAbAGxRuOuUO/lT1Pt
WoVAOOWfrAF4upqZ3s6dG3QR4ASoBOeUgEjVDsTbw7SBV35j1VY0BmKasdqT54Gr
999WB00ct0hqiS8UZzkXK06HglVnJQs9W1GZD8ocamrTseIBi782X/mANjWTMER8
oZG/xzK5qzAd9O93oIgYqTeVMOwssp997vA5RHtsm67DcjxhXvAx55+LXY1+HRnR
JzpzneITViUvlQ/XqBaRvWmc0Cvx1Yd2G4TQ02jqa9iKe9NRmBEBw0Ry2jaYIobY
L7tGWS+OgiZawwX9BANK8zU9qbGnN0QNphO23K0OavOrR6S7NEq8QkyG2mVS4sZr
6TCs6J1hKljI1tCKWaTI5yMJwVC8iLLoP3BWVeGQncU3YhXt2Ot6ZyU8aBoGHMkT
NGR7yk4/6Ue06muhIgPhx2VKN2Ml1h8J/q8hx7fz8bdBNNPPZWfn+Z9j1B8PAHOI
USy7nWxo0TcJrxlYsvPFzwQmXQ4dqvCSNLSVk5DUeBWFbViQbSmoHfxfJe4pfd0w
qADbAaMFj5FzWzSTBmUREyy/JG8OCKFLts0JoO3UMULeKDkpHuo=
=WRyf
-----END PGP SIGNATURE-----

--fWddYNRDgTk9wQGZ--
