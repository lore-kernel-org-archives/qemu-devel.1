Received: from eggs.gnu.org ([2001:4830:134:3::10]:50367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYu-0004ny-UB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRFYs-0001gn-OE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRFYs-0001gY-He
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:51:18 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A00F4C049D59
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 09:51:18 +0000 (UTC)
Date: Tue, 10 Jan 2017 16:40:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170110164016.GC19869@stefanha-x1.localdomain>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-48-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bu8it7iiRSEf40bY"
Content-Disposition: inline
In-Reply-To: <20170106155543.12827-48-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 47/47] trace: improve error reporting
 when parsing simpletrace header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 03:55:43PM +0000, Daniel P. Berrange wrote:
> When loading a simpletrace binary file we just report
> "Not a valid trace file!" which is not very helpful. Report
> exactly which field we found to be invalid.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/simpletrace.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Bu8it7iiRSEf40bY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdQ5wAAoJEJykq7OBq3PINNQH/jDD9ljmY5Pzg5OEdHPR4ePn
TMAQisjNHo1NUzFSAppvaAi5MGtPPanjDtrrL+wtmJSxwFaeoU2IIgYMrZrkQPqd
vJFqGVk5V/SQWHvW0uQZTfKjq7NZ7LXux/+Hn+YMof2kgRhqjoOWGnkTvT7UMj1C
BJa/pvNFwqp8v4V3QDvP7JrCfi6ZBjZaTLtsI8jAykEeZU0LC3/q4StDt4DGIEYb
d8WGfzSvPruJnHX+5XpM4A+/m6nok4+khBn6MuE4GRvXUA42IW4wA6vFwfgU5Yjl
P5G59KCeq8VN9KnpqMo8qpD+99I+s9qOigrrP+taXMXLBSgYi6rr1n6sRz4DQ0M=
=uNcL
-----END PGP SIGNATURE-----

--Bu8it7iiRSEf40bY--
