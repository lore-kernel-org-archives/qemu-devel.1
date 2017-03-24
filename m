Received: from eggs.gnu.org ([2001:4830:134:3::10]:33444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUWU-0007TI-JW
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1crUWP-0005xW-Ml
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1crUWP-0005xB-FV
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 15:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BA5C8F253
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 19:05:13 +0000 (UTC)
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
	<1490377482-13337-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3227f9e9-b7be-5c37-b3b2-2ba2ecb79738@redhat.com>
Date: Fri, 24 Mar 2017 14:05:10 -0500
MIME-Version: 1.0
In-Reply-To: <1490377482-13337-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="toew4eupxSlWhQEJFOM02GgJ8lOKC5Vli"
Subject: Re: [Qemu-devel] [PATCH RFC v2 9/9] rbd: Reject invalid
 authentication methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--toew4eupxSlWhQEJFOM02GgJ8lOKC5Vli
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <3227f9e9-b7be-5c37-b3b2-2ba2ecb79738@redhat.com>
Subject: Re: [PATCH RFC v2 9/9] rbd: Reject invalid authentication methods
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
 <1490377482-13337-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/24/2017 12:44 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/rbd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

In short, since we have a QAPI enum of valid types, we should verify
that all members of the list match that enum.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--toew4eupxSlWhQEJFOM02GgJ8lOKC5Vli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1W3nAAoJEKeha0olJ0NqadwH/0ewq5PQ2K36qNOIfPtt+ZpA
tRhce4qtvS4edt8FpF7cv4br4UGj25KlynVcYX/cbuwON68yXYBgr8aG727be62b
KK1TyN0wNMS8GPRF+Rfgp5Lv/3M8bk/+idH6VyF553gNcppfo2H1oSgsOzTvLiOy
0V7B4NWrshtbE0kmO4MmC2rRiLqH0FwFQNFVvPfGmslVUZpp/Z80dFz9Ob6PVdiM
wop5GK+5oB7JBTlLYwbcPAGgXzxjGVIkFXI6M9qdm1x/XfDAfB2Y4fn43X0YPPNj
eqV77IQeNKCdD0a2t+eZ6STlyljz+KWk6XNuzPu0Nqvi41US+fV1uTov9CkLgSs=
=ox/k
-----END PGP SIGNATURE-----

--toew4eupxSlWhQEJFOM02GgJ8lOKC5Vli--
