Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdll-0000FD-R7
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fXdlk-0004mu-R2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:31:49 -0400
Date: Tue, 26 Jun 2018 12:21:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180626022129.GI22971@umbus.fritz.box>
References: <20180625091718.18544-1-clg@kaod.org>
	<20180625091718.18544-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
In-Reply-To: <20180625091718.18544-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] ppc/xics: move the instance_init
 handler under the ics-base class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 25, 2018 at 11:17:15AM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xics.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index d6066d561fdc..83340770f7c0 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -611,13 +611,6 @@ static const VMStateDescription vmstate_ics_simple =
=3D {
>      },
>  };
> =20
> -static void ics_simple_initfn(Object *obj)
> -{
> -    ICSState *ics =3D ICS_SIMPLE(obj);
> -
> -    ics->offset =3D XICS_IRQ_BASE;
> -}
> -
>  static void ics_simple_realize(DeviceState *dev, Error **errp)
>  {
>      ICSState *ics =3D ICS_SIMPLE(dev);
> @@ -655,7 +648,6 @@ static const TypeInfo ics_simple_info =3D {
>      .instance_size =3D sizeof(ICSState),
>      .class_init =3D ics_simple_class_init,
>      .class_size =3D sizeof(ICSStateClass),
> -    .instance_init =3D ics_simple_initfn,
>  };
> =20
>  static void ics_base_realize(DeviceState *dev, Error **errp)
> @@ -679,6 +671,13 @@ static void ics_base_realize(DeviceState *dev, Error=
 **errp)
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>  }
> =20
> +static void ics_base_instance_init(Object *obj)
> +{
> +    ICSState *ics =3D ICS_BASE(obj);
> +
> +    ics->offset =3D XICS_IRQ_BASE;
> +}
> +
>  static Property ics_base_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -697,6 +696,7 @@ static const TypeInfo ics_base_info =3D {
>      .parent =3D TYPE_DEVICE,
>      .abstract =3D true,
>      .instance_size =3D sizeof(ICSState),
> +    .instance_init =3D ics_base_instance_init,
>      .class_init =3D ics_base_class_init,
>      .class_size =3D sizeof(ICSStateClass),
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsxoykACgkQbDjKyiDZ
s5K05Q/+L81LNNwaXj7MYsRxmKhZlcEwjKhyJ14XDFI9TOCGVQsWNkF3b4FJK3Jn
sOKZBKuP5zn+TPl3sNV9YIDo0gvc9nibrL/56YFO+3ufkznvlHT7IX4+j4lJPvCg
ueRwRNQyJ7f0jNvRXz2gaQLi+Ifh81ekDVRk8Kg+Cy5CwK9z/2KCvMCTXk64pi+X
ptf5mKh24LP4DFgUKtHJe3+4lFKcLu5KK2WFhu67xQVkuIhhhlTzO47QWnn3FoD8
nuvDZsWPkwGQnMYgQvxBRlfv64Z+0K/OFqqxSxh3uOGDkqumFgYSA3F1SFzJht9B
ZdxThDol6K3zbkqGR0CtrBHERJUTvxfVkvlsJICkXqbK8oyG3MhrxWECdEbMSGFK
akLITGnOwNiqa3QgVKXgFO60dy9Oo0wYAV9l6/aY7M/rUqicIgWSAWYnXsURkoop
qgtmL+C+gzMLE8NnZ9mF7v/mMSXneRY94wCJ1EmxBTDLzfq5ltSnw7f3UAziURy1
WVe30/XLyjzhcYcx/kdrpXtMU7gddnVWtWfItzGw043qxXKSzW5i/xqhKa18F1Yc
G4WglcsAZlxiYTDq+/5knox+gILjCRFy8pbQF8DjCpsx5bvcpd2LlyedMlWclXAS
hwoSqsPYIjL/tw/XUxz2bslPnBomcOfUzwc5kbt05jJkaA0MExM=
=Ax+X
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
