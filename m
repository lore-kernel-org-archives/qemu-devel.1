Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMvw-0005xq-VN
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFMvw-0002X0-B7
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:50:17 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fd3bc62d-b738-6944-a9b5-cf0b4f1b231d@redhat.com>
Date: Mon, 29 May 2017 17:49:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bShftRWePau3oMRgHq2WmDhAjLmXMGJEM"
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
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
--bShftRWePau3oMRgHq2WmDhAjLmXMGJEM
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <fd3bc62d-b738-6944-a9b5-cf0b4f1b231d@redhat.com>
Subject: Re: [PATCH 09/25] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> It will be needed in following commits for persistent bitmaps.
> If bitmap is loaded from read-only storage (and we can't mark it
> "in use" in this storage) corresponding BdrvDirtyBitmap should be
> read-only.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 16 ++++++++++++++++
>  include/block/dirty-bitmap.h |  3 +++
>  2 files changed, 19 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--bShftRWePau3oMRgHq2WmDhAjLmXMGJEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLEMkEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQLO5
CAC0HrO1yq0DxnrmOgbodctvL3I4cmESanimgWlYpUh9Q0rqFBRz8x0lOn8u6JhZ
iHOSCQTUnDaW1ZqCIt3QhSeiNZTB69dAHlWNmpjaMxEEMc8qSdxDgJke0TnV7nqX
+9sOwmvUJQviOpviIuU9XKiEgh2GaWCwjDVgBFxq7OVSj9msBRuEO9S6aBTa5XFv
AmYbWHMvHpt4HdAwxZ0vUOhER6wfrTLA1uA2bAZDY4Giug9eIXZAJfakKWdsnyn1
gWi7hiwHbHy9YZtnv2lQrGEIAjtV4qGgiqRnaHPPUXp3R9DEryPxN8WlBVtCQ/ig
o66qh8Yhw/uVwGMVvF2kl4b/
=qId3
-----END PGP SIGNATURE-----

--bShftRWePau3oMRgHq2WmDhAjLmXMGJEM--
