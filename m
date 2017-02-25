Received: from eggs.gnu.org ([2001:4830:134:3::10]:57490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheX3-0005q4-UR
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cheWz-0002x2-4B
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:45:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cheWy-0002wX-UU
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:45:09 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12C7A83F38
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 15:45:09 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <605ccef6-5863-9509-dd03-2dd51d5c6685@redhat.com>
Date: Sat, 25 Feb 2017 09:45:06 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eU6vhTSCuwtMoO5n6lMk4eaXbO82lCfsP"
Subject: Re: [Qemu-devel] [PATCH 10/21] qapi: Clean up after commit 3d344c2
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
--eU6vhTSCuwtMoO5n6lMk4eaXbO82lCfsP
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <605ccef6-5863-9509-dd03-2dd51d5c6685@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/21] qapi: Clean up after commit 3d344c2
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> Drop unused QIV_STACK_SIZE and unused qobject_input_start_struct()
> parameter errp.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eU6vhTSCuwtMoO5n6lMk4eaXbO82lCfsP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsaaCAAoJEKeha0olJ0NqSPEH/0agVZSAWFGYNs30//fI8/jt
6ataDDFbT1QlqbS0fRMkHJlCpoU7d2aJXGjuPcwT5lZzt6Ge03wxuluUvuV586AC
jK19PLqCnVmPg2R4xjz9zOmDxCFIbFffOVxKJUoQj+zpzWZvF1CGpJFmZbMZEKIM
lFhwCJlOKILDkuDntgiX8qs+GjQsTUeeNkDRFD146QJ3DXgISkyhklnmbc3FOAW3
FvyfF/5uwbczxwQXzgnlJH2d5b1reznDCXbYfFagYtCdfmTF70zDsbx4Ji/WcLFs
de1jVjUFU4KXOjBTh+b6jvieCzRnGgpT/5+5gl2bfba4nrcWFnkdk+3xs16NO6k=
=b47X
-----END PGP SIGNATURE-----

--eU6vhTSCuwtMoO5n6lMk4eaXbO82lCfsP--
