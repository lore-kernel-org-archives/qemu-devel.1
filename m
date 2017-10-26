Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7cf4-0001m8-50
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7cf3-0003P4-3c
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:33:05 -0400
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
	<BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
	<f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
	<BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c9c95933-c70c-f16c-dd70-9b66aede987a@redhat.com>
Date: Thu, 26 Oct 2017 09:32:50 +0200
MIME-Version: 1.0
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1SUvOoKcF8eGp0KF64BfUcl40tG9SGUGo"
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1SUvOoKcF8eGp0KF64BfUcl40tG9SGUGo
From: Max Reitz <mreitz@redhat.com>
To: Changlimin <changlimin@h3c.com>, Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <c9c95933-c70c-f16c-dd70-9b66aede987a@redhat.com>
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
 <20171025133115.GA23458@lemon>
 <BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
 <f10f73b8-6b6b-a30e-a147-b7fcaa28b182@redhat.com>
 <BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE5D44@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-26 09:18, Changlimin wrote:
> If the qcow2 file is created with preallocation=3Dfull, I think metadat=
a will not corrupt when it is shared between two vms? Snapshot is not req=
uired.=20
>=20
> Is this right?

I wouldn't count on it.

If you really want to take the risk, you can probably use the
file.locking=3Doff option again.

Max


--1SUvOoKcF8eGp0KF64BfUcl40tG9SGUGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnxj6MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQ8wIAL9es6xNwIpVoXhF/A/oOMTUvkI3eSTq
fzsa/jIPhyJ/8ShAWERr1kovkxVwx5R2/sn3DFfKsAhDExXcA1WhxxvrFUA/lv0R
AIKA9LBzBS9S2AFgmkdbQvsvjTs/Z1PqlQImWvMQpTg61ojkQff20WK5LBJFEBQs
E4TpNpAl6dgufZZt2/q89wRgCZ4iBWd/7LGLTh8dOFl0xPOagdIKOZlEWafmaX7n
cuaEqI8P6bXuW1dvy4iPbK0Oc2a2kWNx0EKMaTyBxzB+Ux5E+qjby6tBFJ9abv/7
AEmixmEpJf/q0+oD/XE1sTjXHKylOUlwqYtcCkOOP4l29hbtcc6GQ9k=
=gUCw
-----END PGP SIGNATURE-----

--1SUvOoKcF8eGp0KF64BfUcl40tG9SGUGo--
