Received: from eggs.gnu.org ([2001:4830:134:3::10]:58623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Nmw-0006TO-2d
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Nmq-000705-Ej
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:19:26 -0400
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76adb721-71c5-62bb-ad17-ad17af42bc87@redhat.com>
Date: Wed, 26 Apr 2017 09:19:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170426134649.9042-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TLJqOTpikmfodkEGicWhGdcFsXqoIlutl"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] qemu-img/convert: Move bs_n > 1 &&
 -B check down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TLJqOTpikmfodkEGicWhGdcFsXqoIlutl
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76adb721-71c5-62bb-ad17-ad17af42bc87@redhat.com>
Subject: Re: [PATCH v2 2/3] qemu-img/convert: Move bs_n > 1 && -B check down
References: <20170426134649.9042-1-mreitz@redhat.com>
 <20170426134649.9042-3-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 08:46 AM, Max Reitz wrote:
> It does not make much sense to use a backing image for the target when
> you concatenate multiple images (because then there is no correspondenc=
e
> between the source images' backing files and the target's); but it was
> still possible to give one by using -o backing_file=3DX instead of -B X=
=2E
>=20
> Fix this by moving the check.
>=20
> (Also, change the error message because -B is not the only way to
>  specify the backing file, evidently.)
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c                 | 13 +++++++------
>  tests/qemu-iotests/122.out |  4 ++--
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TLJqOTpikmfodkEGicWhGdcFsXqoIlutl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAKxiAAoJEKeha0olJ0NqPV4H/3o+2FowpJpGj3V1TWn5kT38
hsa6cQHfTfqautQ7pWVvAkB1rSboJnHn7Qz7F3aNaAVyOaorLnN+qAF4kLnOVgOt
C3gH4kFF0sivGuRYEY0+TMWucU/X7ua58aYyZP2gY278FO4P84Z1rbtGCL0kxim5
THU413Kdpvz4E+mLjaQ9Lnje06O6kSLkaDbQg8W3NggIl4MpL13R48xCwyi6fXDr
wZrv3PnLsccCioICA9AAPAukNksE94Y4hhFm5Tjuuc3X6DQ8c4v/ec+8s++fC2qo
OG8sDEU2kanNIzOWpCmaHGEUua2Qb1WU6o2ICmfs36USZaQ7UgjEoPdSu56l2iU=
=KY7K
-----END PGP SIGNATURE-----

--TLJqOTpikmfodkEGicWhGdcFsXqoIlutl--
