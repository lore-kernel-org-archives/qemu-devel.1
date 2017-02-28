Received: from eggs.gnu.org ([2001:4830:134:3::10]:49497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikVn-0000Pp-Qg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikVj-0004Qe-Su
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:20:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cikVj-0004PR-Ng
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:20:23 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E67377FB68
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 16:20:23 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-26-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62858acc-90b8-06a3-ab24-aa7627b6672e@redhat.com>
Date: Tue, 28 Feb 2017 10:20:21 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-26-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MrlHsqVxpwNP956Tv1QGFjK4l2UgMicoX"
Subject: Re: [Qemu-devel] [PATCH v2 25/26] qapi: Fix object input visit
 beyond end of list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MrlHsqVxpwNP956Tv1QGFjK4l2UgMicoX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <62858acc-90b8-06a3-ab24-aa7627b6672e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 25/26] qapi: Fix object input visit beyond
 end of list
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-26-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-26-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c       | 11 ++++++++---
>  tests/test-qobject-input-visitor.c |  2 --
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MrlHsqVxpwNP956Tv1QGFjK4l2UgMicoX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaNFAAoJEKeha0olJ0Nq+NwH/jWvZ5W3TrydTAKkGolg/j3R
RHz7Oc7BBCVtf0q1n1xhOyOipStoY7Jg7McFqcT/mq8hacGzTPZ5FddFYF0IKCVk
dO/jvMWrm4G+09EUGwGtK2mjvtHLE4lDJBZ0A2/BaMYm0SFO/nNS6Y8QpYu2I4uz
btrvvbiadOLusIMg7A5EfDNCzUC2eqEENkUNiJVoHFCIMECQm3r+zTEL+ZZVpJ/0
uEHAjhh27xzD7ra9BptFVKwo+Thdo1ncAOcx7WrvCOQB6GVBv3d2Aawukn7B3Zr0
CmR16roW+4AvIkxZ09yn9IU0+1rLAhRXrFqW+VmQRIgGLvUK60n3y3eqCSZJwzw=
=F2FL
-----END PGP SIGNATURE-----

--MrlHsqVxpwNP956Tv1QGFjK4l2UgMicoX--
