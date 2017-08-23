Received: from eggs.gnu.org ([2001:4830:134:3::10]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWih-0004GX-2y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWie-0007wv-Pd
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:33:23 -0400
References: <20170823134242.12080-1-famz@redhat.com>
	<20170823134242.12080-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8b5ac60-37f2-bd85-55fa-0f2835eda7d0@redhat.com>
Date: Wed, 23 Aug 2017 09:33:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170823134242.12080-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hV1Ba946DqXxQ1cCJ9GpOJM46sJXEbj9N"
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/4] block-backend: Refactor
 inactivate check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hV1Ba946DqXxQ1cCJ9GpOJM46sJXEbj9N
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 stefanha@redhat.com, Max Reitz <mreitz@redhat.com>
Message-ID: <b8b5ac60-37f2-bd85-55fa-0f2835eda7d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/4] block-backend: Refactor
 inactivate check
References: <20170823134242.12080-1-famz@redhat.com>
 <20170823134242.12080-2-famz@redhat.com>
In-Reply-To: <20170823134242.12080-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 08:42 AM, Fam Zheng wrote:
> The logic will be fixed (extended), move it to a separete function.

s/separete/separate/

[can fix on pull request]

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hV1Ba946DqXxQ1cCJ9GpOJM46sJXEbj9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdkiEACgkQp6FrSiUn
Q2qO0QgAld9hf1V6pmmWntB1gpnQQic+N0MaI8l6QKaLUgg7zdGEJNYxXCjhCSvc
O+7P39J0QgxowcOoGvTVuppGdfRyFMAH7R42ijZYJWh6Lweb9cJRk8aKrJWiEVR6
TmyalESEnVIY3DJ7hSM5sWyj+x+CKGO3U2H5vq64kWsxgaFKoTtGZoB9gXKJN6Cm
eNSCW58iXG+icMAGfi+bcmPmVdo221nn17fFr5vukZPq0EVMS+kLVJ2RAQ7Au1u8
gmClAAoMVOzeyppy2Oh71VtHIi3VNvF0ehpFO2TAuHrXwMI74GStX1kEMDepxaqk
lYJpHt/R+2eR+wdlByQS+GTLYtcYIA==
=5V1S
-----END PGP SIGNATURE-----

--hV1Ba946DqXxQ1cCJ9GpOJM46sJXEbj9N--
