Received: from eggs.gnu.org ([2001:4830:134:3::10]:37656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uYw-0000Mx-TI
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uYv-0006uM-QU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:23:42 -0400
Date: Thu, 5 Apr 2018 12:23:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180405022334.GG20851@umbus.fritz.box>
References: <20180405020738.35865-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20180405020738.35865-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] spapr: Initialize reserved areas list
 in FDT in H_CAS handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 12:07:38PM +1000, Alexey Kardashevskiy wrote:
> At the moment the device tree produced by the H_CAS handler has no
> reserved map initialized at all which is not correct as at least one
> empty record is required to be present as a marker of the end.
> This does not cause problems now as the only consumer is SLOF which
> does not look at the reserved map area.
>=20
> However when DTC's "Improve libfdt's memory safety" changeset hits
> the QEMU upstream, there will be errors reported and crashes observed.
>=20
> This fixes the problem by adding an empty entry to the reserved map,
> just like create_device_tree() does already.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-2.12, thanks.

> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c0be8c..a81570e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -865,6 +865,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState *s=
papr,
>      /* Create skeleton */
>      fdt_skel =3D g_malloc0(size);
>      _FDT((fdt_create(fdt_skel, size)));
> +    _FDT((fdt_finish_reservemap(fdt_skel)));
>      _FDT((fdt_begin_node(fdt_skel, "")));
>      _FDT((fdt_end_node(fdt_skel)));
>      _FDT((fdt_finish(fdt_skel)));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrFiKQACgkQbDjKyiDZ
s5LvbRAAuTPR5tBHrYAH8sYbNMvEzOgo1WwMpPcF8cNg9ZbSHpJ0GZRbMLN772Fs
XaYGVi8xNS/A8pjOPG9la3TsZ75APdIPEH0giN09CDimMUQd/TlMpESIlvynWhvG
N7KCg32CNrri8z5SXSMW3tjY5grE8PnnFKrpJGdANdfDpT7Cwb8Dkl5aTAk/Ki6P
TAlpxuytEmw6ded2Pc4A56ckZN6h4MIgONu/kH+nKOgZkFBoZjZGe9QbYdvAVSiV
SWrQIgX2Iq4H/I24OFSkJYWnjT92cjaihZeeUtMUUNco9BNhaFaabSS1Kjls5s5d
B7out75gUjWmNrWHrxkWTWC4nKhPr+ssoySTOhSm5HPetinR7tDJHiTlcwsdFBhY
s7OkeO10GB7tfm8I7JhBWt2GTSZxdNW1jKOoieFMKtOy6uFBELG9c5a1ecH21sIi
fOswzNh0mfqMNuRcLvfubSrjM7WW6phZMiXvfrQS7l2VqxTaxuZJWLvTg0PBrDvB
b3P7W7iR5UQhPEa9OZI++rHw1C0xD0ry/uKK+A+yAx6RPiaaZ0uwjKrIh3HIBpVb
l6vHlO87ntm2lbuPvWepNx4BbCTxr+bVqj0jm+8bff/yOU6//2jLSu6A29Lmng00
/nUv7PtlTh1NxbuxvNMip2uRtvo63Pz1KuspqFc51qnHuAPmz3A=
=wJXh
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
