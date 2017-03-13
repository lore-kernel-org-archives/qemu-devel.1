Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnXI1-0006uS-6W
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnXHy-0006fx-0W
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:14:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnXHx-0006fg-Nt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 17:13:57 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13570a92-1727-f8b1-cbe5-48c53170fa8c@redhat.com>
Date: Mon, 13 Mar 2017 16:13:55 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FmpgCcPOQLPsfshBEHEGT0X2UR99Sb0AA"
Subject: Re: [Qemu-devel] [PATCH for-2.9 03/47] qapi: Back out doc comments
 added just to please qapi.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FmpgCcPOQLPsfshBEHEGT0X2UR99Sb0AA
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <13570a92-1727-f8b1-cbe5-48c53170fa8c@redhat.com>
Subject: Re: [PATCH for-2.9 03/47] qapi: Back out doc comments added just to
 please qapi.py
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> This reverts commit 3313b61's changes to tests/qapi-schema/, except
> for tests/qapi-schema/doc-*.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Tested by doing:

$ git checkout 3313b61
$ git cherry-pick 07c7b92 # the current id on your qapi-doc branch
$ git diff HEAD^^ --stat tests/qapi-schema | grep -v /doc-
 72 files changed, 164 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>  200 files changed, 92 insertions(+), 1074 deletions(-)

It's a shame we did that much busywork adding test documentation in the
first place.  But it was incomplete (as I found out when trying to
convert some existing tests of failures into new tests of success, by
adding features like anonymous bases to flat unions), and indeed does
not add much value.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--FmpgCcPOQLPsfshBEHEGT0X2UR99Sb0AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYxwuTAAoJEKeha0olJ0Nqt/kH/0lpbqV/t8Sq/BhGQvPrKDaJ
+9dFHxdYMthfiQjWabK7p1l0GbXOgyRmkwXgcyZKSA//gi2skaRuuud3CCb0YdTX
kJMwKxI5t5B/bs62OLWXns/yKhsiwANZygb9tuG3qgZCyyYUar+IjwZ1X66LwKQO
HTLoksgFw64lJ6fd9J+zy1f9US8I++SE2BFkYGQLaHxuUSnLXMJPwLWiqvyDHxvf
zVZMJzX2VKCJrfhqW0QzLeF1tn9gw4PVD5cCKER15d2xrzhGLREDcoHpeZVguFA7
m5czcL6d7yBL/xfwmz8fgguLKJyjaSUgAPTztldtDV6p2t6pVmrxSIvYgeu/U9M=
=WpBA
-----END PGP SIGNATURE-----

--FmpgCcPOQLPsfshBEHEGT0X2UR99Sb0AA--
