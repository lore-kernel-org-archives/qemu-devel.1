Received: from eggs.gnu.org ([2001:4830:134:3::10]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsv7R-0004cz-UX
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsv7R-0001Xl-2A
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:13:37 -0400
References: <20170915054526.20588-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0289d143-4862-e812-3f5d-0a0bc74a05e7@redhat.com>
Date: Fri, 15 Sep 2017 13:13:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170915054526.20588-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KrILAUb8heGuRHR53LGPOXbHcs8w8af1p"
Subject: Re: [Qemu-devel] [PATCH] iotests: Print full path of bad output if
 mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KrILAUb8heGuRHR53LGPOXbHcs8w8af1p
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <0289d143-4862-e812-3f5d-0a0bc74a05e7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Print full path of bad output if
 mismatch
References: <20170915054526.20588-1-famz@redhat.com>
In-Reply-To: <20170915054526.20588-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 12:45 AM, Fam Zheng wrote:
> So it is easier to copy paste the path.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/qemu-iotests/check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index d504b6e455..4583a0c269 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -353,7 +353,7 @@ do
>                  else
>                      echo " - output mismatch (see $seq.out.bad)"
>                      mv $tmp.out $seq.out.bad
> -                    $diff -w "$reference" $seq.out.bad
> +                    $diff -w "$reference" $(realpath $seq.out.bad)

Realpath collapses symlinks, and $() costs a process.  Also, your patch
fails miserably if the current working directory contains spaces; you
forgot to quote $().  It would be simpler, and more correct, to do:

$diff -w "$reference" "$PWD/$seq.out.bad"

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KrILAUb8heGuRHR53LGPOXbHcs8w8af1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8GEYACgkQp6FrSiUn
Q2pZ4QgAqaGQdIh7r7A/e8X6rWV2IffaKw/mNgjJwv4xZ3KwYVoKopezLI4TgQDL
efGl91ARP4R9LmgLCZ659N1SfejVcqIReCxXCGiuE8sbvKgi+a/8hR+zGh9/4MBW
dpSMcdAj1UaU+IyJ9agK866Het2Pgb8zL7ENjvd5WkS8HBFxqzlScZsDHU7Q5EU3
uFIXE+dL7AtztebOlM2ufFFEcxHS+JvNcvvlWuZRCF2kP2rchdQxTn5j894RFp3c
0AAuML6DAakYfSh7HdKS025Fkl4bMKusF6CsKC5690hcbg7dqUKXmVITveJ32BYV
kV65FS1Ajz3a/bMmXFqAqKGO+fwssA==
=gR/j
-----END PGP SIGNATURE-----

--KrILAUb8heGuRHR53LGPOXbHcs8w8af1p--
