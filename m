Received: from eggs.gnu.org ([2001:4830:134:3::10]:55764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVP8R-0000zN-P3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVP8Q-0005Yz-Pe
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 17:25:27 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-18-eblake@redhat.com>
	<bc598e9b-1606-ead3-30a4-d654b39994ed@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c37a81d4-d679-4054-ccb4-fe3b35591533@redhat.com>
Date: Wed, 12 Jul 2017 16:25:14 -0500
MIME-Version: 1.0
In-Reply-To: <bc598e9b-1606-ead3-30a4-d654b39994ed@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vv2sgQ6JFAaxGpEM6JsGufAE7OL6IgGUm"
Subject: Re: [Qemu-devel] [PATCH v4 17/17] dirty-bitmap: Convert internal
 hbitmap size/granularity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vv2sgQ6JFAaxGpEM6JsGufAE7OL6IgGUm
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <c37a81d4-d679-4054-ccb4-fe3b35591533@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 17/17] dirty-bitmap: Convert internal
 hbitmap size/granularity
References: <20170703151051.31327-1-eblake@redhat.com>
 <20170703151051.31327-18-eblake@redhat.com>
 <bc598e9b-1606-ead3-30a4-d654b39994ed@redhat.com>
In-Reply-To: <bc598e9b-1606-ead3-30a4-d654b39994ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 04:00 PM, John Snow wrote:
>=20
>=20
> On 07/03/2017 11:10 AM, Eric Blake wrote:
>> Now that all callers are using byte-based interfaces, there's no
>> reason for our internal hbitmap to remain with sector-based
>> granularity.  It also simplifies our internal scaling, since we
>> already know that hbitmap widens requests out to granularity
>> boundaries.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -310,7 +305,6 @@ void bdrv_dirty_bitmap_truncate(BlockDriverState *=
bs)
>>      int64_t size =3D bdrv_getlength(bs);
>>
>>      assert(size >=3D 0);
>> -    size =3D DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
>=20
> whoops uh, were we setting bitmap->size to the *sector* size prior to
> this, even though we had already changed bitmap->size to be the byte si=
ze?

Oops. Looks like I have a bug in my rebasing of 5/17.  Good catch; I'll
have to post v5.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vv2sgQ6JFAaxGpEM6JsGufAE7OL6IgGUm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZpO6AAoJEKeha0olJ0Nq/qEIAJT8GitfsDzESor464SM6MF1
uBLPmNFAPU2Hy3WsADFegRwd0pRd73oC2WwGm1JXRzqUKNx/y4eq4W61gNvN8PcG
1Mr2rV5f6jZ5SMXCuHg4grAOzSZeFsPsicjKsiYZ/5mYg4esrNxtg2XQqM+iOwam
SsM3iXG/yx7jlLaCRg1sKm13TvqETOePChxwN1oDtKWHjE1L66r75EOxlhtqR7GP
yAjYnyDdtPyE8XpQ8pVeOWtKFcriR58qYXpN7oNtDJy+6VfkaBeHX/W10v+CjONt
J1WaRTU+2+m/uHGd+uKTcz7AFxpJ55b8c5ZAFVEprjDPrpHGWPfkPNdE8CarVV8=
=qB4k
-----END PGP SIGNATURE-----

--vv2sgQ6JFAaxGpEM6JsGufAE7OL6IgGUm--
