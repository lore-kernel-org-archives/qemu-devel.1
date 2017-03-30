Received: from eggs.gnu.org ([2001:4830:134:3::10]:49756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctc3v-0008Jv-Kp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctc3u-0005SE-LM
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:32:35 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1855940b-6459-965a-988e-9662e79dc4b4@redhat.com>
Date: Thu, 30 Mar 2017 10:32:20 -0500
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MKdfkmSf8sRQwN46aFS3AQWkjaDodai1W"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 10/10] sheepdog: Fix blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MKdfkmSf8sRQwN46aFS3AQWkjaDodai1W
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <1855940b-6459-965a-988e-9662e79dc4b4@redhat.com>
Subject: Re: [RFC v2 for-2.9 10/10] sheepdog: Fix blockdev-add
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:15 AM, Markus Armbruster wrote:
> Commit 831acdc "sheepdog: Implement bdrv_parse_filename()" and commit
> d282f34 "sheepdog: Support blockdev-add" have different ideas on how
> the QemuOpts parameters for the server address are named.  Fix that.
> While there, rename BlockdevOptionsSheepdog member addr to server, for
> consistency with BlockdevOptionsSsh, BlockdevOptionsGluster,
> BlockdevOptionsNbd.
>=20
> Commit 831acdc's example becomes
>=20
>     --drive driver=3Dsheepdog,server.type=3Dinet,server.host=3Dfido,ser=
ver.port=3D7000,vdi=3Ddolly
>=20
> instead of
>=20
>     --drive driver=3Dsheepdog,host=3Dfido,vdi=3Ddolly
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/sheepdog.c     | 84 ++++++++++++++++++++++++++++++++++----------=
--------
>  qapi/block-core.json |  4 +--
>  2 files changed, 58 insertions(+), 30 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MKdfkmSf8sRQwN46aFS3AQWkjaDodai1W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEbBAEBCAAGBQJY3SUEAAoJEKeha0olJ0NqO84H+Of6knD+gmoEHiFxC5tZJjcx
tE+5BwvzRdWBeU+NG0uqA6jbLdQ1EyDgYtfGPY+L9NL/7eaVbfaTuVbBWmKhgjUh
l38r6t55bnpqRzncFHK6SKtLcJEv0nhQL60quHgZBOphhCyiYBpoOIr5ZB/PJVfp
P2m88ZJjqogrA5BHQM6GHFunNGSIW4KXVv4o4wGA4AnbJ0XzE20JotSAFk5dT2DR
KkZef1u4/ZFlTE1nN3nztvsrpbKRjnw4/COmI1j8beWcBdVkulAwBKZoHpb3GSRV
g4eRDS7+rPFvTKXhQhDCun8fZ7guO4yRo2u5Tqtnkqbm04NYOr8JvAY4D+Nq3g==
=5UmT
-----END PGP SIGNATURE-----

--MKdfkmSf8sRQwN46aFS3AQWkjaDodai1W--
