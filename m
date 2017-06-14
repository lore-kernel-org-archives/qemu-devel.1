Received: from eggs.gnu.org ([2001:4830:134:3::10]:59529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLAuQ-00065y-8r
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dLAuP-0000f4-Bg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:12:42 -0400
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
	<20170613140358.81651-14-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <78128e64-696f-c7c3-701e-af38298cdef1@redhat.com>
Date: Wed, 14 Jun 2017 18:12:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170613140358.81651-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QkLAX54L3PORDsVLV1MXtoJSPe5FOru2o"
Subject: Re: [Qemu-devel] [PATCH v21 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QkLAX54L3PORDsVLV1MXtoJSPe5FOru2o
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <78128e64-696f-c7c3-701e-af38298cdef1@redhat.com>
Subject: Re: [PATCH v21 13/30] block: new bdrv_reopen_bitmaps_rw interface
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
 <20170613140358.81651-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 16:03, Vladimir Sementsov-Ogievskiy wrote:
> Add format driver handler, which should mark loaded read-only
> bitmaps as 'IN_USE' in the image and unset read_only field in
> corresponding BdrvDirtyBitmap's.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block.c                   | 19 +++++++++++++++++++
>  include/block/block_int.h |  7 +++++++
>  2 files changed, 26 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--QkLAX54L3PORDsVLV1MXtoJSPe5FOru2o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQWBjEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQI0S
CAC56BTJ6UTEHswtFrKvfYf0dIAAdIMnc0dCqfjZPoJQypUL8vOniOLnh2W2GdgM
MZmpSXlbz2SV2w+W8bbgMIHs1Tf768q+0agyKZ8ogsRLV/d1v66TNKSJ3Dw+OgUS
4Ihuy/JliwCjcoHgdbKB/rkq2D5vPXCrxwtHOlZExa9Iylpd4ysND2nA0x7JROno
QO8Xi/mIWaze9GH4THwsJBXVkJnLBL0/KwQTcF7a1FPqZzQDzs3u0BEge+5t4O8Z
hCsePCdHNvd7xN9HJ5hq/XXXQxz0OHJGjb+AeAj5umz4oxNX16iAQ2T7qSNTAEue
em7rBQji6P0d/DaDzaw0QNds
=Of2+
-----END PGP SIGNATURE-----

--QkLAX54L3PORDsVLV1MXtoJSPe5FOru2o--
