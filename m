Received: from eggs.gnu.org ([2001:4830:134:3::10]:46431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzMz-0002hk-Sc
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:36:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzMy-0007Wr-Tk
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:36:37 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-8-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22e7e6b2-6f06-d7b3-4667-2c3703440515@redhat.com>
Date: Mon, 6 Mar 2017 14:36:30 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LfMxCtJHjUBR6uBwWPKPdMEgSF9h9CGRG"
Subject: Re: [Qemu-devel] [PATCH 07/10] block: Factor out
 bdrv_replace_child_noperm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LfMxCtJHjUBR6uBwWPKPdMEgSF9h9CGRG
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <22e7e6b2-6f06-d7b3-4667-2c3703440515@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] block: Factor out
 bdrv_replace_child_noperm()
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LfMxCtJHjUBR6uBwWPKPdMEgSF9h9CGRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvchOAAoJEKeha0olJ0NqIa8IAI0pTJHWHO8c8FB7KPzzZoZo
XdgCygFob10xdX5CcMG+4qHQO0M0ADjYacBZTRPP/iwaudRxjd3EU34g6ocWFHhj
bZOa3/Ir0jjntDaIDKk2ILp5lYjJc+N+LAksGKnuQ2RUr+KrNKDoR11xr+everjN
iKFYHiCbP+sLA5NTyxnVO/qxt1tcikdu9Gm5bpa1arNgMOgliT6VonYEcrs+1zNP
VK1TwnV3WB96Y7Ugncao1itBLAJZSxPV0p8peWb65/Zg7+Y/23l1bjYeHlmGv6YS
0+M2nPlGdVBnr8AdP+GecOS3FFBWL/ZBedKgYyzqfzsWW3j2AlI233CrltsVBv0=
=8Ive
-----END PGP SIGNATURE-----

--LfMxCtJHjUBR6uBwWPKPdMEgSF9h9CGRG--
