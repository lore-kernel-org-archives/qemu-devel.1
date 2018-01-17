Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnmv-0002bb-Pi
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnmu-0001ta-ND
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:29:57 -0500
References: <20171129185102.29390-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <27daf5bc-00a1-ca51-a158-0d466569b095@redhat.com>
Date: Wed, 17 Jan 2018 14:29:45 +0100
MIME-Version: 1.0
In-Reply-To: <20171129185102.29390-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u832DvdeqYffVzwWHpM3jtQ8gAyovIeGr"
Subject: Re: [Qemu-devel] [PATCH for-2.12] qemu-iotests: Fix locking issue
 in 102
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
--u832DvdeqYffVzwWHpM3jtQ8gAyovIeGr
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <27daf5bc-00a1-ca51-a158-0d466569b095@redhat.com>
Subject: Re: [PATCH for-2.12] qemu-iotests: Fix locking issue in 102
References: <20171129185102.29390-1-mreitz@redhat.com>
In-Reply-To: <20171129185102.29390-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-29 19:51, Max Reitz wrote:
> 102 truncates a qcow2 file (the raw file) on purpose while a VM is
> running.  However, image locking will usually prevent exactly this.
>=20
> The fact that most people have not noticed until now (I suppose you may=

> have seen sporadic failures, but not taken them too seriously, like me)=

> further shows that this truncation is actually not really done
> concurrently, but that the VM is still starting up by this point and ha=
s
> not yet opened the image.  Remedy this by waiting for the monitor shell=

> to appear before the qemu-img invocation so we know the VM is up.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/102     | 7 ++++++-
>  tests/qemu-iotests/102.out | 3 ++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied to my block branch.

Max


--u832DvdeqYffVzwWHpM3jtQ8gAyovIeGr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfT8kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0qMIAJojMPhziYF3zQUEVq7AM3z6vvPODXhT
1NT0qjKn/qv7j7NMt2oreR6NXrPY+w8lMHEZeOLOAEWt8jmCRtl7gjK7DrSxJCWu
psVqs6QHKLKg8MGQTjckPgVfF2xDBVny3sagnaFgpP39zBlxWdUT2Ndx74co7TCy
kAex5YutecjkoobAgXli6Y53WMOEiN3tfE9ZcKTeL28vhyn0KrDaXBQMLlBW/CXC
hr5J0tog7nE8ZDW2xUkuv2N1VhaOoh4XNteabry0HXPZNwWaMwYqpWmd2KOlULRX
raGBaGtnurFxTYjvXQo3xsxGYS2IN2OpcBcrpBkpRpsqJnZk9ycTeBE=
=vY5D
-----END PGP SIGNATURE-----

--u832DvdeqYffVzwWHpM3jtQ8gAyovIeGr--
