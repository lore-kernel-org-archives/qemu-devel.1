Received: from eggs.gnu.org ([2001:4830:134:3::10]:33573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egE5e-0005xN-5k
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egE5d-0006ue-B8
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:23:34 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4ca01121-3446-99a6-12e8-b3606262141e@redhat.com>
Date: Mon, 29 Jan 2018 19:23:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4zvot0kVzc3DA6tZq3QhxdstRHe4OpCk8"
Subject: Re: [Qemu-devel] [RFC PATCH 00/10] x-blockdev-create for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4zvot0kVzc3DA6tZq3QhxdstRHe4OpCk8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <4ca01121-3446-99a6-12e8-b3606262141e@redhat.com>
Subject: Re: [RFC PATCH 00/10] x-blockdev-create for qcow2
References: <20180111195225.4226-1-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-11 20:52, Kevin Wolf wrote:
> This series implements a minimal QMP command that allows to create an
> image format on a given block node. The interface is still going to
> change to some kind of an async command (possibly a block job), so I
> prefixed x- for now.
>=20
> At this point, I'm mostly interested in comments about
> BlockdevCreateOptions in the schema, the .bdrv_co_create callback and
> the way that legacy .bdrv_create is implemented in qcow2 now.
>=20
> It looks to me as if we will have to keep .bdrv_create in addition to
> the new .bdrv_co_create for a while in all drivers, where the
> implementation of .bdrv_create would call .bdrv_co_create like this
> series does it for qcow2. We'll only be able to drop the old interface
> after deprecating and eventually removing all of the driver-specific
> compatibility work that remains. The example of qcow2 shows that the
> "translation" from old to new is managable, but there are a few
> differences.

Looks good. :-)

Max


--4zvot0kVzc3DA6tZq3QhxdstRHe4OpCk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvZpwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0ToH/iXrPl6WRsj0RDhIfoTDlfP77YY3ugyJ
au9sjFNu9IDJ2A9THjWbVmbYHQxSrqk+detzMDcFOrTQm9qiIzcoZ4yZn3p7t949
rQ4QzwHRS4ykyCTnEoN9RgC01uHcxW7nL5cdUgKr8R950h+RpQzidHe+N7BNNng0
bkuEFSS+9IkQ5aH9i/duHGRl2k9Y1ld1Ll/EQg/V6qN14IM3ltg/trUZ8mr+ecWa
kYhixeAYGFvFzRQOXEiETaZCC7tSOwIDb/fEeCVoypJMv/21dCDsn6CTSwZ1n3Cb
mVnL3gHrBf9oo25vstKJCoOrf8dcZjt5OlidIvywxXdizs4dxX6ER1c=
=JnNT
-----END PGP SIGNATURE-----

--4zvot0kVzc3DA6tZq3QhxdstRHe4OpCk8--
