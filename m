Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtU-0001DL-2i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtN-0002i2-RO
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:43 -0400
Date: Tue, 19 Sep 2017 06:25:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170918202503.GD15823@umbus>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-2-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <1505668548-16616-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 1/8] ppc: QOMify g3beige machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2017 at 06:15:41PM +0100, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/mac_oldworld.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index fcac399..5d1171d 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -380,8 +380,10 @@ static int heathrow_kvm_type(const char *arg)
>      return 2;
>  }
> =20
> -static void heathrow_machine_init(MachineClass *mc)
> +static void heathrow_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
>      mc->desc =3D "Heathrow based PowerMAC";
>      mc->init =3D ppc_heathrow_init;
>      mc->block_default_type =3D IF_IDE;
> @@ -394,4 +396,15 @@ static void heathrow_machine_init(MachineClass *mc)
>      mc->kvm_type =3D heathrow_kvm_type;
>  }
> =20
> -DEFINE_MACHINE("g3beige", heathrow_machine_init)
> +static const TypeInfo ppc_heathrow_machine_info =3D {
> +    .name          =3D MACHINE_TYPE_NAME("g3beige"),
> +    .parent        =3D TYPE_MACHINE,
> +    .class_init    =3D heathrow_class_init
> +};
> +
> +static void ppc_heathrow_register_types(void)
> +{
> +    type_register_static(&ppc_heathrow_machine_info);
> +}
> +
> +type_init(ppc_heathrow_register_types);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAK58ACgkQbDjKyiDZ
s5K3Mg//YWUfpBVHVgYcHvoa/cMzvSc9Q8/W71hLUQ9xtxVtnNfL4MG501CsWm0j
9bWSDmQsTPmnlPkiXmZgC4z4vvB7+9SQbXcd7i56WC8JqP4nvOBsVJvAuknDzxHt
0AIe1PiEb9bZFdlYqDqo7FJsyxWpnaRoIY+6ygy1O/lB8Bczx+f7aImX9clBYfOf
Y2m+GOKB4WNdOXChF6sRvhoAiwY/XRNhiSVB8AjFFTz9IVNPtPWJJuZcNGrxpJrd
+NOLdEb+H7/fmgEdtrE6zHUhiDaqIzs2K9wx+eWOjMp16pJiXgcr3p3EPrbYK3nd
yzA97pXEjmfEKskaFX5yBNrrrCivI1IAYIZyg98C45Wzmt0TXVrWmGdlCGQwTvkx
tbPZlOURKpMc1fsINkp4h6NYNgeRP8xA8SKE4QXeGRQqMdQGPmFHnyZnFOXNOv4/
OUE+V79aaJMNAXWdVhcqoVPUixU5hDLXJ+c7jo7Rz4/pjSv2fONPJEoMq7HiwdRN
6DuxoaOiiWnISNab42XvupOvx3PeC438wGk3L3n+m2xTnekA7rRGczv94rWDlvUZ
E2jXcKB50fSdW8hFMSSXYEGnoh9u6+wec39YpElJu4pFkj4AZLZRboUlxFZf9AL0
bG4F0GFIJm8a1v3YjczFzKfZeKA7gYfzCM58HLeDxDYMs4s+N3o=
=kmfE
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
