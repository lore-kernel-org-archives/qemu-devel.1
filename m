Received: from eggs.gnu.org ([209.51.188.92]:37946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0j7-0000WY-Nc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gp0j6-0000jy-Vd
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 20:01:09 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b0c2b109-b06d-7385-a6cf-3d24b9d15da0@redhat.com>
Date: Thu, 31 Jan 2019 02:01:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181221234750.23577-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qmxWdaPDgQOOwfFM1OXnm5rM8QVBJeZ3K"
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: Allow 147 to be run
 concurrently
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
--qmxWdaPDgQOOwfFM1OXnm5rM8QVBJeZ3K
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b0c2b109-b06d-7385-a6cf-3d24b9d15da0@redhat.com>
Subject: Re: [PATCH 0/3] iotests: Allow 147 to be run concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
In-Reply-To: <20181221234750.23577-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.12.18 00:47, Max Reitz wrote:
> 147 currently cannot be run concurrently for two reasons:
>=20
> (1) It creates TCP/IP NBD servers on a fixed port.
>=20
> (2) It uses a mix of "0.0.0.0", "localhost", and "::1" as host addresse=
s
>     to bind to.  As explained in the commit messages of patches 2 and 3=
,
>     this results in it potentially actually being able to set up two
>     servers on the same port at the same time -- but connecting to one
>     will always lead to the IPv6 server (regardless of whether you use
>     "localhost" or "::1").  Therefore, even if you get two servers
>     running concurrently, one of the tests will still break because it
>     connects to the wrong one.
>=20
> This series fixes these issues.
>=20
>=20
> Note that even if you do not care about concurrency, it still is a good=

> idea to make 147 not use a fixed port to create NBD servers on, as it
> may always be already in use by a totally different application.
>=20
>=20
> Max Reitz (3):
>   iotests.py: Add qemu_nbd_pipe()
>   iotests: Bind qemu-nbd to localhost in 147
>   iotests: Allow 147 to be run concurrently
>=20
>  tests/qemu-iotests/147        | 98 ++++++++++++++++++++++++-----------=

>  tests/qemu-iotests/iotests.py | 14 +++++
>  2 files changed, 82 insertions(+), 30 deletions(-)

Applied to my block branch.

Max


--qmxWdaPDgQOOwfFM1OXnm5rM8QVBJeZ3K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxSSM0ACgkQ9AfbAGHV
z0BzkQf/Q4T79q2LKUjzVXtXBq9F5lPN/VuPwjmvHYjIeD0n3yi3hFD+S9k8NLvQ
r7hJrde2wUoSZ7l/LVOpx5zXOV5BGCAAeWMHMg4OvRjYkedzLcgmPIxLfx+WTDUG
Jon1oQuP4SorRw3BL/MmepzyNsn4bXxQtnSBYyhQPSZZ553ZvOSIR3Qzs1tWTjg0
IW/HpVHNv2WNm/6mJcmbzWukPDTC7FHtNu8IsN2nsrGZJz1gBL4BBua1j1+N4VDB
d9OTSX92NCi6yKK19ChWk+qRGO/mGV+74RcuhSCtn2iAFpvzzYBYv3dLbPAns4hD
0t+8cmPL/ovzT9YRYSS5g77+2KyATw==
=bqwc
-----END PGP SIGNATURE-----

--qmxWdaPDgQOOwfFM1OXnm5rM8QVBJeZ3K--
