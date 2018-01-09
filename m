Received: from eggs.gnu.org ([2001:4830:134:3::10]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzmT-0006EC-Bv
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzmP-0008Gm-AV
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:41:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYzmP-0008Ek-0m
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:41:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A03E78238
	for <qemu-devel@nongnu.org>; Tue,  9 Jan 2018 19:41:48 +0000 (UTC)
References: <20180109193745.GA18506@amt.cnet>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d823570c-b4fe-2374-e5b7-7b1be7deb496@redhat.com>
Date: Tue, 9 Jan 2018 13:41:41 -0600
MIME-Version: 1.0
In-Reply-To: <20180109193745.GA18506@amt.cnet>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UcLIntXNLvY3bH1HgD9yqxqfHhqqoj3yu"
Subject: Re: [Qemu-devel] [PATCH] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UcLIntXNLvY3bH1HgD9yqxqfHhqqoj3yu
From: Eric Blake <eblake@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d823570c-b4fe-2374-e5b7-7b1be7deb496@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu: improve hugepage allocation failure
 message
References: <20180109193745.GA18506@amt.cnet>
In-Reply-To: <20180109193745.GA18506@amt.cnet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2018 01:37 PM, Marcelo Tosatti wrote:
>=20
> Improve hugepage allocation failure message, indicating
> whats happening to the user.

s/whats/what's/

>=20
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>=20
> diff --git a/exec.c b/exec.c
> index 4722e521d4..439abedb98 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1643,7 +1643,8 @@ static void *file_ram_alloc(RAMBlock *block,
>                           block->flags & RAM_SHARED);
>      if (area =3D=3D MAP_FAILED) {
>          error_setg_errno(errp, errno,
> -                         "unable to map backing store for guest RAM");=

> +                         "unable to map backing store for guest RAM, "=

> +                         "falling back to malloc based RAM allocation"=
);
>          return NULL;
>      }
> =20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UcLIntXNLvY3bH1HgD9yqxqfHhqqoj3yu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVGvUACgkQp6FrSiUn
Q2o0aggAhkAB0q7wvW8VejicuzvWu65Y29QhwztZOnVQxjL8alX/G/g9zMT9dN9K
99Dsmbhyn2WVXK/xCXUrr9DMTvfuq3knoVamBSKvMcp8i1tGqbNTefKMSyV7xPw8
zW3mrm8WXqwP8l0MbQpqMkvSX863+Kq1lDjTBeDSBvMiqOxl85vb6Nz//vRGK/MF
lOLmHIfgow+S1Eru3HynxvyImdmyGFXzSSKeLmxAfZMDBERpZtn8ItrcNtrqix4j
0Fr3sBnqLbz0gNB5v8U6jHOkS7JcEkhnbuMBs9X5HfcyU3ASwXwZsQG6652CPBg0
DjFbpLxXnfmYd5MYbr1HB/opj+Gfww==
=mfcy
-----END PGP SIGNATURE-----

--UcLIntXNLvY3bH1HgD9yqxqfHhqqoj3yu--
