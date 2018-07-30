Received: from eggs.gnu.org ([2001:4830:134:3::10]:34088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk0AM-0001Q2-Rj
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fk0AL-00059H-P7
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 00:52:18 -0400
Date: Mon, 30 Jul 2018 14:49:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180730044931.GC2708@umbus.fritz.box>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20180730043904.17023-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org, balaton@eik.bme.hu


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 06:39:04AM +0200, Sebastian Bauer wrote:
> The four interrupts of the PCI bus are connected to the same UIC pin on t=
he
> real Sam460ex. Evidence for this can be found in the UBoot source for the
> Sam460ex in the Sam460ex.c file where PCI_INTERRUPT_LINE in written. This
> change brings the connection in line with this.
>=20
> This fixes the problem that can be observed when adding further PCI cards
> that get their interrupt rotated to other interrupts than PCI INT A. In
> particular, the bug was observed and verified to be fixed (after this
> change) with an additional OHCI PCI card.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

Applied to ppc-for-3.0.

> ---
>  hw/ppc/sam460ex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index 0999efcc1e..b2b22f280d 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -515,9 +515,9 @@ static void sam460ex_init(MachineState *machine)
> =20
>      /* PCI bus */
>      ppc460ex_pcie_init(env);
> -    /* FIXME: is this correct? */
> +    /* All PCI ints are connected to the same UIC pin (cf. UBoot source)=
 */
>      dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
> -                                uic[1][0], uic[1][20], uic[1][21], uic[1=
][22],
> +                                uic[1][0], uic[1][0], uic[1][0], uic[1][=
0],
>                                  NULL);
>      pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>      if (!pci_bus) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltemNsACgkQbDjKyiDZ
s5LB1Q/9E48qy2IMG40WSWilwcs48h7xzXmpkOAQeDArdxQ4iZYzI69kT/hqEger
l+VYDiPLRTU+s3wolKLfezSZFFEsqPegqEFuYq5B7r2A6nSdHu+/2rd1hYw0rnze
M/29Sdj57V9kA3Ti4AGVEjMyx2fMNInpBmNQvZ4JsAXzg8/XKQxQrJphRwDXSiQN
iRtF3z8CxFmf2Oymxqc2Uoo+SztEic9/nrppMnp1Tz5sqAnYQK/fr/fzkJbdVeNh
eNaxzFw+0cf3ht5erBfhd5QAgCw3ItOXI3YoOXuu+q9AYcDNG8gW9tpan8yHCkBL
pDv8K2mGcThAvf0J4cRI40uenMGtxirb1mDDVOLi31lNCfXwdG3veKesV+9Jft6q
lM9lqH1I/C0tGUD15EKjaP3miNlFZLEkukLsRPKwRvb63ApVu1WwUCLXnMm1ZObM
RR8LgohHzkLYMjBpnVojPO7YlyxZ75Rf0AQmFgGcF+oRmLxLpuBF6Idaf+y5klRG
MvG7ba5pVPhDQ6x5R3T2ov9CGUYJ4SEBWKM3Bo1hyGx7RMfdCbinrPvA6AqEwSV2
4p0HjOSZfy0QaEQ/DI7nujRW8Yf0fKlS4BHQZ637CUi42K9YoNtzkok0fven66LC
SSrO1LDYr0VdPVSVXPphlONHYFIg42srl/SigRgzt1bt5u7RHzg=
=lVnX
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
