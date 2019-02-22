Received: from eggs.gnu.org ([209.51.188.92]:58108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxGKh-0001DO-1C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxGKg-0001pf-Aw
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:18:03 -0500
References: <20190219125044.5416-1-berrange@redhat.com>
	<20190219125044.5416-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f70b06ee-d5db-f1cc-35f4-5e34226b429c@redhat.com>
Date: Fri, 22 Feb 2019 20:17:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190219125044.5416-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ioue32ORHIO9QlM71PtikoVXcW4ES0T3I"
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: fail if encryption opts are
 provided to non-encrypted image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ioue32ORHIO9QlM71PtikoVXcW4ES0T3I
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f70b06ee-d5db-f1cc-35f4-5e34226b429c@redhat.com>
Subject: Re: [PATCH 1/2] qcow2: fail if encryption opts are provided to
 non-encrypted image
References: <20190219125044.5416-1-berrange@redhat.com>
 <20190219125044.5416-2-berrange@redhat.com>
In-Reply-To: <20190219125044.5416-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.02.19 13:50, Daniel P. Berrang=C3=A9 wrote:
> If the qcow2 image does not have any encryption method specified in its=

> header, the user should not be providing any encryption options when
> opening it. We already detect this if the user had set "encrypt.format"=

> but this field is optional so must consider any "encrypt.*" option to b=
e
> an error.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  block/qcow2.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 65a54c9ac6..ecc577175f 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1045,6 +1045,12 @@ static int qcow2_update_options_prepare(BlockDri=
verState *bs,
>              ret =3D -EINVAL;
>              goto fail;
>          }
> +        if (encryptopts && qdict_size(encryptopts)) {
> +            error_setg(errp, "No encryption in image header, but encry=
ption "
> +                       "options provided");
> +            ret =3D -EINVAL;
> +            goto fail;
> +        }

Doesn't this make the block right before this one a bit superfluous?

Max

>          break;
> =20
>      case QCOW_CRYPT_AES:
>=20



--ioue32ORHIO9QlM71PtikoVXcW4ES0T3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwStQACgkQ9AfbAGHV
z0AcTQf+PN2PYZmv1HJcmDAmtg5nIrbDKqEB1HAcCMbxJKOUZoXvKW0+NLCMU52J
VzQBXRxPySi26+4np2PxyUpNYxwugbx1/8Eb59ZuV/sFxgY94L54ZEBb0PUdJjM9
7LQuF4EJyYkLLXxJPqVlmIOCKqDOmYbiacwKauVKYMuWaA9zBFaOyhAJWLSZly6Y
IPkwXr4o2JqDITCsSgb6VhkGqJSC4YG838uJHWVj9RtvFnN3AI1X4w/kSm1Zdxfb
K5ERDwUEknVHD9WcYZ40RA1k3pXWDR4qqX0eOVfZXBUu+gZMQI+2B8yPKip2URq6
h+yHionH+Wvo0iYmgSVEso8LI7Fprw==
=cAGS
-----END PGP SIGNATURE-----

--ioue32ORHIO9QlM71PtikoVXcW4ES0T3I--
