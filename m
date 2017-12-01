Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrvp-0002vT-Sd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrvp-0003M2-1W
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 15:29:09 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-5-crosa@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b6d17acb-d48c-d319-86fb-bfc6fc89af4f@redhat.com>
Date: Fri, 1 Dec 2017 21:28:58 +0100
MIME-Version: 1.0
In-Reply-To: <20171116173810.16457-5-crosa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qhORqXXjUmpS4pVUvkMrNOGr6S5Iag9vc"
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-iotests: include (source)
 filters from common.rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qhORqXXjUmpS4pVUvkMrNOGr6S5Iag9vc
From: Max Reitz <mreitz@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <b6d17acb-d48c-d319-86fb-bfc6fc89af4f@redhat.com>
Subject: Re: [PATCH 04/10] qemu-iotests: include (source) filters from
 common.rc
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-5-crosa@redhat.com>
In-Reply-To: <20171116173810.16457-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-16 18:38, Cleber Rosa wrote:
> There's an explicit dependency from common.rc on common.filters, that
> is, it consumes functions defined there.  Just like common.config is
> included in common.rc, it makes sense to also sense common.filter.
>=20
> This drops the requirement on individual tests to include
> common.filter, reducing the amount of boiler plate code (while still
> making the comment found on almost every test "get standard
> environment, filters and checks" accurate.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qhORqXXjUmpS4pVUvkMrNOGr6S5Iag9vc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohu4oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhSwH/0Z8tnyLo4GE/tEeYn5KOhhNulfUzphL
+B2uEAh3myoZ4WnSbXedTi+wyPs8P7rrN5H9RS/1jfEn6ZKvEOQekofMe625jxKN
mAAZvEQUwM3G7uqCE8cDnm0E6hlU1Cd748NofMIJUQgAF7ZCAUTSfMSFBsn/7kAy
RlTX2AoDoFpy1R2elD9g6ujKvJseWxx4t7bgGs68vNLCCiT+g5cfTgsIVnb8k9lU
N57mLDXsH6P+8ezCqGKT9Uy/sj9zPpr+M6GlaKRpx/9XRxth5B+UGjOPXzdZOLMB
wzKSTIjwI7CKCh+7pGdYIqdOD6yU4tqr6bMb4MFOO0aYOzV9XMSrbhw=
=Gfd5
-----END PGP SIGNATURE-----

--qhORqXXjUmpS4pVUvkMrNOGr6S5Iag9vc--
