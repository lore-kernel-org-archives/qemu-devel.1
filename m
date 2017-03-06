Received: from eggs.gnu.org ([2001:4830:134:3::10]:46073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzLc-00029s-Pr
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckzLc-0006tH-3F
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:35:12 -0500
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-7-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f0225c6-cf7f-e4dd-a91a-340303dafec7@redhat.com>
Date: Mon, 6 Mar 2017 14:35:02 -0600
MIME-Version: 1.0
In-Reply-To: <1488817322-11397-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gAWS94LWmpEiHvFXUS9D0gG6JaDjwKH71"
Subject: Re: [Qemu-devel] [PATCH 06/10] block: Factor out
 should_update_child()
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
--gAWS94LWmpEiHvFXUS9D0gG6JaDjwKH71
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <0f0225c6-cf7f-e4dd-a91a-340303dafec7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] block: Factor out
 should_update_child()
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
 <1488817322-11397-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gAWS94LWmpEiHvFXUS9D0gG6JaDjwKH71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvcf2AAoJEKeha0olJ0NqvTsIAKK7hyF0hO2W6OK/r/0zURr2
2nvvGprqh+R238ekaeEYM2ugnd4kAQ2phssyTnMiBVubhgTlYlGEwl5sy/4Wdfhr
f9ENXhljai2GJ7GyjLQkKijRV/bHfkXeEyI/k4J8EQKHGLUkcw+4n5Zu8H5D37vy
bTfR3U9QaBSw1ZJo5LsBXcEhOFe+mhXK91T6ERez1S16Uh+N4VE9MvOb9ulBZeF2
wF8zgAOwRKzx3LNNotE8uVh81GX8q6iuBMPbCYlvENah2qOYS4H8ZFEjmKjOw5qZ
UrHxEJFYgaCePuLgIVX9dG/AtWQWcCEA8Kt8jPJV5j031FwbgBxpCdDk5YPZJqA=
=4A2D
-----END PGP SIGNATURE-----

--gAWS94LWmpEiHvFXUS9D0gG6JaDjwKH71--
