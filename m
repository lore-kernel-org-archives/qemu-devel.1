Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chexT-0004Rj-0i
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chexP-00025W-So
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:12:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chexP-00025S-Nk
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:12:27 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3FEF61B9C
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 16:12:27 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-14-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8c77ea3-c5d2-5d47-ccc1-5f0ab54e73d5@redhat.com>
Date: Sat, 25 Feb 2017 10:12:25 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-14-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7e0dnO94Eb7qkGsUS6uEUmFkH9XE2gmOM"
Subject: Re: [Qemu-devel] [PATCH 13/21] qapi: Drop string input visitor
 method optional()
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
--7e0dnO94Eb7qkGsUS6uEUmFkH9XE2gmOM
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f8c77ea3-c5d2-5d47-ccc1-5f0ab54e73d5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/21] qapi: Drop string input visitor method
 optional()
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-14-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> visit_optional() is to be called only between visit_start_struct() and
> visit_end_struct().  Visitors that don't support struct visits,
> i.e. don't implement start_struct(), end_struct(), have no use for it.
> Clarify documentation.
>=20
> The string input visitor doesn't support struct visits.  Its
> parse_optional() is therefore useless.  Drop it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/visitor-impl.h |  4 ++--
>  qapi/string-input-visitor.c | 13 -------------
>  2 files changed, 2 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--7e0dnO94Eb7qkGsUS6uEUmFkH9XE2gmOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsazpAAoJEKeha0olJ0NqjvUH/16xBYswcTLE3pqd9QI+7DT8
x1Kft7+QqpB/AWmSLO6fRLhUdN3lJmQCrEyOtby3YhTycEgb8yMlGLiDQloa0tpm
fEG24fJB5zpvxiMlPMBu0dVuq4EYkijroOq4LtlXY8yo+NeAExm2wxSAgGHUQNLv
qPu/+zRgjCDah18A7AvJ0gCa105LnARHCqEP/A7jqzexVWbxV4wpiqLryYu+9WsU
ajzRaX+B+P5fFxnY1Iu5/14LRw0C2bUlJ8Hpej6hf2YKywFlwT7e1XPLP0QJ1dYK
CyzYmxEo0k6PSpbcjRPcKATwa1k86wOSpCpiJ36RdHw1n1zwu3c4NP0JneQHp0Q=
=OyG9
-----END PGP SIGNATURE-----

--7e0dnO94Eb7qkGsUS6uEUmFkH9XE2gmOM--
