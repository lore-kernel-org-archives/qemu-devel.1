Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzgPt-00037Z-Mr
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzgPp-0004Ik-NF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:56:37 -0400
Date: Wed, 4 Oct 2017 20:42:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171004094226.GX3260@umbus.fritz.box>
References: <150710659849.14714.9839994452901108634.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U7NLafZe7Bh9OCap"
Content-Disposition: inline
In-Reply-To: <150710659849.14714.9839994452901108634.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr: fix RTAS method name in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--U7NLafZe7Bh9OCap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 10:43:18AM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied, except I corrected the short description.
ibm,client-architecture-support is an OF word, not actually an RTAS
method.

> ---
>  hw/ppc/spapr.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 352ff3d614e8..b284e0b9d43e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2334,7 +2334,8 @@ static void ppc_spapr_init(MachineState *machine)
>      /* Set up Interrupt Controller before we create the VCPUs */
>      xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> =20
> -    /* Set up containers for ibm,client-set-architecture negotiated opti=
ons */
> +    /* Set up containers for ibm,client-architecture-support negotiated =
options
> +     */
>      spapr->ov5 =3D spapr_ovec_new();
>      spapr->ov5_cas =3D spapr_ovec_new();
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U7NLafZe7Bh9OCap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnUrQAACgkQbDjKyiDZ
s5Ij7RAAm++/oCxiBZdyFo1olxPsmDqa5J7w9tGWJTsOEMFkXx4CFsoFa5q8bP/3
LA3ANOOFcZShweAnhpimQ1beIb4Tzf54sJs8CngShW5cQXHQKU0nxt7wACr/ByfM
zqLVb9OA8sWseB/veJswvZGGg6Bpcoc/5wY5AJvV2Duc2Skkt/6oo5r5Fm1ioLfO
qeUnpfr+vlNdtjH1hiT6rZgH07XnesgnuYTTG6w+sDNR9CeyGhrOLZbxtFTr4AmF
fp1RYQWZVaXtJjBk0cL1+ZKMN3h5kZeV+D2k5EcF24Osnl3qmg3RV5j58+L4Qstg
5H5UwvcCZmLVuBHZAjY5PsNGWDUBw0evIHPWKIMisc18BEWi4Qpxlns16BSVJcLj
zgK9otQTlbdyg/zbXNXKgRMlahALLtKYLopMO+hRSzTXcPVk/3Q9REOSGg1CPXm6
tytjL1Dw4n2bVKCzfHyZeNvNSwaL7Avek8MrX1xjs6e9kscnICzSO9n5SghCNBwv
5tNIRvnKE0JpHcvVZXOk+GZOshdpwDCMlfZKFx3iNeaAVdCvx6NmiUULIL7HGHVJ
0fL1LqWC3Ezt6sK3X1CK3FEXganQ+i+u22+QeqfYES1nzIdcoU8uqMHsvFyVtpMK
dJEGfx7Ob4vWxKKb7j9lByrh3UnJM5qZJCX3hr8gRd8erApD30I=
=av1G
-----END PGP SIGNATURE-----

--U7NLafZe7Bh9OCap--
