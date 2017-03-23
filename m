Received: from eggs.gnu.org ([2001:4830:134:3::10]:45936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEs-0001rh-Hk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEr-0005oK-94
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:42 -0400
Date: Thu, 23 Mar 2017 15:10:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041037.GG19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-4-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-4-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ppc/xics: add a realize() handler
 to ICPStateClass
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


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:07PM +0100, C=E9dric Le Goater wrote:
> It will be used by derived classes in PowerNV for customization.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c        | 5 +++++
>  include/hw/ppc/xics.h | 1 +
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 5cde86ceb3bc..7cd842102265 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -348,6 +348,7 @@ static void icp_reset(void *dev)
>  static void icp_realize(DeviceState *dev, Error **errp)
>  {
>      ICPState *icp =3D ICP(dev);
> +    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
>      Object *obj;
>      Error *err =3D NULL;
> =20
> @@ -360,6 +361,10 @@ static void icp_realize(DeviceState *dev, Error **er=
rp)
> =20
>      icp->xics =3D XICS_FABRIC(obj);
> =20
> +    if (icpc->realize) {
> +        icpc->realize(dev, errp);
> +    }
> +
>      qemu_register_reset(icp_reset, dev);
>  }
> =20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 9a5e715fe553..0863e3a079f5 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -60,6 +60,7 @@ typedef struct XICSFabric XICSFabric;
>  struct ICPStateClass {
>      DeviceClass parent_class;
> =20
> +    void (*realize)(DeviceState *dev, Error **errp);
>      void (*pre_save)(ICPState *s);
>      int (*post_load)(ICPState *s, int version_id);
>      void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00q8AAoJEGw4ysog2bOSOOsQAL+LIjVNQOX08pdY3lXXNrVg
AtrTJ2xmHtgSzhMa8B68P7yJNMAGlC3vpVgk6cVnKwGpt43RnBcHLU6WfAb6Ji2O
TxMyJwW9vy24rBV258o0ZFCjIg5LQmMafmexWimvdOlwbczRp/P4bvPWwXw2aRtf
+hPOXq9HdIBP4vS+VlEYiYR3Duy6Hrp2jgF7sEHoKkb03DAIv0vJhG79TkZjWBUm
4p7qSbFNVBJ6vqfv5eLNVloZat44N9EpN1vP6avrxQmuq+vg7X2lXq4myseMtj1v
aiIWwgfNezTXbTw10EOC54YCar9ef/ravIHpv8R00B2P8lJznpkepM8WtU9nkWc8
2lwIy+rJvE6Fw0Ao499trExT9OjTig69SLm6RGvRpFAXW8QlUP9cEMHsF+HXhUsN
/TOtbHjcVzuwLMnFJ7B5ksF5JdF1No36mZvK0NPAYNLR1DDWW83iB5/Y+V5qDWFL
uwqJLdhT/v7BvvU3CEw0LYBhlhT24LQLPOj/anrIqvdHq/qhi1jX4Xdkfi6zFSj0
RILGY+JmyQiLuicCEq+ejxa6FiESNvIHv5sg2xgnGPeLa7yVxC4173gac9ZlMGTa
8Skjrf8hh8Q8Rpobdsn5f1wjeQWJQkcfJfZgIQqwgpI4PZcomQvwjcwxiaL+Ta4c
jlaiR2udWTNLYZVREyJD
=K9vV
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
