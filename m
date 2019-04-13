Received: from eggs.gnu.org ([209.51.188.92]:51563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLG0-0001q0-Lj
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hFLFz-0006gr-QA
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 12:11:56 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
Date: Sat, 13 Apr 2019 18:11:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t"
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
--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <9afddacb-ca54-6ac3-1c02-b8916a08fcd3@redhat.com>
Subject: Re: [PATCH 0/3] qemu-img: Allow rebase with no input base
References: <20180713111424.23670-1-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping again

(I feel like I just need to start merging unreviewed patches until I
break something (can't take that long) so you get so scared of my
patches that you at least refuse them outright)

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



--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyyCkUACgkQ9AfbAGHV
z0Dy7Af+ObQ9F/kZa50J66nJg5GlX/ARIP188rvFsB6uphLNA/l/s+ESK2lCS5Yg
qOhSTBF98XI8TaabMsL8lSu3UzGBlmXB/q5qrbLMnjg4PYYHCUa1bJPseML52cFy
dP3SZ2iM1LVTbeyOiaddzI0zRT0E7GGAeFfe4M9Be19Jz3Z//fUX33hmPqDTbpbV
tuf25I7tOfyzsTPOdcgp7iExXQpQT12cA+hsF7BiFf6YRbOcGXaqA5DLxx2GYMhF
3ezN29jGkgj8Tm9AIhnVLRsJQuhsMwWnJN8iQBZG+ZU3DN7sgTqYP5JoZ+xPqcXv
MLQ1GVwexDnz/JNSOE3QoCsclRw43w==
=gwHx
-----END PGP SIGNATURE-----

--HFNPGbDcPuqMunTOqsYDGGXP0QQjJID3t--
