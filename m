Received: from eggs.gnu.org ([2001:4830:134:3::10]:43192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFO8a-0007kh-TU
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFO8a-0002p2-1r
	for qemu-devel@nongnu.org; Mon, 29 May 2017 13:07:24 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-16-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc462db3-9ad7-62f4-8d71-367e79583a4b@redhat.com>
Date: Mon, 29 May 2017 19:07:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-16-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b7OMH5L01upKoTEixbffTCW7WiEVHpauT"
Subject: Re: [Qemu-devel] [PATCH 15/25] qcow2: add persistent dirty bitmaps
 support
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
--b7OMH5L01upKoTEixbffTCW7WiEVHpauT
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <dc462db3-9ad7-62f4-8d71-367e79583a4b@redhat.com>
Subject: Re: [PATCH 15/25] qcow2: add persistent dirty bitmaps support
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-16-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-16-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> Store persistent dirty bitmaps in qcow2 image.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 475 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   9 +
>  block/qcow2.h        |   1 +
>  3 files changed, 485 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--b7OMH5L01upKoTEixbffTCW7WiEVHpauT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLFU9EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPL9
B/wI3vCI+5vxmrzDFlsemhDS4CDHt5VCUEGsnC3N2QAV6oZ1Mh1nRnHMRvK5JpTy
GuDHpqS9hz2dm7jZjTiZ3IBxWLGNYFNiTTUcph/Dik9XK0+ydunGacK1yNkg4Gcn
olY5u09XyZbX2hUKO3Yg/HItoA28tv/CkN2GOWk7wc76PmNcMB3Gyf+USErCmdWx
mD4nWx48JfWkFGSgC8dmsu1Jd3ldMUnf3tAX/H4uDfjw11hJ68GRBiNKDTKQLp3V
16P8IjpuAnBVY3kRMfoO2HiFAusuCdHSvVSS8YUJOv45o5/n167iLSPWZg5uXgpu
IYARpPaiQnNCIeF/I++YfHmh
=CH3G
-----END PGP SIGNATURE-----

--b7OMH5L01upKoTEixbffTCW7WiEVHpauT--
