Received: from eggs.gnu.org ([2001:4830:134:3::10]:58156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaBG-0007rS-2z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjaBF-0001Kv-0g
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:30:42 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1494c534-50ec-5020-2c9d-76f14fac17e5@redhat.com>
Date: Thu, 2 Mar 2017 17:30:33 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e4tDfppNlTgJ1nFdsahiV8wpPqF8FdLxK"
Subject: Re: [Qemu-devel] [PATCH 05/15] sheepdog: Fix snapshot ID parsing in
 _open(), _create, _goto()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e4tDfppNlTgJ1nFdsahiV8wpPqF8FdLxK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <1494c534-50ec-5020-2c9d-76f14fac17e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/15] sheepdog: Fix snapshot ID parsing in
 _open(), _create, _goto()
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:43 PM, Markus Armbruster wrote:
> sd_parse_uri() and sd_snapshot_goto() screw up error checking after
> strtoul(), and truncate long tag names silently.  Fix by replacing
> those parts by new sd_parse_snapid_or_tag(), which checks more
> carefully.

At least we've fixed checkpatch to gripe at new uses of strtoul(), but
yeah, we've got lots of existing poor usage.  It is a very hard
interface to use correctly, as evidenced by your cleanups here.

>=20
> sd_snapshot_delete() also parses snapshot IDs, but is currently too
> broken for me to touch.  Mark TODO.
>=20
> Two calls of strtol() without error checking remain in
> parse_redundancy().  Mark them FIXME.
>=20
> More silent truncation of configuration strings remains elsewhere.
> Not marked.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++--=
--------
>  1 file changed, 55 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--e4tDfppNlTgJ1nFdsahiV8wpPqF8FdLxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYuKsZAAoJEKeha0olJ0NqjqAH/3BV5A81/G9+OwM96wFRuHla
0itJ//YGNO4YRhSpkNohoSVC23OcDMuXoTRMoOunvRDc4HFgjSXSwxMoeqUmJQ84
Bj0e35zpY4a9rCtDWS20MIIA7kW21VpdZEniJJeUrpArYAjVK09GvCEu6+wQQhLh
DIRue8J8Kw+mwhqNEcfMIT6ApshnuOkwKKlrN62NV+38NhS1Z9jU4bGog2rzsPHw
4KinBTDBu9YCUiZlABYtk9360h2WsOQHQehFkTekKf3L7QD1/rQ9RLlVpTEhZ0tH
lKpCOIuZSLj6pccxzuxIA4d0ofCDQ1NLQihyNu1U1HxlwQ5Fmye9kXEk3DX0Wkw=
=T4fP
-----END PGP SIGNATURE-----

--e4tDfppNlTgJ1nFdsahiV8wpPqF8FdLxK--
