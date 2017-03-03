Received: from eggs.gnu.org ([2001:4830:134:3::10]:37647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs3C-0008Fv-0b
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs3B-0008RP-6m
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:35:34 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-15-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e67251ad-1f7c-d0da-4a82-12a10ae5e126@redhat.com>
Date: Fri, 3 Mar 2017 12:35:25 -0600
MIME-Version: 1.0
In-Reply-To: <1488491046-2549-15-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iA7ooglt5DUTWkAkGGLI0Ub8USgomBG0M"
Subject: Re: [Qemu-devel] [PATCH 14/15] qapi-schema: Rename
 SocketAddressFlat's variant tcp to inet
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
--iA7ooglt5DUTWkAkGGLI0Ub8USgomBG0M
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com,
 qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <e67251ad-1f7c-d0da-4a82-12a10ae5e126@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/15] qapi-schema: Rename
 SocketAddressFlat's variant tcp to inet
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-15-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/02/2017 03:44 PM, Markus Armbruster wrote:
> QAPI type SocketAddressFlat differs from SocketAddress pointlessly:
> the discriminator value for variant InetSocketAddress is 'tcp' instead
> of 'inet'.  Rename.
>=20
> The type is far only used by the Gluster block drivers.  Take care to
> keep 'tcp' working there.

The old name was visible in QMP in 2.8, but only by blockdev-add, which
we've already argued was not stable (and where we've already made other
non-back-compat changes to it).  But that means this HAS to go into 2.9,
if we're declaring blockdev-add stable for 2.9.

It wouldn't hurt to mention that additional information in the commit
message.

>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c  | 59 +++++++++++++++++++++++++++++-------------------=
--------
>  qapi-schema.json |  8 ++++----
>  2 files changed, 35 insertions(+), 32 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -4105,14 +4105,14 @@
>  #
>  # Available SocketAddressFlat types
>  #
> -# @tcp:   Internet address
> +# @inet:   Internet address
>  #
>  # @unix:  Unix domain socket

Nit: Spacing is now inconsistent.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--iA7ooglt5DUTWkAkGGLI0Ub8USgomBG0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubdtAAoJEKeha0olJ0NqJjIIAKbVsGOxKY8d3tM0InPumkan
FK60tKrJqGnC910KwvmwzcvW4oH5arkFUYnAEluT5BzF6bSVyfhWaYe+LPW6XEB5
7MH5tLLdDyqDeT58nDdAR75KFdbtesfz8ItUfWvLsHfRuln3A9vHvBRqJYXm7Mzr
KB+Oa2fiUXr0eAHpaNYQ/6zWj2XOU7UBftEkrwDZ6bVrCafcEEe6Y7zWFZPZUxiB
B1yDmtfy3PTJe6MnxsfFUdnD9ayNKd+gze4RwT4a72dwBWDQbra22lYJkz3xZGiy
47xhP2pq27+7S5RGIYtUptj3xK1XdgnKiT3j0vdYVtR4hkQUEsXaXT0nEBJzRYM=
=3gde
-----END PGP SIGNATURE-----

--iA7ooglt5DUTWkAkGGLI0Ub8USgomBG0M--
