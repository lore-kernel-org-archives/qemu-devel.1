Received: from eggs.gnu.org ([2001:4830:134:3::10]:46385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdj5F-00019G-Ev
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdj5B-0006uu-Be
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:48:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cdj5B-0006ub-5G
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:48:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01E13C04BD3D
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 19:48:13 +0000 (UTC)
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46563412-c1db-00fe-892a-de59b0208eb3@redhat.com>
Date: Tue, 14 Feb 2017 13:48:10 -0600
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eP67Lph89gQ8wfv62qe0ABMfFPGclThO4"
Subject: Re: [Qemu-devel] [PATCH 01/24] tests/test-qemu-opts: Cover
 qemu_opts_parse()
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
--eP67Lph89gQ8wfv62qe0ABMfFPGclThO4
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <46563412-c1db-00fe-892a-de59b0208eb3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/24] tests/test-qemu-opts: Cover
 qemu_opts_parse()
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
 <1487067971-10443-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:25 AM, Markus Armbruster wrote:
> The new tests demonstrate a few bugs, all clearly marked.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qemu-opts.c | 294 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 292 insertions(+), 2 deletions(-)

>=20
> +
> +    /* Anti-social ID */
> +    opts =3D qemu_opts_parse(&opts_list_01, "id=3D666", false, &err);

Love it. It's always fun to see cute references in a testsuite.

Obviously, the rest of this series cleans up the messes you've
uncovered.  Some of those new tests are pretty embarrassing.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--eP67Lph89gQ8wfv62qe0ABMfFPGclThO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYo176AAoJEKeha0olJ0NqwTAH/i8KIOQI04iy7qvZZpgseP9+
Zm6pE2x4ktEAPbtytfJfEoVKBBjm0928UD5EzK1DStuQYWK+ioi+XpK+yD/srsuz
4BAWrG4/gZ5TYff+7l47nmNCeFKxruZ1pahi0Ffqb27lwYkqjphbJqCDxi/pKPV6
GCrYZ3gCAKzgznYftc/6TCB0dhAV/0AYUfaxwCSfhu5at4BVd6lc8ejS1fuIKd4g
3q3tKMkg416nkJmRLzB/5C3kMpxJmAj6p2gknJWuAJ+LxP/mzOtqaQdUq19PXslC
mw58qx/6po2dRCujRyyPm3hoshzVMG5vRfKsGOW9SYOgza28v/jAU9VmZ1BS15M=
=FSGo
-----END PGP SIGNATURE-----

--eP67Lph89gQ8wfv62qe0ABMfFPGclThO4--
