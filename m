Received: from eggs.gnu.org ([2001:4830:134:3::10]:46001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqpA-0007mJ-5y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnqp6-0004Yj-5r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnqp5-0004YC-T9
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 14:05:28 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-20-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e65f7e31-86dc-69b6-3e2e-9d1fa540c3a5@redhat.com>
Date: Tue, 14 Mar 2017 13:05:25 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-20-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BvpEcPgEgNRGO3oeWkEb2r9TCgKuRM576"
Subject: Re: [Qemu-devel] [PATCH for-2.9 19/47] qapi: Prefer single-quoted
 strings more consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BvpEcPgEgNRGO3oeWkEb2r9TCgKuRM576
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <e65f7e31-86dc-69b6-3e2e-9d1fa540c3a5@redhat.com>
Subject: Re: [PATCH for-2.9 19/47] qapi: Prefer single-quoted strings more
 consistently
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-20-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> PEP 8 advises:
>=20
>     In Python, single-quoted strings and double-quoted strings are the
>     same.  This PEP does not make a recommendation for this.  Pick a
>     rule and stick to it.  When a string contains single or double
>     quote characters, however, use the other one to avoid backslashes
>     in the string.  It improves readability.
>=20
> The QAPI generators succeed at picking a rule, but fail at sticking to
> it.  Convert a bunch of double-quoted strings to single-quoted ones.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi-event.py      |  2 +-
>  scripts/qapi-introspect.py |  4 +-
>  scripts/qapi-types.py      |  4 +-
>  scripts/qapi-visit.py      |  4 +-
>  scripts/qapi.py            | 96 +++++++++++++++++++++++---------------=
--------
>  scripts/qapi2texi.py       | 46 +++++++++++-----------
>  6 files changed, 78 insertions(+), 78 deletions(-)
>=20

Purely stylistic, so I wouldn't do it as a lone patch. But as part of a
larger series, I think you're fine.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--BvpEcPgEgNRGO3oeWkEb2r9TCgKuRM576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyDDlAAoJEKeha0olJ0Nqb1MH/RKzZxNh22hBiX5hcOxPC/7q
Uzqy/EiZP6rK/DgHbIprl9ng0T1p3gO11MfJ4v5jzdWYXm7NaSg1fmXJd6dgIeT4
7R/0Ov2ufSYJASd3cIJJ0bICO1IbLCjgeMeNEu71iESf6aebABE68krHx6byyAg0
eb8T4C70gAHQI+Z8SkOswMcaZ5j7sapCHB29Llm5opr4AvJDAfi3hQ1ERXUiSG6E
hCOubOqVPamLxsSHYnLHqZtwZ/J4VT81QONVjNP6kss/YYHjd40UdAsdQvahBWcu
DWY7QmHYbiiSkA5FEq/vBThWM8+iIqW0RQMn0HAxI4iYdp/Mz4eBvXPurnkUkv8=
=4oH2
-----END PGP SIGNATURE-----

--BvpEcPgEgNRGO3oeWkEb2r9TCgKuRM576--
