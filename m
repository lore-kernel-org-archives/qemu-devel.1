Received: from eggs.gnu.org ([2001:4830:134:3::10]:38975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5W47-000434-3T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d5W44-0001Yw-06
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:59 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d5W43-0001Xy-Or
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:55 -0400
Received: by mail-wm0-x236.google.com with SMTP id u65so109193691wmu.1
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 04:33:55 -0700 (PDT)
Date: Tue, 2 May 2017 12:33:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170502113350.GA22502@stefanha-x1.localdomain>
References: <1337526951.2414198.1492421247871.ref@mail.yahoo.com>
	<1337526951.2414198.1492421247871@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <1337526951.2414198.1492421247871@mail.yahoo.com>
Subject: Re: [Qemu-devel] need help about trace reconstruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: oussema ben khedher <oussemakeder@yahoo.fr>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2017 at 09:27:27AM +0000, oussema ben khedher via Qemu-deve=
l wrote:
> =A0i m comparing the trace of execution of reconstruction of trace instru=
ction of a code running in real board and the trace of=A0=A0the same code r=
unning in qemu ..
> and i found that there is some function not called in the reconstruction =
of qemu trace ..
> i guess that qemu do some optimization or there is another raison for that

It's very hard to answer without details on how you traced execution and
seeing the actual trace data.

QEMU is a functional simulator.  The effects of running the guest code
should be identical although the timing may not be.  The guest code may
also be affected by environment or hardware differences, causing it to
take different code paths.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCG6dAAoJEJykq7OBq3PIAvgH/juOmcdcgoYI0rDcQb+CXs8k
puFENsU+hSm9c/LER/lWBWt9JsahjdlMnkB69axeblft3y54GwNlYHOiXXH2pe8k
sMGSn3j4GU+HnS3iebQI5TI/d7Ibk0yUfYZyv0UY2IjBLCYPptahT2X4iBl68QPs
xUdw+e/457CkoceEPUjVycxCer7RXvISL7iDjoq3hG6ttFcC0o9QbONZHhoBe6vp
uc6fMvp6zlOCHLFmcPkByCI+1n59HZbWHaLrxojIYYjhaWsNe6n15qdLsIJKaIwA
6xuAzXYSVhZbhoSWt9h4kHM+ENRuE8KQtrw5t3PmCL2RBnxVjbwVTL5HNdsbqKw=
=Vovk
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
