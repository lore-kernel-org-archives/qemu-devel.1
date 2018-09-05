Received: from eggs.gnu.org ([2001:4830:134:3::10]:54983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxX6b-0004I5-6f
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxX6a-0006jZ-Du
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:40:21 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<4e52d3696c178d172a00f9e774c97286709e8c00.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4e45c661-32ce-4773-41cb-c0c7a6052ad9@redhat.com>
Date: Wed, 5 Sep 2018 14:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <4e52d3696c178d172a00f9e774c97286709e8c00.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j3th9j7Rygx1oD3X98vrMht6snIGWLXlO"
Subject: Re: [Qemu-devel] [PATCH v2 05/10] block: Allow child references on
 reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j3th9j7Rygx1oD3X98vrMht6snIGWLXlO
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4e45c661-32ce-4773-41cb-c0c7a6052ad9@redhat.com>
Subject: Re: [PATCH v2 05/10] block: Allow child references on reopen
References: <cover.1535983918.git.berto@igalia.com>
 <4e52d3696c178d172a00f9e774c97286709e8c00.1535983918.git.berto@igalia.com>
In-Reply-To: <4e52d3696c178d172a00f9e774c97286709e8c00.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> In the previous patches we removed all child references from
> bs->{options,explicit_options} because keeping them is useless and
> wrong.
>=20
> Because of this, any attempt to reopen a BlockDriverState using a
> child reference as one of its options would result in a failure,
> because bdrv_reopen_prepare() would detect that there's a new option
> (the child reference) that wasn't present in bs->options.
>=20
> But passing child references on reopen can be useful. It's a way to
> specify a BDS's child without having to pass recursively all of the
> child's options, and if the reference points to a different BDS then
> this can allow us to replace the child.
>=20
> However, replacing the child is something that needs to be implemented
> case by case and only when it makes sense. For now, this patch allows
> passing a child reference as long as it points to the current child of
> the BlockDriverState.
>=20
> It's also important to remember that, as a consequence of the
> previous patches, this child reference will be removed from
> bs->{options,explicit_options} after the reopening has been completed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--j3th9j7Rygx1oD3X98vrMht6snIGWLXlO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPzqIACgkQ9AfbAGHV
z0CE+QgAmb1y3PQG7v5S/UQbjXNw05pH9DwxTRYiNK88ajB3x2LgaYHOIyrqxLCy
aWZifEggF62gsAbzoNVmvtdY2J+j8lDQ4eGv67neaAE4AGtjwjRGhsa9IdqQojHD
utfGlAn0ukk7qvvjZyi0X4nTSiRre9cVh9e4nwuDS1O2LWwXLa1kVynFc2nyBgPM
q+KDSQVnjb6B40N1NIjTLOrQb8Vfc8Taj5ACUD0en/vePWbTXlc8mHhGihzYJ2Vu
ugSBPCTngWZKluHopmPFnkGrEbhBQnHIiw4tw4yNXFZySn0fTUNlLLWTE8C7pMv6
vyghepPMwJqdZAImphbaTRPVFFlvrQ==
=bRwk
-----END PGP SIGNATURE-----

--j3th9j7Rygx1oD3X98vrMht6snIGWLXlO--
