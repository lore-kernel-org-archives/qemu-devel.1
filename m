Received: from eggs.gnu.org ([2001:4830:134:3::10]:57818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1db4kI-0005wr-Ff
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1db4kH-0001Kx-Q5
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:51:58 -0400
Date: Fri, 28 Jul 2017 14:48:33 +0200
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20170728124832.GP8603@aepfle.de>
References: <20170728123127.27921-1-olaf@aepfle.de>
	<d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TSQPSNmi3T91JED+"
Content-Disposition: inline
In-Reply-To: <d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--TSQPSNmi3T91JED+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jul 28, Eric Blake wrote:

> This version is prone to multiplication overflow (well, maybe not, but
> you have to audit for that).  Wouldn't it be better to use:

What could go wrong?
qemu will die either way, I think.

Olaf

--TSQPSNmi3T91JED+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWXsyjAAKCRBdQqD6ppg2
fpYMAKDNcY2BWV607m3JyjhuvvIbcy8hmwCg6jNjYA+4wPjqQ+jKQH85nvn7ypU=
=NXQZ
-----END PGP SIGNATURE-----

--TSQPSNmi3T91JED+--
