Received: from eggs.gnu.org ([2001:4830:134:3::10]:44267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MzO-0000J9-12
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3MzN-0002cc-3L
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:28:14 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48ac644a-441b-134a-7d4c-fb3239fb5e0f@redhat.com>
Date: Wed, 26 Apr 2017 08:28:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V3bUKfp3kANaGrOOSogX2CfhKOIih3cvu"
Subject: Re: [Qemu-devel] [PATCH v6 02/18] block: add ability to set a
 prefix for opt names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V3bUKfp3kANaGrOOSogX2CfhKOIih3cvu
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <48ac644a-441b-134a-7d4c-fb3239fb5e0f@redhat.com>
Subject: Re: [PATCH v6 02/18] block: add ability to set a prefix for opt names
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-3-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> When integrating the crypto support with qcow/qcow2, we don't
> want to use the bare LUKS option names "hash-alg", "key-secret",
> etc. We want to namespace them "luks-hash-alg", "luks-key-secret"
> so that they don't clash with any general qcow options at a later
> date.
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 16 ++++++++--------
>  block/crypto.h | 40 ++++++++++++++++++++--------------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 8205bd8..7edcc49 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -129,7 +129,7 @@ static QemuOptsList block_crypto_runtime_opts_luks =
=3D {
>      .name =3D "crypto",
>      .head =3D QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.h=
ead),
>      .desc =3D {
> -        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET,
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),

Is this still needed, given your cover letter said you reworked things
to use a nested struct?  I'm still not convinced we need the complexity
of two different prefixes if we can instead reuse a common structure.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--V3bUKfp3kANaGrOOSogX2CfhKOIih3cvu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKBkAAoJEKeha0olJ0NqoqMIAIRyxT2VPuCMTjbkqzaJqWp9
O7Dmuof4YEmeFNIz+55/tKo97ezLbF44OVsUFsHLmVNjCxPTPrNn2HIDJ5WgnE0v
7nOPqoPHxFarfqcxPmpv3voFq+wdIk10hLEG7DEtYwJb31x7vvv3wO20tkv/7jkI
G26M9iUjt1NGo1ccCcdHGFEaDjULyEnIHwjlsgfkwAzGd8szOMbBEduHyLCkyBeD
u5ZkQXGerrSEk2gqDuNnkSgulna84iMs2d4LqZQftqY4FE8duvnuWqALm+EfL8Bf
Ku3lB3KMGWqI2F6ltv3g2bsK4ELb+JsXDfAdtSstGZ27vZHvkEn+j7hDV69oSJM=
=xjn9
-----END PGP SIGNATURE-----

--V3bUKfp3kANaGrOOSogX2CfhKOIih3cvu--
