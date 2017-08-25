Received: from eggs.gnu.org ([2001:4830:134:3::10]:35414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMbI-0000kY-KA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMbH-0008Fv-Tc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:57:12 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-11-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d60ef843-f916-c540-222a-4428f2dd4033@redhat.com>
Date: Fri, 25 Aug 2017 16:57:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170804151440.320927-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gvlQks51T4C3BJe2Wttu9l9uCVONfSelj"
Subject: Re: [Qemu-devel] [PATCH 10/17] block/nbd-client: move
 nbd_coroutine_end content into nbd_co_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gvlQks51T4C3BJe2Wttu9l9uCVONfSelj
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <d60ef843-f916-c540-222a-4428f2dd4033@redhat.com>
Subject: Re: [PATCH 10/17] block/nbd-client: move nbd_coroutine_end content
 into nbd_co_request
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Move code from nbd_coroutine_end into nbd_co_request. The function
> nbd_coroutine_end is not needed separately, also it is better to
> have in_flight-- in nbd_co_request as in_flight++ lives in nbd_co_reque=
st
> too.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gvlQks51T4C3BJe2Wttu9l9uCVONfSelj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgnS4ACgkQp6FrSiUn
Q2qV0gf/dvxDxzC4jt2D/G9/IjgJHlWbYlATDxQpdtmHh6VYI39QmKNUFdO/3aoV
5i5kFzf4NpRiFt4UH08ZpHKcH2fM8C2PYs00uVwdvKowLKucrU3bv9MBOJWflC90
kSK2pyZF5+39yGaVeI3uMjoAPwxCvKJkJJUTITwWSVaz88zP0M0Pc6q7Ljlhdxoy
LtZ+KetgW++jyPSGun8EPSGs/u/vpGFko+J60M11wWIl/ze1C1PsTBgV6LL7JUbv
+R93AL84VYhV7QGKEY2Vgk6mEuz3tEtmXR8px/cVolA6HHH+Yr70Y92ahEjTJui8
iOgZ6exazl2qF3RuM2V5Bki1/gQ0gw==
=WDTK
-----END PGP SIGNATURE-----

--gvlQks51T4C3BJe2Wttu9l9uCVONfSelj--
