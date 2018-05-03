Received: from eggs.gnu.org ([2001:4830:134:3::10]:47901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRY-0000VJ-O6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fEDRW-0000N7-Hq
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fEDRW-0000Mv-Cs
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:34:38 -0400
Date: Thu, 3 May 2018 13:21:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180503122122.GG5301@stefanha-x1.localdomain>
References: <1525111345-14606-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <1525111345-14606-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] net: Get rid of 'vlan'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 08:02:22PM +0200, Thomas Huth wrote:
> The 'vlan' term caused a lot of confusion and misconfigurations in the
> past. The parameter has been marked as deprecated since QEMU v2.9.0, so
> it's now time to finally remove the parameter and use the better word "hu=
b"
> in the remaining spots that actually mean the QEMU emulated hub feature.
>=20
> v4:
>  - Some rewordings in qemu-doc.texi and qemu-options.hx according to
>    Stefan's and Paolo's suggestions
>=20
> v3:
>  - Some rewordings in qemu-doc and net.json according to Paolo's suggesti=
ons
>=20
> v2:
>  - Added first patch to actually remove the deprecated 'vlan' parameter
>    (instead of only updating the wording in the sources and docs)
>=20
> Thomas Huth (3):
>   net: Remove the deprecated "vlan" parameter
>   net: Get rid of 'vlan' terminology and use 'hub' instead in the source
>     files
>   net: Get rid of 'vlan' terminology and use 'hub' instead in the doc
>     files
>=20
>  docs/qdev-device-use.txt         |  3 --
>  hw/core/qdev-properties-system.c | 80 ----------------------------------=
------
>  include/hw/qdev-properties.h     |  3 --
>  include/net/net.h                |  1 -
>  net/hub.c                        |  7 ++--
>  net/net.c                        | 12 ++----
>  net/slirp.c                      |  8 ++--
>  net/tap.c                        |  4 +-
>  qapi/net.json                    | 15 ++++----
>  qemu-doc.texi                    | 51 ++++++++++++-------------
>  qemu-options.hx                  | 29 ++++++---------
>  11 files changed, 54 insertions(+), 159 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6v7BAAoJEJykq7OBq3PIAGIIAKderg57G19FZAQYWHDx8jyg
HNfEUabc6A6EGmGqaoZO/WrgS5tSEKLpPVQKqa0i00yAVl1ukXgLPR3CQ7KtrUSA
1xidpHTcV8TAM16jqfQ+QgmLh6SGEOcZNvnR2lNmvJXX40KtakKAQMYIhVwWqvfT
OEO5nv+aD5Z/0AndD2LAMFTERLkcz+RoOj9sPUb2uNmB1/EVdSfoZ0Gn28AjpmUn
HAYEveuj93SkUoMMS5mcJTvsdbl7f5Rf1JN8AWwC9I47WIga/Mp95vPYPjygdQJc
1CYCCne6LGJQ79p+vQWiJYA3MkOgv/4b34/XCq9mKQ3ms9MdcTfb1e27+t0wTJQ=
=cqQq
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
