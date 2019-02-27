Received: from eggs.gnu.org ([209.51.188.92]:34774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gysWF-0000s2-Gv
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gysWC-0003f0-4C
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 01:16:39 -0500
Date: Wed, 27 Feb 2019 17:16:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190227061611.GB6872@umbus.fritz.box>
References: <20190227043008.12059-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qtzb1h6tVL0ohdDu"
Content-Disposition: inline
In-Reply-To: <20190227043008.12059-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v2 1/4] target/ppc/spapr: Add
 SPAPR_CAP_LARGE_DECREMENTER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, clg@kaod.org, qemu-devel@nongnu.org


--Qtzb1h6tVL0ohdDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 03:30:05PM +1100, Suraj Jitindar Singh wrote:
> Add spapr_cap SPAPR_CAP_LARGE_DECREMENTER to be used to control the
> availability of the large decrementer for a guest.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This series looks good now, except for one nit...

> ---
>  hw/ppc/spapr.c         |  2 ++
>  hw/ppc/spapr_caps.c    | 17 +++++++++++++++++
>  include/hw/ppc/spapr.h |  5 ++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b6a571b6f1..acf62a2b9f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2077,6 +2077,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
>          &vmstate_spapr_dtb,
> +        &vmstate_spapr_cap_large_decr,
>          NULL
>      }
>  };
> @@ -4288,6 +4289,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB */
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D 0;

=2E.. since this is now a boolean, it should use SPAPR_CAP_OFF /
SPAPR_CAP_ON instead of bare 0 and 1.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qtzb1h6tVL0ohdDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx2KysACgkQbDjKyiDZ
s5KSdRAAw+9GGyEpbaCZbjeCbr166+uGG2IMNnLrm2AoF8XKYDDlmbsG0+QrOpAC
TMqp8+1JK7YeQo/gxUB1vsBHj1aC/l8EY7bxpUzT+79SrFTQ63hwbAvTsWfsjw5B
SzVRt7b4I+GivK2Tof/DOLXapxUAkBrWHcXOyzPF0wmGPIqXDJmLG++cfgSAJnBf
Tr/Rhye8xOXux4CQ3WJ+igBp9KsKPRT5eZok1Fta44Mhy46Jqahiaw51+diUibZ1
Lz5LPDHgSEUh1WOzP2EutApK5SILRPjko4N9VpgL4mZHwXP3MtqY8M4RchFIqp98
1lHSoVMthOcY2G7ppE/QqgHChyufuJVACspWI8DaBK0YjN+McXwrd1Ymat3Kbp9z
1s1Y2QLmOiV0umK6kTqzBbS2wv3ZVQc/yvC6F6VLa30gI3iwm8KCSPileGrwONGG
l1Pqu8p8ld8fdzz0eTKPfCu1qs7zO7RVlQKDCkRg9vzJMjCrG9m6zdH7A1i8cKmO
ISlZxOIfonW1gKWLKtyUoXpiuaENyFVr2Ejr2KyD6P/vcjzaquGPwWvQFQ+i2ajt
aosfsCSPDLLv77bUaNJMh3wgR62J8LMQ+IV+hFR/dSaCR3aKPRiQ+VFZHqgSVMN2
pd/dqaeGNsxC2wMWU347U0I5Ku3TOsBQKnzyAHsy9y+7HHCpbUU=
=h6qy
-----END PGP SIGNATURE-----

--Qtzb1h6tVL0ohdDu--
