Received: from eggs.gnu.org ([2001:4830:134:3::10]:33735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlUF-0005Qm-In
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evlU6-0006Vh-2Q
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:05:11 -0400
References: <20180313144730.2184-1-kwolf@redhat.com>
	<20180313144730.2184-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c36b638a-f8be-670a-f2fb-88584af1dbca@redhat.com>
Date: Tue, 13 Mar 2018 16:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180313144730.2184-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L4WpSLWk8Osv6HZ8FnLILNBrGfUqwFaLg"
Subject: Re: [Qemu-devel] [PATCH v2 8/8] vpc: Require aligned size in
 .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L4WpSLWk8Osv6HZ8FnLILNBrGfUqwFaLg
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <c36b638a-f8be-670a-f2fb-88584af1dbca@redhat.com>
Subject: Re: [PATCH v2 8/8] vpc: Require aligned size in .bdrv_co_create
References: <20180313144730.2184-1-kwolf@redhat.com>
 <20180313144730.2184-9-kwolf@redhat.com>
In-Reply-To: <20180313144730.2184-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-13 15:47, Kevin Wolf wrote:
> Perform the rounding to match a CHS geometry only in the legacy code
> path in .bdrv_co_create_opts. QMP now requires that the user already
> passes a CHS aligned image size, unless force-size=3Dtrue is given.
>=20
> CHS alignment is required to make the image compatible with Virtual PC,=

> but not for use with newer Microsoft hypervisors.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vpc.c | 113 +++++++++++++++++++++++++++++++++++++++++++---------=
--------
>  1 file changed, 82 insertions(+), 31 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--L4WpSLWk8Osv6HZ8FnLILNBrGfUqwFaLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqn6JMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AU78H/0c7i6rE3qRagH474XhvrNQhD7qzEpdR
M56bDV1h6kWQzcZMs1+WZLLIifdAiLxvpsd27L+qhkawL3iPRUedMCT+cwyUWjiM
autFLleXs+cuH3mW8AYQ3FOUXofxYfebIU3ktD0fLNeKwHP68jknCRGOHwcYEkRd
frg0OuzBFVjgIQDt3fw7R0iTdw1zRf1pNEYq/qj+UccvbmTSILxIBjYAg6cuvpRS
/PUqr2NWB3AeolvIsAO+JCbTQbyNNBqao4vv4QqtfhT/hdj4ybx6fCEsii3S5nEh
qIlW7TShdWLUEI695bUhYw+oIe2wIe60B9pvrMbTXPQ3nU/lhze4MaQ=
=Xwjb
-----END PGP SIGNATURE-----

--L4WpSLWk8Osv6HZ8FnLILNBrGfUqwFaLg--
