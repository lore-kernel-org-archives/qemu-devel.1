Received: from eggs.gnu.org ([2001:4830:134:3::10]:49680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFWu-0002GM-3O
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEFWq-0001o1-On
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dEFWq-0001nu-FF
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:43:44 -0400
References: <1495192872-27667-15-git-send-email-pbonzini@redhat.com>
	<20170526110913.89098-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85446004-1262-bd18-8acb-0e710bfc5fdf@redhat.com>
Date: Fri, 26 May 2017 08:43:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170526110913.89098-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PTKNgDOtjAJuJMUtEmQcNtLK5RWQVJqlq"
Subject: Re: [Qemu-devel] [PATCH v2] nbd/client.c: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PTKNgDOtjAJuJMUtEmQcNtLK5RWQVJqlq
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <85446004-1262-bd18-8acb-0e710bfc5fdf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] nbd/client.c: use errp instead of LOG
References: <1495192872-27667-15-git-send-email-pbonzini@redhat.com>
 <20170526110913.89098-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170526110913.89098-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 06:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move to modern errp scheme from just LOGging errors.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Fixes:
>=20
> - local_err initialized to NULL
> - 083 iotest ajusted
>=20
> \I feel like an idiot...
>=20

We all have days like that ;)


> +++ b/tests/qemu-iotests/083.out
> @@ -69,10 +69,12 @@ read failed: Input/output error
> =20
>  =3D=3D=3D Check disconnect 4 reply =3D=3D=3D
> =20
> +read failed
>  read failed: Input/output error

Having a double error report is awkward; can we figure out where the
duplication is coming from and trim it down to a single report?

But that can be done as a followup.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PTKNgDOtjAJuJMUtEmQcNtLK5RWQVJqlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKDEOAAoJEKeha0olJ0NqwssH/3m/SEexX3iqvG++J2h7jSWs
/8rjGYQi81Nfk6kUg6TyL5PdRcpjsmLWloGdpZbzOlMNYvjaWmNdUWXlyzOImqDZ
Iqd1PdPYOobqpYpubRMNp8uHUdFT2sFD5OmvbC0Lx7o2v0/0RxJh40OZ0vPfIRMB
ffbT9uHRV3RIDCvBYjWv4g7xfRicZFXlNXrDC1ZmOsW5xz2OXu/1SS4n57+th+UH
40mNBJ/RXnuRTa2nDiupn0OFje3qaaHj+VcZvtCqrJh6fMhDdrbwqcPdvsgrbExk
BK4aJvfUFdQOJGV7NATINLiCsX0MRM+VfQ7iR4Cmb+ZF3seTwu09OgSAjbaS+D0=
=9nbC
-----END PGP SIGNATURE-----

--PTKNgDOtjAJuJMUtEmQcNtLK5RWQVJqlq--
