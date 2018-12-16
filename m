Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gYPpQ-0000jy-GA
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gYPpN-0003Rh-6f
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:23:04 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gYPpM-0003QG-Pq
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 01:23:01 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so8695955wrt.4
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 22:22:59 -0800 (PST)
Date: Sun, 16 Dec 2018 06:22:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181216062256.GB6123@stefanha-x1.localdomain>
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20181112214224.31560-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v5 00/14] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 04:42:10PM -0500, Steffen G=F6rtz wrote:
> This series contains additional peripheral devices for the nRF51822
> microcontroller.=20
>=20
> Included devices:
> - Random Number Generator
> - Non-volatile Memories
> - General purpose I/O
> - Timer=20
> - Stub for clock peripheral

Hi Steffen,
I have pushed fixup commits addressing the easy comments:
https://github.com/stefanha/qemu/commits/pouze-microbit

The remaining issues are the periodic timer and how to model flash
memory (address_space_write()).

Feel free to squash my fixup commits if they are useful to you.

Stefan

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcFe9AAAoJEJykq7OBq3PIwqsH/3qHOktAxQ1Ab13T10xt2S6u
F/LFoy8cEj86uJdd8VyxM9EqF1Xr02ZqLESXR5vzvpJEiwsC5cwG11KkdJXxq8qJ
myMNLo57oamLAF/mUhwSEPIVev8X9LlAnNMGlk5GWQg+gEKcjm4vtZJEeSP0eYix
ZHHAsxiOCiM9+R4xlE5cc6KSVQonuIKV7CgA5I2NXsvD27mQcSjkC+L0vwzhU7yf
tLVkr49CQiWT69XQimfRAMHQOxMrstbOGZptJHhQzsCInD3K9CoIszDKF26sYqIz
CS4Nhlu7ygnQTP/Jy18IGQ+m+AbIdbsV+TNrCwuCZze2G0kBnmWoF5ZyesgEV9Q=
=mimG
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
