Received: from eggs.gnu.org ([2001:4830:134:3::10]:35695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Jp-0005V5-5u
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq3Jo-0006pI-EY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 15:50:17 -0400
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <260797ce-5d60-d49d-df6e-aff8e05b7460@redhat.com>
Date: Mon, 20 Mar 2017 14:50:09 -0500
MIME-Version: 1.0
In-Reply-To: <1490014548-15083-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B259gFCtOC4ef5fduCHJBpTgXaeB8TTAa"
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/5] test-keyval: Tweaks to improve
 list coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B259gFCtOC4ef5fduCHJBpTgXaeB8TTAa
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <260797ce-5d60-d49d-df6e-aff8e05b7460@redhat.com>
Subject: Re: [PATCH for-2.9 1/5] test-keyval: Tweaks to improve list coverage
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
 <1490014548-15083-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1490014548-15083-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 07:55 AM, Markus Armbruster wrote:
> We have a negative test case for a list index with leading zero.  Add
> positive ones.
>=20
> Tweak the test case for list index greater or equal the number of
> elements: test "equal" instead of "greater" to guard against
> off-by-one mistakes.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-keyval.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--B259gFCtOC4ef5fduCHJBpTgXaeB8TTAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0DJxAAoJEKeha0olJ0NqCZsIAJJY7/0+IGKnqFSdMDs0ji4n
JIxNU0bnuaI0DEFPslNDRQdmcGL6qtvTZTU20UNWeRDpVQglOOG9+0J/EFwEg1lu
21FuvrnVK/Dw0wxvLfs1a5FgBoBJPI9/E+SVtz3KzuQacCQPnIeb01OEoaPD0YMV
Qft2qRbLfBEkXcmGOmfj/VQ4T9duUjssEnIPfEf1ZeiQP0kZS5ywsJ+CCwLyA7L9
mDVlYSu/JzgFV5sucdw/YaHUS9c41RdjbWPSvC44g1USJ2ilx4q0itVNalJEcYzF
wo7c8C66tALEhi8J+ubcXF5rnUlHt8obX+YJ03t8cuKo8zjV6dyEFwUmZPopQTg=
=6DjX
-----END PGP SIGNATURE-----

--B259gFCtOC4ef5fduCHJBpTgXaeB8TTAa--
