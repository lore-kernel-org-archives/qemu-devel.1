Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Snq-0003yH-OT
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6Snn-00028n-FW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:17:06 -0400
References: <20170505020430.2305-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <00709aa5-218f-9080-9a82-e5e47c286081@redhat.com>
Date: Thu, 4 May 2017 21:17:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170505020430.2305-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DK6xTS3q8iTBPv97Wh40U1oMck7AmT4GO"
Subject: Re: [Qemu-devel] [PATCH] tests: Remove redundant assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DK6xTS3q8iTBPv97Wh40U1oMck7AmT4GO
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <00709aa5-218f-9080-9a82-e5e47c286081@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Remove redundant assignment
References: <20170505020430.2305-1-famz@redhat.com>
In-Reply-To: <20170505020430.2305-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 09:04 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/postcopy-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
> index de35a18..e86f876 100644
> --- a/tests/postcopy-test.c
> +++ b/tests/postcopy-test.c
> @@ -41,7 +41,7 @@ static bool ufd_version_check(void)
>      struct uffdio_api api_struct;
>      uint64_t ioctl_mask;
> =20
> -    int ufd =3D ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC);
> +    int ufd =3D syscall(__NR_userfaultfd, O_CLOEXEC);
> =20
>      if (ufd =3D=3D -1) {
>          g_test_message("Skipping test: userfaultfd not available");
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DK6xTS3q8iTBPv97Wh40U1oMck7AmT4GO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC+CcAAoJEKeha0olJ0NqHekH/AlgcUBCaLxitjbMufqav4Eb
yWlBhgPeVEodZGnlBXoY9WWNhj5VUBNYBbeG+baMe7KUaCul9ig0S6yME9n8WGoS
GIZLqzFVmyBjUe4eHeY5caboYieLgBRBZtVD/VHkYTT4d5n1ps23qomFkFCjZfU1
alr1mPQ6mclZ4s3mzYMyiAHshp/3xbjLskCdmCHQZA7sX5ZpkFQn69nGl7UocEQv
nIGlzWTUjkV9XYuU6rYOgz5UKiFmlDwkZG/T7HCxOb+pzxWN7uXszP3UT0i35Zph
BylOGTB4bZscfrUAX3sttC7GS+re1EB3Pza/TP7cCcUF2dn0TyI3unQx1zWypYM=
=kefV
-----END PGP SIGNATURE-----

--DK6xTS3q8iTBPv97Wh40U1oMck7AmT4GO--
