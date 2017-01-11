Received: from eggs.gnu.org ([2001:4830:134:3::10]:38553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRO8V-00061x-9z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRO8U-00054c-7l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:00:39 -0500
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
Date: Wed, 11 Jan 2017 13:00:27 -0600
MIME-Version: 1.0
In-Reply-To: <20161130011851.24696-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6Sv2s5vqKPBipUdGHgDRDwG7uOE3GkN6b"
Subject: Re: [Qemu-devel] [PATCH v3 03/25] block: Add BDS.backing_overridden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6Sv2s5vqKPBipUdGHgDRDwG7uOE3GkN6b
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Message-ID: <600b2a2e-d127-f8a0-e850-80e77594c375@redhat.com>
Subject: Re: [PATCH v3 03/25] block: Add BDS.backing_overridden
References: <20161130011851.24696-1-mreitz@redhat.com>
 <20161130011851.24696-4-mreitz@redhat.com>
In-Reply-To: <20161130011851.24696-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/2016 07:18 PM, Max Reitz wrote:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS. Therefore, we will need to consider this i=
n
> bdrv_refresh_filename().
>=20
> Adding a new field to the BDS is not nice, but it is very simple and
> exactly keeps track of whether the backing file has been overridden.
>=20
> This commit adds a FIXME which will be remedied by a follow-up commit.
> Until then, the respective piece of code will not result in any behavio=
r
> that is worse than what we currently have.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

> +++ b/include/block/block_int.h
> @@ -461,6 +461,7 @@ struct BlockDriverState {
>      char backing_file[PATH_MAX]; /* if non zero, the image is a diff o=
f
>                                      this file image */
>      char backing_format[16]; /* if non-zero and backing_file exists */=

> +    bool backing_overridden; /* backing file has been specified by the=
 user */

Should we group all of the bool in this struct so as to reduce its size
and improve cache locality?  But it's already clunky, so that may be
appropriate as a separate patch.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6Sv2s5vqKPBipUdGHgDRDwG7uOE3GkN6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdoDLAAoJEKeha0olJ0NqXtwH/1AQjXd7zbnotRZaMkEWc192
eksvUd4mAgdm3vAXCo5KCRj+fOuPHCYUpdGJWAI4qjxZeuD5vInKbYAoywVzZhGv
GpEH3+an978RRjeiSzMtGYlGpw++D7Ors/Ejk1bkxWSM8admPNiW/abix4Ox0xwM
GLqJpYSrdqdvlFl0Gr43H8XOHgAgdzSnAIU+NRGH3LxMjNLQilJ/xNwSYo3zkzBa
13xkYz7Ws7r9lpek4vJIy4eSv5HLN9u4fmBm4hxq+zaJGdYLMvEc6Sr4kwagRS87
7C7C9zPJ7sTniwRDk1r6BP6er1Y8t8JQz5S95RoQEjIvoYPErCtDK+N7wG/vFb4=
=M1xQ
-----END PGP SIGNATURE-----

--6Sv2s5vqKPBipUdGHgDRDwG7uOE3GkN6b--
