Received: from eggs.gnu.org ([209.51.188.92]:56209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2FI-000854-Ko
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gt2FG-0006cG-Ow
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:27:00 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:45545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gt2FF-0006PP-GO
	for qemu-devel@nongnu.org; Sun, 10 Feb 2019 22:26:58 -0500
Received: by mail-pf1-x434.google.com with SMTP id j3so4587360pfi.12
	for <qemu-devel@nongnu.org>; Sun, 10 Feb 2019 19:26:43 -0800 (PST)
Date: Mon, 11 Feb 2019 11:26:38 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190211032638.GC18083@stefanha-x1.localdomain>
References: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
Subject: Re: [Qemu-devel] should we try to stop using variable length arrays?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 07:30:59PM +0000, Peter Maydell wrote:
> Should we be looking to get rid of these and turn on the -Wvla
> warning? I know the Linux kernel has recently decided to do this
> (some rationale at the start of https://lwn.net/Articles/749064/).

I'm in favor of avoiding variable-length arrays just so reviewers don't
need to catch instances where the size comes from the untrusted guest.

Stefan

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcYOtuAAoJEJykq7OBq3PIS+4IAIwpZskPpBCEIA7rxV2wmpYT
P8Gm4wIU618MF/grSbO8q8jUnh3YIBlgEjFSRXU/vPJHLY63aVKFj1hLZs4sYyPr
XsepnlP0NK29V+FdIYtrS5fwo5Ft7J0ydB4z7GhPqNpeoekM4Gz3dxb871G3XJYh
22yhggtalvA8fL1gNJGFJkMCRQK0zJaxAGUyIorWlyspj2+fh0F+/CxIIN+ROAyf
+Le+1FSkZ0l/iG/cJaaBjxX+wPridzHilX7xxuc2KnEIiMkgm5mVh/cf+09x6dIm
RA67QYK4HTGyyHTVQgPY51xJXkyHDxqAXTWqx7kRY5vNh/TZTx9yARTcw2fkupY=
=F/Rh
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
