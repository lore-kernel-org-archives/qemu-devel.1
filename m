Received: from eggs.gnu.org ([2001:4830:134:3::10]:46782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGII-0007yE-Lt
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGIH-000171-QI
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:54:14 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:40499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eNGIH-00016h-Jb
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:54:13 -0500
Received: by mail-wr0-x233.google.com with SMTP id q9so10410364wre.7
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 02:54:13 -0800 (PST)
Date: Fri, 8 Dec 2017 10:54:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208105409.GH23880@stefanha-x1.localdomain>
References: <20171205133954.31006-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <20171205133954.31006-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: drop unused #include
 "sysemu/iothread.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:39:54PM +0000, Stefan Hajnoczi wrote:
> Commit 1351d1ec89eabebc9fdff20451a62c413d7accc1 ("qdev: drop iothread
> property type") forgot to remove this include.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/core/qdev-properties-system.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKm9RAAoJEJykq7OBq3PIZboH/1g76+j/JrF6VeRt3QoIvXFh
+udtHLPFTWoJqrNX3Cfau0mbaBvI46uO2UeP2MEInWC26wjRuamtzxNB/M3QyGmU
5mnDg6dMhPwKL15ucqfakvBmg/VIDigJMqVqoYb7MTmbJZM+XINo15JkOh2x/XTD
AykacdCwsTrHm9fOtcTVv2YIm7CqmeaBPpf/VucFsnHQE1y2Q6/g6IGfrD48nY26
pDgwjcGejCwqwANUB9/jSiyuQrzS8MrGg+7IxOe3WRxCtFyeOrwnYyajLO6GU72G
fNEcVfUWCVSHsVw27mNWtHSaRwrEn5qrRL0plDuCXgoYoeAvlQXBfJKQA0ePnp8=
=oDZW
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
