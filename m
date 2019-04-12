Received: from eggs.gnu.org ([209.51.188.92]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEqWs-0006fT-MD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEqWr-0007cw-PQ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hEqWr-0007bO-8p
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id f36so4681774plb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 00:23:16 -0700 (PDT)
References: <20190409065404.9853-1-richard.henderson@linaro.org>
	<b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed3b8226-db25-dcf9-dac2-80a03b90c087@linaro.org>
Date: Thu, 11 Apr 2019 21:23:02 -1000
MIME-Version: 1.0
In-Reply-To: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI"
Subject: Re: [Qemu-devel] [RISU v2] i386: Add avx512 state to reginfo_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI
From: Richard Henderson <richard.henderson@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
Message-ID: <ed3b8226-db25-dcf9-dac2-80a03b90c087@linaro.org>
Subject: Re: [RISU v2] i386: Add avx512 state to reginfo_t
References: <20190409065404.9853-1-richard.henderson@linaro.org>
 <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
In-Reply-To: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/11/19 4:05 PM, Jan Bobek wrote:
> Looks fine to me. I suppose if I had written it, I would have included
> more comments and/or #define's to make some bits more obvious (all the
> magic constants look a bit scary until you read the Intel manual), but
> nevermind that.

You're right that it absolutely cries for comments and constants.  I usua=
lly
don't know how to write those until I know what I am doing.  In this case=
 I
really hadn't figured out what I wanted to do -- perhaps obvious for send=
ing
two different patches inside a couple of hours.


> I guess the other remaining part now is extending risugen to actually
> generate the test blobs.

Yes.  I gave that a read and think that you should need only simple exten=
sions
to the current infrastructure.


r~


--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFEBAEBCgAuFiEEnLGN2vjoSa0q/BakrRJwzE3QJ5sFAlywPN4QHHJ0aEB0d2lk
ZGxlLm5ldAAKCRCtEnDMTdAnm+2DB/0XDN0RUewIx3N4og/D0m3qZLD5+zQ+CKLR
Fl/WEI0quFl6PRUoZu8VTAMrIxRiue3djWb7JBmTgV1FPMy3V7zQkvRf0t3eKG+x
DIajcWV8Pj8lCtD7DVD4ilS5YWsitPMLzB+OOfBoJhzlzKv9e4ePu5/f5PNhN5ZY
BHE5yXWYkPV4VxCP5BkAP4TNxXPblbtzAUMJrrFSeKEy9cCi0xinNqAMaU6rzL7U
1LkZ89j8khNqHjEZVsrPf3avJBoz+zM9ScnBhdbX02gHSUmenX9SuZXQBun7T2jl
x8w2TgcVaLfrvma2xVQ13jeSpwvtZrrr83nyYMvFxv54ejU+notr
=ILxT
-----END PGP SIGNATURE-----

--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI--
