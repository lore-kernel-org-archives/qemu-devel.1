Received: from eggs.gnu.org ([2001:4830:134:3::10]:36453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTdK-000479-9u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciTdJ-0006kM-5v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:19:06 -0500
References: <cover.1488220970.git.jcody@redhat.com>
	<871655967d4f29e1357abe088df38270e95f5f19.1488220970.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9452f3c1-1f9f-f508-1711-1e8eb5a5c2f1@redhat.com>
Date: Mon, 27 Feb 2017 16:18:57 -0600
MIME-Version: 1.0
In-Reply-To: <871655967d4f29e1357abe088df38270e95f5f19.1488220970.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iClDsaTvCPl17RbaFBsfdsqocBCTwiWbQ"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] block/rbd: add all the currently
 supported runtime_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iClDsaTvCPl17RbaFBsfdsqocBCTwiWbQ
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com
Message-ID: <9452f3c1-1f9f-f508-1711-1e8eb5a5c2f1@redhat.com>
Subject: Re: [PATCH v2 2/5] block/rbd: add all the currently supported
 runtime_opts
References: <cover.1488220970.git.jcody@redhat.com>
 <871655967d4f29e1357abe088df38270e95f5f19.1488220970.git.jcody@redhat.com>
In-Reply-To: <871655967d4f29e1357abe088df38270e95f5f19.1488220970.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 12:58 PM, Jeff Cody wrote:
> This adds all the currently supported runtime opts, which
> are the options as parsed from the filename.  All of these
> options are explicitly checked for during during runtime,
> with an exception to the "keyvalue-pairs" option.
>=20
> This option contains all the key/value pairs that the QEMU rbd
> driver merely unescapes, and passes along blindly to rados.

Maybe worth adding a comment that keyvalue-pairs will NOT be exposed in
QAPI in the later patches, making it command-line only and
non-introspectible.

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/rbd.c | 62 ++++++++++++++++++++++++++++++++++++++++++-----------=
--------
>  1 file changed, 43 insertions(+), 19 deletions(-)
>=20

> +static QemuOptsList runtime_opts =3D {
> +    .name =3D "rbd",
> +    .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> +    .desc =3D {
> +        {
> +            .name =3D "filename",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "Specification of the rbd image",
> +        },
> +        {
> +            .name =3D "password-secret",
> +            .type =3D QEMU_OPT_STRING,
> +            .help =3D "ID of secret providing the password",
> +        },
> +        {
> +            .name =3D "conf",

Is "conf" the best name, or do we want "configuration"?

> +            .type =3D QEMU_OPT_STRING,
> +        },

Worth documenting all the options?

I'm not seeing where "keyvalue-pairs" is used yet, but assume it is in a
later patch. But assuming the QAPI version in a later patch matches,
other than keyvalue-pairs, I think you're okay.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iClDsaTvCPl17RbaFBsfdsqocBCTwiWbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtKXRAAoJEKeha0olJ0NqAlsH/0myHyjTQCp+yIB0IPc2t99i
OsESSvdPF1CuyYviY/Rrt9zINF9w2dUrwea+t8Hkn61bIQe1WJwcYnJ2WRCQhISs
Eb3Z5LTVh67YbIQg2Qr5xA5/LdIf0iXj95LkdQGaXb8Xt/suqxzGleFo7b/34IMk
viHr2XLiAmMENyGpY/lBYUm1pN4u+JeUPhBIC+Mk9D5uhhxEeuFB/lkjPtsexQX6
MA5xjli3vd6gbnrFjMwA2lq/bnzRBAVcsJFWQcRWbVvFjpvVU6OLw++BS4kLKjfl
Fh3g7jzwG28JQXrHBVbs4gMx4FutzYC8HthezijA/U4x39WE/7dct/H786GpVZA=
=J9og
-----END PGP SIGNATURE-----

--iClDsaTvCPl17RbaFBsfdsqocBCTwiWbQ--
