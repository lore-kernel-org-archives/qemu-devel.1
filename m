Received: from eggs.gnu.org ([209.51.188.92]:42425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGRM-0004Ts-5B
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:37:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyGRL-0000Sl-FA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:37:04 -0500
References: <20190218180646.30282-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b028613f-a4bb-2514-b3f5-950daaca03c3@redhat.com>
Date: Mon, 25 Feb 2019 14:36:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190218180646.30282-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jyp3LrWIjQ6zCBLCNTFV3m4dmQ9BYNjOU"
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip 211 on insufficient memory
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
--Jyp3LrWIjQ6zCBLCNTFV3m4dmQ9BYNjOU
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b028613f-a4bb-2514-b3f5-950daaca03c3@redhat.com>
Subject: Re: [PATCH] iotests: Skip 211 on insufficient memory
References: <20190218180646.30282-1-mreitz@redhat.com>
In-Reply-To: <20190218180646.30282-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.19 19:06, Max Reitz wrote:
> VDI keeps the whole bitmap in memory, and the maximum size (which is
> tested here) is 2 GB.  This may not be available on all machines, and i=
t
> rarely is available when running a 32 bit build.
>=20
> Fix this by making VM.run_job() return the error string if an error
> occurred, and checking whether that contains "Could not allocate bmap"
> in 211.  If so, the test is skipped.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/211        | 4 +++-
>  tests/qemu-iotests/iotests.py | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Thanks for the reviews, applied to my block branch.

Max


--Jyp3LrWIjQ6zCBLCNTFV3m4dmQ9BYNjOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxz73EACgkQ9AfbAGHV
z0D95AgArWqHYiV5cFl8WDwlPF/owl0gSB2JdV60t4Szf3MtIN2aM+0Kr8NJY0Wf
oz4viYWzoG3T6Nb7RlB+GCtWt0xo0S9wEETJHfEc8C+pmYlJdO5xyiD00TPeDrw8
tvMe19WuzvqHGO+cVT/AP6HFIHD13aoXSkoq1kWZKZNbqe5XJ31Vnjh7UERO9owg
Eq5Oro/Iw0m7ZxoZIgvhedrkF5Do7oKCwRf3J77JNmzSkt/6mzKosA8qUaY9/lVx
J+sgs3/fP02fllPxvlNlSpKJDvHD6Y+RWRiEZ79l7EQxkNa6BsV9GGlP37uWdv49
sKVUX6pfCQFq8dfX1NwUJ/AZisLvtw==
=PCJk
-----END PGP SIGNATURE-----

--Jyp3LrWIjQ6zCBLCNTFV3m4dmQ9BYNjOU--
