Received: from eggs.gnu.org ([2001:4830:134:3::10]:49346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGOh-0004B8-D8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgGOe-0008OW-8i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:46:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgGOd-0008OQ-VT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:46:48 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 164F383F3E
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:46:48 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <26dcdf8d-3403-c8cb-52aa-4aceb90a75dc@redhat.com>
Date: Tue, 21 Feb 2017 13:46:45 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gteS6jE70UEQSu3KV1ITcgffh30egvQPr"
Subject: Re: [Qemu-devel] [PATCH 14/14] block: Don't bother asserting type
 of output visitor's output
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
--gteS6jE70UEQSu3KV1ITcgffh30egvQPr
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <26dcdf8d-3403-c8cb-52aa-4aceb90a75dc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/14] block: Don't bother asserting type of
 output visitor's output
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> After a visit of a complex QAPI type FOO
>=20
>     ov =3D qobject_output_visitor_new(&foo);
>     visit_type_FOO(ov, NULL, expr, &error_abort);
>     visit_complete(ov, &foo);
>=20
> we can safely assume qobject_type(foo) is QTYPE_QDICT.  We do in many
> places, but occasionally assert qobject_type(obj) =3D=3D QTYPE_QDICT.
> Don't.  The appropriate place to check such fundamental properties of
> QAPI visitors is the test suite.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/nbd.c  | 2 --
>  block/nfs.c  | 2 --
>  block/qapi.c | 1 -
>  3 files changed, 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gteS6jE70UEQSu3KV1ITcgffh30egvQPr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJklAAoJEKeha0olJ0Nqa2YH/0/Ku3kQV60m2+r8Jp7yWkad
dC8Oocg78Y1ukI+Y5IyWAUh30H8bh7klOXPn7RedhBi9k36Mj/bix9CPPGEXUTPq
n6UvrXK1qA+DU74rdOH513YJp0Bfirt+s8z3PyanVAxvLKV9v3PmRGjUnJ/z//2i
Eo4NWioKOGU4UR/DwFK95ml1KCQWcIAZYlmr6VnmVHHuWHGEF/kKncilV5LI3A7d
UapEtgVVFVUnRGWdKt/Gtx72FrOWmAMJdq0Jdp+Bj1b1iF0D5ABAe2mKkwOOlXnD
cP7XnUfDuiRb29B1qyJDHAhUfEvP8Rgna51U4NjOWJ8Va0yTD92qnbYQK+f7f6o=
=tzvc
-----END PGP SIGNATURE-----

--gteS6jE70UEQSu3KV1ITcgffh30egvQPr--
