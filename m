Received: from eggs.gnu.org ([2001:4830:134:3::10]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciXqI-0002O5-Ni
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciXqH-0003cd-R1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 21:48:46 -0500
Date: Tue, 28 Feb 2017 13:00:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170228020046.GN17615@umbus.fritz.box>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
	<1488205773-30436-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nTz/38/ObklNZF0h"
Content-Disposition: inline
In-Reply-To: <1488205773-30436-3-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 02/26] ppc/xics: fix ICP and ICS reset
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


--nTz/38/ObklNZF0h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 03:29:09PM +0100, C=E9dric Le Goater wrote:
> commit 5b17c7207938 ("xics: XICS should not be a SysBusDevice")
> changed the nature of the XICS object to be a descendent of
> TYPE_DEVICE. By doing so, the object is not on a bus and its reset
> handler is not called anymore. The direct consequence is that the ICP
> and ICS objects are not correctly initialized and so the IRQ subsystem
> is broken in the guest.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I've merged 1&2 into my tree, but folded together.  First, I don't
want to break bisects, second you reference an explicit commit above,
which would have been made incorrect by rebases of the first patch.

> ---
>  hw/ppc/spapr.c        | 1 +
>  include/hw/ppc/xics.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ceefbb57d0ac..3c79068075e4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -104,6 +104,7 @@ static XICSState *try_create_xics(const char *type, i=
nt nr_servers,
>      dev =3D DEVICE(object_new(type));
>      qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
>      qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
> +    qdev_set_parent_bus(dev, sysbus_get_default());
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
>      if (err) {
>          error_propagate(errp, err);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 3f0c31610aa4..1aefd3d52257 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -80,7 +80,7 @@ struct XICSStateClass {
> =20
>  struct XICSState {
>      /*< private >*/
> -    SysBusDevice parent_obj;
> +    DeviceState parent_obj;
>      /*< public >*/
>      uint32_t nr_servers;
>      uint32_t nr_irqs;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nTz/38/ObklNZF0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtNnLAAoJEGw4ysog2bOSRfMQAJlwfKq1zxPytsQj6LNQqsfa
YTGyIUaZeLjL6ZPYdD+FRebU1hdgp3sS7BDu0LwVTfFKnjwvAawlXUpDNPeN2qPU
soYQCe2plRV90BQi2Z1jr9ztCiZCqwQcjcZ12G9anvS3X+VqNoiKqxhypO0rele8
1g1l6ZRTw+InFWX0A4V0M+0/c5IRYYeIhcc6r6+euYM56B8M9aAPPXah9r1otQrw
CUnbthYEAoeKnxneWtFdMtJuMVQjEdIBRZEISo90YJm4eFAqTSUgYX6aHi+TJ+CR
XvJLpbwDJczQafOjxT1O6/RsNUqyhTB7Nyd6RDMkUEMtyJZV5M5HRvP6/A0H9HDs
aT+LmCLS6eYFx6konkQtcotZWBpMGzwWMrlSmd7p75xU4xZdhusADkTBTYRn8mOS
+p/YzsaIPNHEbqXjbKteFwa6T2ooQbivNdx1WyuTCaOmRB3x5crE5ZrdirPhNPR/
XrLrbYr8VZWdoRfFg9HNiMa50MBZ37KgfudSYrTwDNaHYjIrzz1ZdhoeqE3NkVvU
6uJLbUSy+kweCseupFkQR5YixOQBuvEJIO8BqhvwP5I/zPTav2NqSp3p0SVGGLxN
0nY6OlwhU6M1Oho1UYTYxpXowaksPD4ZhkWyjyaO5i3w+KNeoWN3h1pu1TJZkTNb
o9wBvSYL47yEYSTfGYBy
=DYoy
-----END PGP SIGNATURE-----

--nTz/38/ObklNZF0h--
