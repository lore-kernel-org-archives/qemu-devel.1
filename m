Received: from eggs.gnu.org ([2001:4830:134:3::10]:45852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciQvi-0001ay-O1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciQvh-0006Ed-Kh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:25:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciQvh-0006EJ-CG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:25:53 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9700A4E4F5
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 19:25:53 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-16-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13bf8963-248a-bf46-46b7-812290ae48be@redhat.com>
Date: Mon, 27 Feb 2017 13:25:51 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-16-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="snCO2fBKEr5Bg7CExAf6Kr87AKlwtBoOE"
Subject: Re: [Qemu-devel] [PATCH v2 15/26] qom: Make
 object_property_set_qobject()'s input visitor strict
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
--snCO2fBKEr5Bg7CExAf6Kr87AKlwtBoOE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <13bf8963-248a-bf46-46b7-812290ae48be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/26] qom: Make
 object_property_set_qobject()'s input visitor strict
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-16-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Commit 240f64b made all qobject input visitors created outside tests
> strict, except for the one in object_property_set_qobject().  That one
> was left behind only because Eric couldn't spare the time to figure
> out whether making it strict would break anything, with a TODO
> comment.  Time to resolve it.
>=20
> Strict makes a difference only for otherwise successful visits of QAPI
> structs or unions.  Let's examine what the callers of
> object_property_set_qobject() visit:
>=20
> * object_property_set_str(), object_property_set_bool(),
>   object_property_set_int() visit a QString, QBool, QInt,
>   respectively.  Strictness can't matter.
>=20
> * qmp_qom_set visits its @value argument.  Comes straight from QMP and
>   can be anything ('any' in the QAPI schema).  Strictness matters when
>   the property's set() method visits a struct or union QAPI type.
>=20
>   No such methods exist, thus switching to strict can't break
>   anything.
>=20
>   If we acquire such methods in the future, we'll *want* the visitor
>   to be strict, so that unexpected members get rejected as they should
>   be.
>=20
> Switch to strict.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qom/qom-qobject.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--snCO2fBKEr5Bg7CExAf6Kr87AKlwtBoOE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtH0/AAoJEKeha0olJ0NqHN0H/1tVAH5JQj9S9FsZ7vImJl5Q
ZI4t3xfAnob9SgXyYmW1EQ6OGuiP6bfuwfC0v6kZ1RsnpY9Y9B+g9nI93LFTXcuh
sGmjbAhzO/yVcs/mRvNMd0zZSdFh8IFheiQzOBRoK8+PJupiWmT6w0AiMtq6nnzU
WJJWs5dyEIWk2vgVJPIJT2eLi2qfJDSTp1+0lZOgtCXqidvhBokFf1IqxionPz6l
cxp/Pd6DvzwewRPjxR9jIPgHIfVx0NwbDhEIROe07cpKF6iGDwpsiHwCoyNlvl7I
wDueGQuvr99vtxwuC7KlOJt+lxEjvYklP58edBG64RJ3HLs4WxGVtdyMt28w+oo=
=gw5L
-----END PGP SIGNATURE-----

--snCO2fBKEr5Bg7CExAf6Kr87AKlwtBoOE--
