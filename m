Received: from eggs.gnu.org ([2001:4830:134:3::10]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinl4-0008P4-3Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinl3-0007cQ-8x
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:48:26 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-23-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61ac43dd-25fb-0a83-75d5-ade76641444f@redhat.com>
Date: Tue, 28 Feb 2017 13:48:15 -0600
MIME-Version: 1.0
In-Reply-To: <1488194450-28056-23-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="caVb8DPcRAe4r18BFJHcCr0gInflKqPOm"
Subject: Re: [Qemu-devel] [PATCH 22/24] qapi: New parse_qapi_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--caVb8DPcRAe4r18BFJHcCr0gInflKqPOm
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com
Message-ID: <61ac43dd-25fb-0a83-75d5-ade76641444f@redhat.com>
Subject: Re: [PATCH 22/24] qapi: New parse_qapi_name()
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-23-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-23-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:20 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/util.h    |  2 ++
>  qapi/qapi-util.c       | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++++
>  tests/test-qapi-util.c | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
>=20

> +/*
> + * Parse a valid QAPI name from @str.
> + * A valid name consists of letters, digits, hyphen and underscore.
> + * It may be prefixed by __RFQDN_ (downstream extension), where RFQDN
> + * may contain only letters, digits and hyphen.

With the doc fix you discussed with Kevin,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--caVb8DPcRAe4r18BFJHcCr0gInflKqPOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtdP/AAoJEKeha0olJ0NqQngIAJfQuIhphkSocfhPW+1BfrXK
E2LupDk8zxdDc4/FCGOEbw6dD5zoWcST4OIyRPdDZeQDn3ctbP4CTDy+2MlSBlLy
cQ4Nl21WlAKg6qPll0q0xDdfhtN/yYCthQlND4YOWAjtBvuZj0Y9cnC97eZnq+Ei
pDr/KDnGI4/dQ8TE57qyzF0S3jvXzY+pGfafHMCWYEgIf0W4Nsxm/+xsor8gyjJr
n4LCdb7dD2RH+EW+sjoJxclkq9Ij9x8nFXRw/OCTsF6XXWHn770DrYwI54YW+pi2
BG9tstSsSAG3Ph62Yfkx7I53w+o/787xJIbzvXDsnxXYS9PdwymXB+LyYlaLaRg=
=PCy+
-----END PGP SIGNATURE-----

--caVb8DPcRAe4r18BFJHcCr0gInflKqPOm--
