Received: from eggs.gnu.org ([2001:4830:134:3::10]:46299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5Il-0001lm-O6
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5Ik-0006iS-SY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:12:47 -0400
References: <20170509173342.29286-1-berrange@redhat.com>
	<20170509173342.29286-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6b92aaba-2421-0d8b-405c-c72eaa704d14@redhat.com>
Date: Wed, 31 May 2017 17:12:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170509173342.29286-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qu8lmbHFssiuapWQk2x0I1RbxjICsI3nr"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] iotests: skip 159 & 170 with luks
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qu8lmbHFssiuapWQk2x0I1RbxjICsI3nr
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <6b92aaba-2421-0d8b-405c-c72eaa704d14@redhat.com>
Subject: Re: [PATCH v5 1/5] iotests: skip 159 & 170 with luks format
References: <20170509173342.29286-1-berrange@redhat.com>
 <20170509173342.29286-2-berrange@redhat.com>
In-Reply-To: <20170509173342.29286-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-09 19:33, Daniel P. Berrange wrote:
> While the qemu-img dd command does accept --image-opts
> this is not sufficient to make it work with the LUKS
> image yet. This is because bdrv_create() still always
> requires the non-image-opts syntax.
>=20
> Thus we must skip 159/170 with luks for now
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/159 | 1 +
>  tests/qemu-iotests/170 | 1 +
>  2 files changed, 2 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qu8lmbHFssiuapWQk2x0I1RbxjICsI3nr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLt1mEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQH6b
B/99ydfRtQHjr6ch7vEqxyWFf9OkAcXAoydfAR5SfALl0MppKx6Eb2qo3UM+Iqcw
uiPCFOKl2gWTMOUjVmSrT7rSEvSOWJpufK3NpJEY3MtMOQa3TxtmjrgY3kuJZSex
yEZ5nhSuJZF/jgzqbqaZLHHaupVzjjoBPNv+JrvV9IUmK+HygTZlZhNB8y4bDa7Z
sYITjIfy3QsgnTh8EDy3DzIVS6I077MufXLe5vaP11iGAOu3BluJeThb3mrkIMN5
hDNTNVu0OSsU4P6mtJdlv4ybT58s4w37VozVptEsouVQZN8qO2UulzhJePGUtLzC
dtHO5wdoq8mJFRw5QkGu9qSD
=C2vt
-----END PGP SIGNATURE-----

--qu8lmbHFssiuapWQk2x0I1RbxjICsI3nr--
