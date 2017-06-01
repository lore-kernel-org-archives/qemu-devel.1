Received: from eggs.gnu.org ([2001:4830:134:3::10]:34718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGQsp-0007HJ-3g
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGQsl-0005hA-UR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dGQsl-0005go-LG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:15:23 -0400
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
	<20170601124143.10915-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c241b21-1e3f-bbed-73d0-154887ded0fd@redhat.com>
Date: Thu, 1 Jun 2017 09:15:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170601124143.10915-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m0CqsGk8pO2F7qJbnbGepq7Dn7Bwffht0"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: add location comment for
 generated types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m0CqsGk8pO2F7qJbnbGepq7Dn7Bwffht0
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <5c241b21-1e3f-bbed-73d0-154887ded0fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: add location comment for
 generated types
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
 <20170601124143.10915-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170601124143.10915-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 07:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> This may help to find where the origin of the type was declared in the
> json (when greping isn't easy enough).
>=20
> Generates the following kind of C comment before types:
>=20
>   /* /home/elmarco/src/qemu/qapi/introspect.json:94 */
>   typedef struct SchemaInfo SchemaInfo;

Makes the generated code larger, but for a good cause.  No real impact
to the binary size (well, debug information may be slightly larger based
on line numbers getting higher, but that's in the noise).

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi.py       | 12 +++++++++---
>  scripts/qapi-event.py |  2 +-
>  scripts/qapi-types.py | 18 +++++++++---------
>  3 files changed, 19 insertions(+), 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m0CqsGk8pO2F7qJbnbGepq7Dn7Bwffht0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMCFrAAoJEKeha0olJ0Nq+REH/jcvUOeaunPd/MCntgAnG9Uv
RNbyP+wqTn2yJna2jXAkKK+sW7wSkeZLS4OqtUUTnNJ424ILxEC6asBpRVzPc/ib
aey8XUHyG5baH/JlvRKIPdM0oQoxvuxB4hkXqtIPhhWYsJTLy8dU8JaP9L8W5/SS
kHN7xj1pOAG78De6GbANKY805KWXPv+VxSOkUmpcgJY5AgPL1HZy+KH4czsLw4Wz
aRsM4iSaFa3xOSAGUz1yA64wX6nQqmBiRjN/70Aye6Zetq6i8YuZGOABdmpF4ZJM
L5ovdARZGxTFuxibRpUh5OsHxd8CR76EaTc078cNPRktLSe6xNP3YMNRQrG24b0=
=fy+D
-----END PGP SIGNATURE-----

--m0CqsGk8pO2F7qJbnbGepq7Dn7Bwffht0--
