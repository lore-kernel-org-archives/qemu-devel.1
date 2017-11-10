Received: from eggs.gnu.org ([2001:4830:134:3::10]:52289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFiu-0005Ay-LF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDFit-0007Dr-Ff
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:16:20 -0500
References: <cover.1510339534.git.berto@igalia.com>
	<0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aacee0cf-d5bc-0279-da04-8d898dbc18a4@redhat.com>
Date: Fri, 10 Nov 2017 21:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NHh3LGbfOxxngf5JMlkEHbEsk5bNh6QxV"
Subject: Re: [Qemu-devel] [PATCH 1/3] block: Check for inserted
 BlockDriverState in blk_io_limits_disable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NHh3LGbfOxxngf5JMlkEHbEsk5bNh6QxV
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, sochin jiang <sochin.jiang@huawei.com>
Message-ID: <aacee0cf-d5bc-0279-da04-8d898dbc18a4@redhat.com>
Subject: Re: [PATCH 1/3] block: Check for inserted BlockDriverState in
 blk_io_limits_disable()
References: <cover.1510339534.git.berto@igalia.com>
 <0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com>
In-Reply-To: <0d3a67ce8d948bb33e08672564714dcfb76a3d8c.1510339534.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 19:54, Alberto Garcia wrote:
> When you set I/O limits using block_set_io_throttle or the command
> line throttling.* options they are kept in the BlockBackend regardless
> of whether a BlockDriverState is attached to the backend or not.
>=20
> Therefore when removing the limits using blk_io_limits_disable() we
> need to check if there's a BDS before attempting to drain it, else it
> will crash QEMU. This can be reproduced very easily using HMP:
>=20
>      (qemu) drive_add 0 if=3Dnone,throttling.iops-total=3D5000
>      (qemu) drive_del none0
>=20
> Reported-by: sochin jiang <sochin.jiang@huawei.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/block-backend.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NHh3LGbfOxxngf5JMlkEHbEsk5bNh6QxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloGCQYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AmG8H/i+9jROVvn6mHJi5mkahxezNSsIUBgL0
S0iWQm67t1oDFQVivforAWZ3G8xfo8MUspyYU4t09xoTcU2Kg/dxcuciDZHOQBOo
GIzyerPcZe1ZFlI7wE77MXurRElrzd0phEXQRaLcb169XCeCS103bxlw/6B+VVrl
MZ1i20Kt3Ui+ZmBtg3BYgbdBfKtrh5iWjSxC5a243WgfrEgaAkbkVoEghITRMpgg
J3a0pR0RkSOTD6Zq0x6fqm3r9VPebu9XVn7SwnOgmhsGsYDVYyjJPdvkNaw2OeGk
OtWSvOFiqhCK2y/nslpRHx3xGK1wI/dWQGlPuZJ2XDf5W0kVrga3IXo=
=Jsqd
-----END PGP SIGNATURE-----

--NHh3LGbfOxxngf5JMlkEHbEsk5bNh6QxV--
