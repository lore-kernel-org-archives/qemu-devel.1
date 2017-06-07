Received: from eggs.gnu.org ([2001:4830:134:3::10]:56663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIdhr-0004Nd-PX
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dIdhr-0000dU-1Q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 12:21:15 -0400
Date: Wed, 7 Jun 2017 19:20:54 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170607162054.mbo2nxgi4zd4kqk6@postretch>
References: <cover.1496844254.git.berto@igalia.com>
	<ab53bc08e26b3e4cc5b1a14eee9e64fd0e03871d.1496844254.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qybvqw6ywnk2pydd"
Content-Disposition: inline
In-Reply-To: <ab53bc08e26b3e4cc5b1a14eee9e64fd0e03871d.1496844254.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] qcow2: Pass a QEMUIOVector to
 do_perform_cow_{read, write}()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>


--qybvqw6ywnk2pydd
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Wed, Jun 07, 2017 at 05:08:27PM +0300, Alberto Garcia wrote:
>Instead of passing a single buffer pointer to do_perform_cow_write(),
>pass a QEMUIOVector. This will allow us to merge the write requests
>for the COW regions and the actual data into a single one.
>
>Although do_perform_cow_read() does not strictly need to change its
>API, we're doing it here as well for consistency.
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

--qybvqw6ywnk2pydd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk4J+YACgkQc2J8L2kN
9xAUcw//WBttzGF3kToGRvs21glqqrkz0ZyVbzPTwdPzL6Azz5nkpV5iYMh7HLFE
CxDn6RhDYYPlbA4e0rUF0UB0sUod9EFmXq6cWhOFQIGNf71PnM0mUoq+A9mF/60o
uq5puEzXEyeC4ybRdrqgJgt9X6fKzs1pIE4ErQWoRkrS8NENt1/l0vpxgP3EsRk9
9bMqJvDrbt/Qf4YXP7lIP1i+dOK6TJ29u6PZpZoHYGGGNp5s62MNV1dmKSumszZD
6ToVX9F9tr9wIJ1wFeWUxwwPOo2RLXxDoeuSQSE9n60EJMMdp4Ndf3jMjpDEw2sG
x8OvGEq8QjSagMMcjBv1IYbpDf6I8Lstr0E7gGaqRpe05sSFPAQieodr34AtTiPH
G/LzdK2oMvjICn0ysD/cjffMR9VzzbMq/shtiTWIdLCw40mpygwQPksa2YUQkom0
xgVknP5ScybzfII3/P3VsQSaM2SINuotMX73jfrxcbxow8mPWL8AWNoZmLWJMnlJ
n4SIignq4+Kz4DxTvxe8xOSapYCExGV4uC6p/FgZCMgyFq+PIqprcTX+S+7eq6Mn
30AStnuv0mRUW66P/elQaAtciSBQsT2a+B9c4DyRkYPQ42h/sKtYiJ/4z965BUm8
JwUdDhEQv/sBp7YVcvU3V+JYybWRKD065t6gQkdgrjrMVO6RtT4=
=M6Ez
-----END PGP SIGNATURE-----

--qybvqw6ywnk2pydd--
