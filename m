Received: from eggs.gnu.org ([2001:4830:134:3::10]:60518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOpUT-00062B-8L
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cOpUP-0000wE-VK
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:36:45 -0500
References: <20170104145914.3361-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8467bc31-f5ac-3d8e-483c-a6d8199d45bc@redhat.com>
Date: Wed, 4 Jan 2017 11:36:39 -0600
MIME-Version: 1.0
In-Reply-To: <20170104145914.3361-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aodIuNGsHTlgqILQDaWJHUkpIlF0n8CJg"
Subject: Re: [Qemu-devel] [PATCH] block: remove dead check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aodIuNGsHTlgqILQDaWJHUkpIlF0n8CJg
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <8467bc31-f5ac-3d8e-483c-a6d8199d45bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: remove dead check
References: <20170104145914.3361-1-pbonzini@redhat.com>
In-Reply-To: <20170104145914.3361-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/04/2017 08:59 AM, Paolo Bonzini wrote:
> options must be non-NULL here, because a NULL value is replaced with
> qdict_new earlier in the function.  Reported by Coverity.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block.c b/block.c
> index 39ddea3..a0346c8 100644
> --- a/block.c
> +++ b/block.c
> @@ -1851,7 +1851,7 @@ static BlockDriverState *bdrv_open_inherit(const =
char *filename,
>      bdrv_refresh_filename(bs);
> =20
>      /* Check if any unknown options were used */
> -    if (options && (qdict_size(options) !=3D 0)) {
> +    if (qdict_size(options) !=3D 0) {
>          const QDictEntry *entry =3D qdict_first(options);
>          if (flags & BDRV_O_PROTOCOL) {
>              error_setg(errp, "Block protocol '%s' doesn't support the =
option "
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aodIuNGsHTlgqILQDaWJHUkpIlF0n8CJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYbTKnAAoJEKeha0olJ0Nqd5EH/0eANKjWBHJZSi+0wbVisl3D
mevt/7fdh+gHYh49Dzff2MpoS5nkD4EJ5Oa5VpPk5TxNfqGZ20mWY7NdJYuHAvE9
X66rZ7b4YBBfwjWediBRE8Kg8pi3p2uxKlPpesrTcYS5GzvAWs6O8IN1bkk/hYz0
faw36r5j57X8uZYtsw22x6MT0Ql7YGPG8EY0EYzt/ka+g8JrtLAJnMW7G7WF2H6v
St7cX6P4ob3Yx7TRBH4S0odlDoxNojRpqTaQvwSqLOTva3RJAE8xpfmp4r3Mj1RM
ZMzurmKRsqy/qb0xUVsQtvjohsc+hYIK//mwqMh20wcjAuE3NfKn7l1BHOY7SaU=
=RFNV
-----END PGP SIGNATURE-----

--aodIuNGsHTlgqILQDaWJHUkpIlF0n8CJg--
