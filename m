Received: from eggs.gnu.org ([209.51.188.92]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPEx-0005iW-1g
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grPEw-0008OH-B2
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:35:55 -0500
References: <20180713111424.23670-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c46efa89-d3bc-e846-efec-61916be0d519@redhat.com>
Date: Wed, 6 Feb 2019 16:35:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qojy4BmWh1YkhWQjmbHzXE3SncA4Mxhuq"
Subject: Re: [Qemu-devel] [PATCH 0/3] qemu-img: Allow rebase with no input
 base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qojy4BmWh1YkhWQjmbHzXE3SncA4Mxhuq
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c46efa89-d3bc-e846-efec-61916be0d519@redhat.com>
Subject: Re: [PATCH 0/3] qemu-img: Allow rebase with no input base
References: <20180713111424.23670-1-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping

On 13.07.18 13:14, Max Reitz wrote:
> This series allows using qemu-img rebase on images that do not have a
> backing file.  Right now, this fails with the rather cryptic error
> message:
>=20
> $ qemu-img rebase -b base.qcow2 foo.qcow2
> qemu-img: Could not open old backing file '': The 'file' block driver r=
equires a file name
>=20
> Yeah, well, OK.
>=20
> With how rebase currently works, this would lead to the overlay being
> filled with zeroes, however.  This is where patch 2 comes in and instea=
d
> makes rebase use blk_pwrite_zeroes() whenever it handles an area past
> the input=E2=80=99s backing file=E2=80=99s EOF.
>=20
> (Note that additionally we could try to punch holes in the overlay
> whenever it matches the new backing file, but that=E2=80=99s something =
I=E2=80=99ll put
> off for later.  (We don=E2=80=99t even have a reliable method for punch=
ing holes
> into an overlay yet, although I would like to have such because it coul=
d
> make active commit more efficient.))
>=20
>=20
> And patch 3 adds the usual test.
>=20
>=20
> Max Reitz (3):
>   qemu-img: Allow rebase with no input base
>   qemu-img: Use zero writes after source backing EOF
>   iotests: Add test for rebase without input base
>=20
>  qemu-img.c                 | 72 +++++++++++++++++++++++---------------=

>  tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
>  3 files changed, 150 insertions(+), 29 deletions(-)
>=20



--qojy4BmWh1YkhWQjmbHzXE3SncA4Mxhuq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxa/tQACgkQ9AfbAGHV
z0BSBggAs0MjjqG7mli2/+EwEzrpbck7+pk2GzgfYstZA7yvtuzOcpN4+heJ0fTe
gxt14kIGyo9hvCkQWavqgtxd0QvFnOQ/aUmbpotxtDZwnfE9UDX49eDBIubMhx7C
CTmMq4f9h+MtcKMRTCVOsPPT12d7SFX7Uas8JHXB5ib7myCmF+98/zhoUWQuu48M
MPpQvi7MT5EQBm08rUZIvltULOAL17aAief3Kv20q/wbvg9lmy96F0VK++QhO+6W
F67mMCKkcXN/OAzjTOkvyGAntjdFXFCzcz1rE05DK0SS3ZEXvPL2B7L54NkuR2nf
pjgA3j2MYJsyfK7Pjy7F4+pmJFrvDQ==
=Vghs
-----END PGP SIGNATURE-----

--qojy4BmWh1YkhWQjmbHzXE3SncA4Mxhuq--
