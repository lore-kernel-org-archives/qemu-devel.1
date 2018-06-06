Received: from eggs.gnu.org ([2001:4830:134:3::10]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeHw-0005d1-Mz
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQeHv-0001Dk-Ru
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:40:08 -0400
References: <20180606190628.8170-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2f82ae86-2691-6329-887b-2a78d27b41ad@redhat.com>
Date: Wed, 6 Jun 2018 21:39:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180606190628.8170-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D3RXOCctwzquBlQKpszclaYzoLpNegL9X"
Subject: Re: [Qemu-devel] [PATCH v4] iotests: Fix 219's timing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3RXOCctwzquBlQKpszclaYzoLpNegL9X
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <2f82ae86-2691-6329-887b-2a78d27b41ad@redhat.com>
Subject: Re: [PATCH v4] iotests: Fix 219's timing
References: <20180606190628.8170-1-mreitz@redhat.com>
In-Reply-To: <20180606190628.8170-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-06 21:06, Max Reitz wrote:
> 219 has two issues that may lead to sporadic failure, both of which are=

> the result of issuing query-jobs too early after a job has been
> modified.  This can then lead to different results based on whether the=

> modification has taken effect already or not.
>=20
> First, query-jobs is issued right after the job has been created.
> Besides its current progress possibly being in any random state (which
> has already been taken care of), its total progress too is basically
> arbitrary, because the job may not yet have been able to determine it.
> This patch addresses this by just filtering the total progress, like
> what has been done for the current progress already.  However, for more=

> clarity, the filtering is changed to replace the values by a string
> 'FILTERED' instead of deleting them.
>=20
> Secondly, query-jobs is issued right after a job has been resumed.  The=

> job may or may not yet have had the time to actually perform any I/O,
> and thus its current progress may or may not have advanced.  To make
> sure it has indeed advanced (which is what the reference output already=

> assumes), keep querying it until it has.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v4: Drop the "import time" that has become unnecessary
>=20
> v3: Keep querying until the job has advanced instead of waiting for a
>     fixed amount of time [Peter in v2, Eric in v1]
> ---
>  tests/qemu-iotests/219     | 26 ++++++++++++++++++++------
>  tests/qemu-iotests/219.out | 10 +++++-----
>  2 files changed, 25 insertions(+), 11 deletions(-)

Applied to my block branch.

Max


--D3RXOCctwzquBlQKpszclaYzoLpNegL9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsYOI4ACgkQ9AfbAGHV
z0AjIQf8DJXjynl2CY8lv+G29JoyKAymdHaWdG2fwQ93hSRhtBy78rTeAUq3tXin
bcN+yJi8K1d2HNEA1BDGVW1vvVoCIVGUW4izWDqQ/5X8KNjGjyjt+aGuPbNjaDl+
Ciiaun2upqWqgukH7pyYGJQ+9fOEXdpKyYkQDKC+R2MJlwfQB4s077lLxIrJuKyB
KH9CpMy9WaifjnM/iVi7gswOuua14gv/xG6Bb2nLbos7AlVFDTLR0G4AQPQaEBzx
I1NGexUUP01tGjoZ/5PX5DUU/5ZS7vF/Hj2mcZKEgLVz/7xYCUGiCwIW7UarCD8W
j4ZpusPq371E48+8Gsu10S4HymTeEw==
=3ikO
-----END PGP SIGNATURE-----

--D3RXOCctwzquBlQKpszclaYzoLpNegL9X--
