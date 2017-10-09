Received: from eggs.gnu.org ([2001:4830:134:3::10]:58729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cFO-0000lQ-QS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cFN-0000Oi-Vp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:53:46 -0400
References: <20171009163456.485-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71e3da9a-62e5-9723-c834-426cacdcfc92@redhat.com>
Date: Mon, 9 Oct 2017 12:53:36 -0500
MIME-Version: 1.0
In-Reply-To: <20171009163456.485-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hMj2XIX0aO7n5F9T6hboRTdr6hrVQORu5"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Add _filter_actual_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMj2XIX0aO7n5F9T6hboRTdr6hrVQORu5
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <71e3da9a-62e5-9723-c834-426cacdcfc92@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Add _filter_actual_image_size
References: <20171009163456.485-1-mreitz@redhat.com>
In-Reply-To: <20171009163456.485-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 11:34 AM, Max Reitz wrote:
> The actual size of an image depends on the host filesystem.  Therefore,=

> it should be filtered from the test output if it's not part of the test=

> itself (and if it is, the test should take extra care, like 106 does).
>=20
> So let's put the filtering sed line from 067 and 087 into a common
> filter function and use it in 184 and 191.
>=20
>=20
> Max Reitz (2):
>   iotests: Pull _filter_actual_image_size from 67/87
>   iotests: Filter actual image size in 184 and 191

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hMj2XIX0aO7n5F9T6hboRTdr6hrVQORu5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbt6AACgkQp6FrSiUn
Q2qhfAgAqIygBIM9gPB16OrPEUk9mBQ+L0tWeuWlrAWU6GWs+fZp6ZGObAHBIPBd
KHeO9L4W7RLuU15uM9kYmRZBQO2/zn4VnniUUPfZZJimm410azRfCn31Sxct20Mb
1IOCrQczzPE8EYVXDE6oXC+Q+ijyCLi/DWHzyiMNY4QKPkW/qL98xkCaFORPtSV3
ZjaYD4RXIbC0+FMdaxIW4kXveBoehF/l/9+/V837UeYyjWVjCNiFP81JXfVDK+Cl
EnyVHqHCKuU7bGI8LhqNOOEReFc9o95U8iBiC5Iu9QQvYmlYSXqcLk8MiastMDmp
C9em6O4/ytTD4s/OHKOLbmSzcQJWRw==
=si97
-----END PGP SIGNATURE-----

--hMj2XIX0aO7n5F9T6hboRTdr6hrVQORu5--
