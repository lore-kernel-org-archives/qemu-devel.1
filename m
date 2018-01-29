Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9SM-00063q-6A
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eg9SL-0003Bc-D6
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:42 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eg9SL-0003BE-53
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:26:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id r78so33715821wme.0
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 05:26:41 -0800 (PST)
Date: Mon, 29 Jan 2018 13:26:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129132638.GF20446@stefanha-x1.localdomain>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20180125175949.7780-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] test-coroutine: add simple CoMutex test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 06:59:45PM +0100, Paolo Bonzini wrote:
> In preparation for adding a similar test using QemuLockable, add a very
> simple testcase that has two interleaved calls to lock and unlock.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-coroutine.c | 50 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabyEOAAoJEJykq7OBq3PIXAMH/RsMG3DZ1rVlJdzkqYp4kF34
DR+yrUKh9lDHh4eZapMpYxhfrC1OiQXMbpMV+oyAwaGqg2DxG9GYJsJG9BP/Ri5t
j2q1p0ET6W0hwGmdkq0OrshyCm6CBp2zTUN+KAJg3K7mTl2DjUisM16DIx7XcFcq
4wu7PVL09nVTERBNaqNA3Rb8YzSqR51Y84yPWhaBGDafEIc/hI5qNV8qApGRVBkS
SbGRraMlYqZJfhqVoeJTY/BH9aMDRBfdczDTF4q5phKSAFSmKwLDgeLkjmtVCa5s
9+ykK18BvyNAL6dJVLAEgIjEB1AVe9g5JGI9Xa2nla1q943ZI2uroBxY+uSxanY=
=EEwd
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
