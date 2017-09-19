Received: from eggs.gnu.org ([2001:4830:134:3::10]:51166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtW-0001Fe-3C
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtQ-0002nI-LC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:46 -0400
Date: Tue, 19 Sep 2017 12:27:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919022719.GH27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
> Start with a couple of attributes for the XIVE sPAPR controller
> model. The number of provisionned IRQ is necessary to size the
> different internal XIVE tables, the number of CPUs is also.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

[snip]

> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> +
> +    if (!xive->nr_targets) {
> +        error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
> +        return;
> +    }
> +    /* We need to be able to allocate at least the IPIs */
> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
> +        error_setg(errp, "Number of interrupts too small");
> +        return;
> +    }
> +}
> +
> +static Property spapr_xive_properties[] =3D {
> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),

I'm a bit uneasy about the number of targets having to be set in
advance: this can make life awkward when CPUs are hotplugged.  I know
there's something similar in xics, but it has caused some hassles, and
we're starting to move away from it.

Do you really need this?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAgIUACgkQbDjKyiDZ
s5L+rBAAmAVmfwpg/Mu3PyF0r9QdN/UXse+wzlGBuDwPo1tj1TTvvz+Dobm+ICG0
7rliFC04bgUo78jhExRTQtOv0tQOBhDGqnOQz6PoTbeJkdjDSiQMeBHfD0lk6O3d
wV38MDZ6emoKN2U7azTkr3LEi24jq4m+hmYlaKgpWNd4j+8+FtvYKFRJmsHfk8a5
k+GKkrAn89fRNSiXHpTw206jgmuhF2+EgYFV7BU2vpQ/5qQgaXsEqUxWBv4DSgAQ
J9585swlUYZsxf1uHhbaQsP4qt/9fckWVzuOwDYGlLApGN0CpPGjntuYHNIVpioE
5xcxVnhlgd9HAvMvLHXC01smSX5e5591KTXnVEAbmHWH7bclfveZ6RdVlr+bGbqM
2L2vge98QtEJE4uVZiE0O764aSY4bf6PoO15oRBzqrNntNPjxyIwDuyjLK2bCvly
z0dtNeiCTMpr01rotWQCLQUH43JLnyXrKPB1VHph8xTz3DnKzQJHwbGvwEvMWxuC
Qi8rj1mxQ6E3nrDd/gbZZhBUbDvR7kjMyDiRVsQjmvlljZZR2LuXrRuyD/nwjWB2
Bv3TSNXo76Pir9RiJmX70BzyXcsUsb46GsgZYIIZwsDHM3wWGYeFyA3SlyfltYQC
gI4RpN6+glOtmtnFu2ZfhnSfzPL7OCU3Y+dDgltnw2gfanF/J7Y=
=iei+
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
