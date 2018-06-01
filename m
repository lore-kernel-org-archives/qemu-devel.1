Received: from eggs.gnu.org ([2001:4830:134:3::10]:51296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiI0-0007Qu-J6
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiHx-0004PR-E5
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:32:12 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOiHx-0004Op-6B
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:32:09 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k16-v6so8791472wro.0
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 04:32:09 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:32:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601113205.GF8687@stefanha-x1.localdomain>
References: <201805202054.50525.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <201805202054.50525.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [Bug 1769189] Re: Issue with qemu 2.12.0 + SATA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 20, 2018 at 08:54:50PM +0300, Andrew Randrianasulu wrote:
> I think I was hit with very same bug.
>=20
> I did bisect with 2.11.0 as good point and 2.12.0 as bad point.

Hi Andrew,
Please try John Snow's SATA fixes for QEMU 2.12.0.  If you can't build
QEMU from source you can wait for QEMU 2.12.1 to be released with the
fixes.

The patch series was titled "[PATCH 0/3] ahci: fix completion race
condition".

You can grab it from git here: https://github.com/jnsnow/qemu/commits/ide

Stefan

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbES61AAoJEJykq7OBq3PI094IAI6GWMEcCSJGeZcV76wFjpUs
LngXXSPlLtHfWlswa5cqKMs+ZlcFDY7LC7+83XPuM5y77OrmTolPrjw70t2JSEqI
KyclI45BiPwMdpO7hEp9lOIRkZMf9r9OKBQqGaD+DyxAkgzCAXrYjyG9qy3Icyv0
3cRja7nJsvS3lVDdssjNxU3FDZVYDfPrYXcggAUjXFDGGLCWlFmcWTm+I+kGjvMT
rH1riTL7w5CLiQDkD1Q3ERCnA26jHh9SQouCV4wlL/+iRBbSCuubfk3J7ekmfNig
OOpKVn6WkS3SibVMcaiPBZks4Lz5gnhdCceRsLqQXrcvhEsIcRMYxTC+5LQfkmw=
=0Q61
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
