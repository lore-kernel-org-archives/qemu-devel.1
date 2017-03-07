Received: from eggs.gnu.org ([2001:4830:134:3::10]:33365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clGpv-0001Gq-VC
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1clGps-0001UV-QB
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:15:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1clGps-0001UK-KT
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:15:36 -0500
References: <20170306223054.25666-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d061a9c-05b4-b5dc-1353-4796310b5ecc@redhat.com>
Date: Tue, 7 Mar 2017 09:15:34 -0600
MIME-Version: 1.0
In-Reply-To: <20170306223054.25666-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sDX3VtOCVg0FKUm37NjffmnsxHaLA6HJi"
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sDX3VtOCVg0FKUm37NjffmnsxHaLA6HJi
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2d061a9c-05b4-b5dc-1353-4796310b5ecc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] nbd/client: fix drop_sync
 [CVE-2017-2630]
References: <20170306223054.25666-1-eblake@redhat.com>
In-Reply-To: <20170306223054.25666-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 04:30 PM, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Comparison symbol is misused. It may lead to memory corruption.
> Introduced in commit 7d3123e.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
> [eblake: add CVE details]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <address@hidden>

Blergh. This R-b isn't correct.

Sending v2 with fixed attributions, and with >=3D instead of >.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sDX3VtOCVg0FKUm37NjffmnsxHaLA6HJi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvs6WAAoJEKeha0olJ0NqDboIAK/u/eJrWSwBHX6RCQocs35E
hEzBxo5UXNxP1qunBE32nL7SV9CLR6elN9D6q2HV1dRQUv0TXRmMiVIN2k2tWhDS
vlKQoksA97Ag8aRP7QKJoGy/XGLXodBl0XS/W/Ci5B0xRNEYy44LwnakqwGhBU/X
OxCWP62DM2FD0PB+N/+mQ3Lh9W7ubaTlvkIGT8sa07Ffuh2uYhE5uWv9FNP2pzjE
4zy9l5w5r9CPc0Zo5oH4ZcqYiwbHYM1V8FADiXT4Si4KURXXSm0XZphLqmzoD1Xm
gz7t6nlus3FhFhTnU2uiBbO7I09l3v/q67kGwyParHfJz2+ocmoiKTS8ccfVmmg=
=Ktdz
-----END PGP SIGNATURE-----

--sDX3VtOCVg0FKUm37NjffmnsxHaLA6HJi--
