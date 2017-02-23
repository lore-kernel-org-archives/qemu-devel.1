Received: from eggs.gnu.org ([2001:4830:134:3::10]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003wO-6O
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkc-0005Lu-Jd
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Date: Thu, 23 Feb 2017 13:33:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223023312.GY12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-11-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-11-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 10/22] ppc/xics: register the reset
 handler of ICS objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:33PM +0100, C=E9dric Le Goater wrote:
> The reset of the ICS objects is currently handled by XICS but this can
> be done for each individual ICS. This also reduces the use of the XICS
> list of ICS.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c | 5 -----
>  hw/ppc/spapr.c | 1 +
>  2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index bfd3a539561a..d679313cd49f 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -139,16 +139,11 @@ static void ics_simple_pic_print_info(InterruptStat=
sProvider *obj,
>  static void xics_common_reset(DeviceState *d)
>  {
>      XICSState *xics =3D XICS_COMMON(d);
> -    ICSState *ics;
>      int i;
> =20
>      for (i =3D 0; i < xics->nr_servers; i++) {
>          device_reset(DEVICE(&xics->ss[i]));
>      }
> -
> -    QLIST_FOREACH(ics, &xics->ics, list) {
> -        device_reset(DEVICE(ics));
> -    }
>  }
> =20
>  static void xics_common_initfn(Object *obj)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 85a973cce7ae..a2a64d7de41d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -112,6 +112,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
>      }
> =20
>      spapr->ics =3D ICS_SIMPLE(object_new(type_ics));
> +    qdev_set_parent_bus(DEVICE(spapr->ics), sysbus_get_default());
>      object_property_add_child(OBJECT(spapr), "ics", OBJECT(spapr->ics), =
NULL);
>      object_property_set_int(OBJECT(spapr->ics), nr_irqs, "nr-irqs", &err=
);
>      object_property_add_const_link(OBJECT(spapr->ics), "xics", OBJECT(xi=
cs),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrknoAAoJEGw4ysog2bOS7oYP/3AmKc9o/c5VACO9RCnvSB3O
pe4BleJhN7h06Ts1BTnZoqBd0yN0p+ywF4PcCjvpAvaaxwRJPkZ9lq+yWrbP3Qk2
TysAQzhrhCB9Y9mfjUkQ2tLgTAVgLh52D6m2t8xUhQE4ZNKn9frsj0pnWxFSb3/v
AzOaUpfqaud1d+PpQ490eg0oUZ42ftW+NeaN+IPJvSvnyzyS6n9WxUYRkHFsIo+Y
hr8PE8HhU/FaazSmPRfois8ztNEH342K3QJnSMYphtWJkdFlQIaN55D3wzK3IXqd
1NR1+Py4i5RbqYv9FeuBv5c7LMJMQQPJXKxLfz9FDQym1O9EKxL2hWJLkx6z8AmN
HibmUaGhl+Q1PYzlaygayLVWeHa4ntH/ZquuVk7/mDhiY2E+z4NOEUkZ5fB9dlkE
dfrfB5TdGKqoJoEX18wYUMEp/14Kprgi7dGjT4LkNBscpBM0oSiBfHtfj0KK3Zfd
jqRWPgK9SKp4QPXTqEmLXD/O78DLIrrnmJKd1fUe5ESLh9+2EpaI4v2eWTEgstrg
oZgwYlEsFxAhfgNWuALYkzqO9yvs/JqgJPdMR85bplgyr4GRydU0hEjIyncnZjyh
o1zgrcBjVI/NT29BQmFJgeKyXUkqxwiz4nvin4fn9K7bwvLVOnKXIqSoKuUT27iy
rkMw8RkN7QAG6huj1B/X
=2qtM
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--
