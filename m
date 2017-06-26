Received: from eggs.gnu.org ([2001:4830:134:3::10]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPWNu-0000dm-2E
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPWNq-0005uH-4k
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dPWNp-0005tJ-VP
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 11:57:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C86E87D4E0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 15:56:59 +0000 (UTC)
Date: Mon, 26 Jun 2017 16:56:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170626155656.GJ29664@stefanha-x1.localdomain>
References: <20170624181008.25497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5me2qT3T17SWzdxI"
Content-Disposition: inline
In-Reply-To: <20170624181008.25497-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, marcandre.lureau@redhat.com


--5me2qT3T17SWzdxI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 24, 2017 at 12:10:06PM -0600, Eric Blake wrote:
> v1 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02589.html
>=20
> Since then:
> - reorder the series
> - add R-b on patch 1
> - patch 2 updated to catch recent introduction of longhand usage
>=20
> Eric Blake (2):
>   qobject: Catch another straggler for use of qdict_put_str()
>   qobject: Update coccinelle script to catch Q{INC,DEC}REF
>=20
>  monitor.c                        | 2 +-
>  qemu-img.c                       | 2 +-
>  scripts/coccinelle/qobject.cocci | 6 ++++++
>  3 files changed, 8 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.9.4
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5me2qT3T17SWzdxI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUS7IAAoJEJykq7OBq3PIkGkH/3S1eoVZFfpPM7aonrXi6anU
TqjnvVg2lot7sPbmy1bvZNY6/C4ldHeLfzVGk0J6CgfYlwnQksH4I8bx/E1JfDIm
hIM9Ib8Tp2F6e1e+DNernlsHANKtPihjxGgsiBldpMf+KlWPV2yphEb166mysYNz
APpVYLkk5hHa05f+uwX9E1yrKllG8uMpb8ItOOidvr3yNnbNz5j7LOi90xJzKEXP
1dYFVsehc64TLzL6qX8MKHBTfetItxt0eMY3M6uBxYr4cv1ZNhx6qGSAb7mjN9sO
ukYN2QkFkXTO9sN1VoidXkDbc/ePcCvkFMwxZzPoINtRAkXgEUPAIYIKiIhJsIk=
=qumj
-----END PGP SIGNATURE-----

--5me2qT3T17SWzdxI--
