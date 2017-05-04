Received: from eggs.gnu.org ([2001:4830:134:3::10]:33249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EOX-0003t5-KL
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EOU-00019r-AI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:54:01 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6EOU-00019c-3u
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:53:58 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so2462502wmb.1
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 03:53:57 -0700 (PDT)
Date: Thu, 4 May 2017 11:53:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504105355.GC32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-9-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] blockjob: group BlockJob transaction
 functions together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:16PM +0200, Paolo Bonzini wrote:
> Yet another pure code movement patch, preparing for the next change.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: split out of block_job_completed_txn_abort patch [John]
>=20
>  blockjob.c | 128 ++++++++++++++++++++++++++++++-------------------------=
------
>  1 file changed, 64 insertions(+), 64 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwhDAAoJEJykq7OBq3PILgIH/2AXbbECJEg4XRJy77ZyF/OI
FhnrCVy+ShoS4qaFsqty8ySRalBWrxbDUBs+vz9JJFShJtcErPa8Y/QenS1vUNYR
SqFlWhQuHGdY/zqiW/RkStnZdBzgfz4ODwe/RkZFn//LZbRysafJwX9cE4dzf9xw
QuE8MXZJaOLlgvFcL/cZtrSrf+KiA/FOgCdyE2l0ihdPfJmz7nB0HWaQ+8Aa/kVY
Q5v2wB+s8sUwkmi7/8MJX/C6vsIOp1iJp0kUaUg2EgRv/4z23z8Gv8ZOnNT58OZg
4h0XkBqmhDvwbwY46h77JsB0xRt+hh2qvsEHZWK7KDTmiwNjmMCsxYQSNATELiM=
=1aLD
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
