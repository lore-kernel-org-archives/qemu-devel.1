Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Niq-00031E-Jf
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Nim-000577-IN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:15:12 -0400
References: <20170425153858.25660-1-berrange@redhat.com>
	<20170425153858.25660-8-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37afd84b-2183-8c99-c810-87a60c528d96@redhat.com>
Date: Wed, 26 Apr 2017 09:14:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170425153858.25660-8-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2wDOqTAtbqLUSkbx14SggEISNpcFvr1he"
Subject: Re: [Qemu-devel] [PATCH v6 07/18] block: deprecate "encryption=on"
 in favour of "encrypt.format=aes"
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
--2wDOqTAtbqLUSkbx14SggEISNpcFvr1he
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <37afd84b-2183-8c99-c810-87a60c528d96@redhat.com>
Subject: Re: [PATCH v6 07/18] block: deprecate "encryption=on" in favour of
 "encrypt.format=aes"
References: <20170425153858.25660-1-berrange@redhat.com>
 <20170425153858.25660-8-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 10:38 AM, Daniel P. Berrange wrote:
> Historically the qcow & qcow2 image formats supported a property
> "encryption=3Don" to enable their built-in AES encryption. We'll
> soon be supporting LUKS for qcow2, so need a more general purpose
> way to enable encryption, with a choice of formats.
>=20
> This introduces an "encrypt.format" option, which will later be
> joined by a number of other "encrypt.XXX" options. The use of
> a "encrypt." prefix instead of "encrypt-" is done to facilitate
> mapping to a nested QAPI schema at later date.
>=20
> e.g. the preferred syntax is now
>=20
>   qemu-img create -f qcow2 -o encrypt.format=3Daes demo.qcow2
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---


> @@ -3370,10 +3385,16 @@ static QemuOptsList qcow2_create_opts =3D {
>          {
>              .name =3D BLOCK_OPT_ENCRYPT,
>              .type =3D QEMU_OPT_BOOL,
> -            .help =3D "Encrypt the image",
> +            .help =3D "Encrypt the image with format 'aes'. (Deprecate=
d "
> +                    "in favour of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)"=
,

I don't think we have any strong position on US vs. UK spellings in
user-facing documentation, so I won't insist on any change.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2wDOqTAtbqLUSkbx14SggEISNpcFvr1he
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKtfAAoJEKeha0olJ0NqaBIH/06Hv1V73Lgv3LmYy0mlgP4J
spF/zBComw7SLT13j36i9pFuNTYMzIfRk+uuV+1zamJloDTGJdV1L5bK8pM3oFkO
siUK2r1CkmGtxvckb9JUFgiBlpJ0x6IwjMKtu6zT9xAooeSHAVL2Q7nfhdjtbHwg
eyHm9nWa9CQDlq8uw1f8xhfLO7XQBqx2t6oiic5H6RnmqPjyZlfvNS9bM/0WVWPv
rt7JM9s3rZGt1WNK0qH+SS06uSZLha+lWXeFwQUbFL1ETbJIV2DxJkOBnkunHAML
QGJ8LQfaHquF5NSfO44xWMvVU6ud9MTG/trF83V7jTJUAI7SKpOmXr8xq0/l2QE=
=yr2Y
-----END PGP SIGNATURE-----

--2wDOqTAtbqLUSkbx14SggEISNpcFvr1he--
