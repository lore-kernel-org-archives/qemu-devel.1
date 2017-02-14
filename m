Received: from eggs.gnu.org ([2001:4830:134:3::10]:48602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkiY-0001MB-2D
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdkiU-0001SB-U3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:32:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdkiU-0001Re-L9
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:32:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B711F61E53
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 21:32:54 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <934536f3-86e9-3efa-beb7-6d0dfa4280b0@redhat.com>
Date: Tue, 14 Feb 2017 15:32:52 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="baGAMPoo7KdNsBpTUaV843k9aPOEIp1da"
Subject: Re: [Qemu-devel] [PATCH 05/24] util/cutils: Rewrite documentation
 of qemu_strtol() & friends
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
--baGAMPoo7KdNsBpTUaV843k9aPOEIp1da
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <934536f3-86e9-3efa-beb7-6d0dfa4280b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/24] util/cutils: Rewrite documentation of
 qemu_strtol() & friends
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> Fixes the following documentation bugs:
>=20
> * Fails to document that null @nptr is safe.
>=20
> * Fails to document that we return -EINVAL when no conversion could be
>   performed (commit 47d4be1).
>=20
> * Confuses long long with int64_t, and unsigned long long with
>   uint64_t.
>=20
> * Claims the unsigned conversions can underflow.  They can't.
>=20
> While there, mark problematic assumptions that int64_t is long long,
> and uint64_t is unsigned long long with FIXME comments.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/cutils.c | 80 +++++++++++++++++++++++++++++++++------------------=
--------
>  1 file changed, 45 insertions(+), 35 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--baGAMPoo7KdNsBpTUaV843k9aPOEIp1da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo3eEAAoJEKeha0olJ0NqFTsH/1/+eQkpFW3O66oRMPnLECA9
D5HrO+YBn1ZvYqTeq9DWf3d698tqMKzvOfDu5PcmCI9sAg/YIOUX/x/E815P46k1
AwWZEqzUkkaC1/3i7nBkVqjuXwO7dFCyKGuT1dtx6dwN2qm9Vttzm7z3Q+fqT4EX
w9bwjDFNfv3dP+NmUK2jBYK4nrMAP0n9wWEjC+NqB5nTqKhAUXNeDruF+AA1dKii
fFJTuQRcACvTrqGWFQcCmwJK7sdwh6sNcm/Yl6BamC+dkVwnrTw25GH/m16QXWTI
EgFW7HTr4yYSRahbaoZdb3B7vI0OZ1xdECP0XArNAcO1lOTK3wdNA+ylsVMEwS8=
=6LSL
-----END PGP SIGNATURE-----

--baGAMPoo7KdNsBpTUaV843k9aPOEIp1da--
