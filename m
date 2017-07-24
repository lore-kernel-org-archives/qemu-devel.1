Received: from eggs.gnu.org ([2001:4830:134:3::10]:58906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVgf-0003aT-KG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZVge-0008Dp-ID
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:13:45 -0400
Date: Mon, 24 Jul 2017 15:11:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724051151.GG17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-11-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-11-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 10/26] ppc/xive: record interrupt
 source MMIO address for hcalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:23PM +0200, C=E9dric Le Goater wrote:
> The address of the MMIO page through which the Event State Buffer is
> controlled is returned to the guest by the H_INT_GET_SOURCE_INFO hcall.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c        | 3 +++
>  include/hw/ppc/xive.h | 1 +
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a1cb87a07b76..0db97fd33981 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -344,6 +344,9 @@ static void xive_ics_realize(ICSState *ics, Error **e=
rrp)
>                                  ICS_BASE(xs)->offset * (1 << xs->esb_shi=
ft),
>                                  &xs->esb_iomem);
> =20
> +    /* Record base address which is needed by the hcalls */
> +    xs->esb_base =3D x->vc_base + ICS_BASE(xs)->offset * (1 << xs->esb_s=
hift);

This doesn't seem like it needs to be stored in the persistent object
- it can be calculated when the hcall is made.  Plus if it's for the
hcll it only makes sense for spapr.

>      qemu_register_reset(xive_ics_reset, xs);
>  }
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 1178300c9df3..b06bc861b845 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -43,6 +43,7 @@ struct XiveICSState {
> =20
>      uint64_t     flags;
>      uint32_t     esb_shift;
> +    hwaddr       esb_base;
>      MemoryRegion esb_iomem;
> =20
>      XIVE         *xive;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1gZMACgkQbDjKyiDZ
s5J+gBAAwYzFs6b58RkeuWyc41fYmQsm8zsCUoM1Gt0MTAuNvb7WALo52/MS4Req
n5SZGGvVNCapBW127r+wf8bag+p9YVetQvU+0GSZXVbySEwOzmDx06ioIs/VcM3l
E0f9nNUkkpywQCoYkAgcTJDeOB7c0KYdgnQ8jRC3tdMg3O9NngXhWWP+dADWjtzz
mKtrjsfsuvg11pElSbf2NdLZZtTUAVNSqDV131s28U855VK9mM7TrG3fhEYcQp51
mWeDYsdjo7BULfmJq94/F0ufdNS0TXRSlY9MqWR67WLnDBrcDf/U68r1Z09cdpLO
uICEUvzf269/6kcaBiDsbAcyoVwKd4xz1+07owsuNiwnPg5y3bmHvSaSdBcbJNJY
7/NdSWMConiExsncV5ASfBlAJY9duSeAnwieRpfEI2k7id0GvjuWm9p8AUZln+og
VxyJttHig/yeeMgSdWbOPYxoBeuoe4e4wpWU/eyzuI4MROHjv3M5lBeWMwBGD7A6
ccsjBwWlj4x3aNZque3NB/QgJ756uOAuIY/+PKyQNDf5i74tyHDecff1HfdBkU/q
VmZhghvOZUYqi8dgAwEF9cElvOWYeepitYRAsSfdK0C3Qdl+lyFBaNGRziRJBjoH
sAL32m36otI/1SnsJjRk/M4fH3JU98yxVULRCZ9zWm53Z15UNWI=
=Pb0O
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
