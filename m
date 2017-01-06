Received: from eggs.gnu.org ([2001:4830:134:3::10]:38001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUOT-0000MO-13
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPUOS-00048R-4s
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPUOR-00048K-SD
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:17:16 -0500
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
	<1483692945-9866-9-git-send-email-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8a3c973-4e5b-05f4-ac3f-e117d353e374@redhat.com>
Date: Fri, 6 Jan 2017 07:17:10 -0600
MIME-Version: 1.0
In-Reply-To: <1483692945-9866-9-git-send-email-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LBPmM4Bee4TsmXeAVfIDMbtFislmpn47b"
Subject: Re: [Qemu-devel] [PATCH 08/17] wctablet: drop debug code from
 wctablet_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LBPmM4Bee4TsmXeAVfIDMbtFislmpn47b
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com
Message-ID: <c8a3c973-4e5b-05f4-ac3f-e117d353e374@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] wctablet: drop debug code from
 wctablet_handler
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
 <1483692945-9866-9-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-9-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:55 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  backends/wctablet.c | 6 ------
>  1 file changed, 6 deletions(-)

Why not just squash this into 1/17?

>=20
> diff --git a/backends/wctablet.c b/backends/wctablet.c
> index 84fb485..d0ee0e4 100644
> --- a/backends/wctablet.c
> +++ b/backends/wctablet.c
> @@ -204,12 +204,6 @@ static void wctablet_handler(void *opaque)
>      }
> =20
>      if (len) {
> -        // DPRINTF("-------- Write %2d: ", canWrite);
> -        // for (i =3D 0; i < len; i++) {
> -        //     DPRINTF(" %02x", tablet->outbuf[i]);
> -        // }
> -        // DPRINTF("\n");
> -
>          qemu_chr_be_write(chr, tablet->outbuf, len);
>          tablet->outlen -=3D len;
>          if (tablet->outlen) {
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--LBPmM4Bee4TsmXeAVfIDMbtFislmpn47b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb5jWAAoJEKeha0olJ0NqnYgH/jHdHBc6RZUydrObgI2/QWR4
wd8JIYDpwdp0LnQcdT6OwPJ1XZ0lICWmeal2DsFopzD6kR6rOhrSX1rwjgfj2zwC
t82gVtQiIGjbO/A6Z1nY20tAAPS6fRJm5+bxqMDy8zz6LDV0nXQiIeVtpCF94e/+
6CF0NXG+NXoncgqjgHUyLbQVtpqIkPHmpanQFdMtaFPe+N4X3eRR8epu2lCNnQk+
vC0DH6KxGjSu4ZMKPh2rm5JYZh15y9uo1qP0IsWsloB3O4RHV2oR2hjC+Tulhmef
ObPL6eBe9MHnlidM0k2R8twKNVBGjUNpLncsKpbXLXxRRqAK+NGi0VijUZAS0J0=
=jKkE
-----END PGP SIGNATURE-----

--LBPmM4Bee4TsmXeAVfIDMbtFislmpn47b--
