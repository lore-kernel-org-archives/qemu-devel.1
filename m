Received: from eggs.gnu.org ([2001:4830:134:3::10]:36259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8ui-0006ml-Ab
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP8uf-0000ci-6F
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP8ue-0000c1-Vg
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:25:37 -0500
Date: Wed, 13 Dec 2017 15:25:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213152524.GB7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 01/26] qobject: introduce
 qstring_get_try_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:35PM +0800, Peter Xu wrote:
> The only difference from qstring_get_str() is that it allows the qstring
> to be NULL.  If so, NULL is returned.
>=20
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/qstring.h |  1 +
>  qobject/qstring.c          | 10 ++++++++++
>  2 files changed, 11 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUZkAAoJEJykq7OBq3PIQZQH/0iymcsdcBGWZJVahCTXC9jI
2y8EqrWHEU5YBEeIiBfTIay/0od7nQQL10VqMQpwdcc5i4epB+RFkReYQufLZEHU
9DLKAnXNxviVkEuSxhJ1KOJRkQMa16IfHfOmamyaZIm8Xf67F9b4qtW0FJtopnlr
Z6INfZByFcdQ4/z39ICwgYvq27mto5vRECVdq7gqcPw57FT3qOmfjAtR4SC9RIwJ
O9UnsMFFhxP+Mw1igMB66NmyxBEpZipRPXUYOGrfK7ugzSj7ljaxUV3OTffJFfbV
V89H34FH93D6xjT1ieFAvvi6YfsVY4oPv2gIvRrS+ijxDjVWauhXeMTZz6vc/kQ=
=oi7c
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
