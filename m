Received: from eggs.gnu.org ([2001:4830:134:3::10]:59330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chehc-0003hV-Fa
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1chehY-0005lp-J6
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:56:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1chehY-0005lZ-Ap
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:56:04 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D54985540
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 15:56:04 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-12-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c2d13b1-91da-3c40-898b-74b96cb72f21@redhat.com>
Date: Sat, 25 Feb 2017 09:56:01 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-12-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9iiDa6rqW5l5WTWMrQJUgCaRoxUjh59CB"
Subject: Re: [Qemu-devel] [PATCH 11/21] qapi: Make QObject input visitor set
 *list reliably
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
--9iiDa6rqW5l5WTWMrQJUgCaRoxUjh59CB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4c2d13b1-91da-3c40-898b-74b96cb72f21@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/21] qapi: Make QObject input visitor set
 *list reliably
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-12-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:45 PM, Markus Armbruster wrote:
> qobject_input_start_struct() sets *list, except when it fails because
> qobject_input_get_object() fails, i.e. the input object doesn't exist.
>=20
> All the other input visitor start_struct(), start_list(),
> start_alternate() always set *obj / *list.
>=20
> Change qobject_input_start_struct() to match.

I thought I'd caught all those. Thanks for the cleanup.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/qobject-input-visitor.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9iiDa6rqW5l5WTWMrQJUgCaRoxUjh59CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYsakRAAoJEKeha0olJ0NqZ40IAJp+0eAFNjaW/5Z7MBRvLBv2
0iQUn4noqDrZUAY8PByh7ZGR6dQuHAgaPD/4hecGq5Xz6ZwetFDs+hucmC+vlcRy
StnO2Erj4HxnRoY4Kp8DvKhcOR+EBGJmq7BkaWx2tO1+hOXMEpCHij2UaBVJtHT+
HN5OvnpMZOSsxmaoi+iDdjhRGCeKcd82V7kNsu3owHDi8L0giBUusJjVnYpaHvYo
0xO4OfC32kQ5khkBAQz+CBNnzoSRqoBD/CQ5kWEuGf4tdDt8xm0vJGSS68hCLZh2
WmGHQ00YbFY/2CO7W3fr+7h3VlcpepVeTu+i0/Qj7z2yiTpSvgC8gXfgV5BpCXU=
=eL57
-----END PGP SIGNATURE-----

--9iiDa6rqW5l5WTWMrQJUgCaRoxUjh59CB--
