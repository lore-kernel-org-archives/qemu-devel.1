Received: from eggs.gnu.org ([2001:4830:134:3::10]:51286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTj-00061z-Sm
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ffoTj-0004n1-05
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:43815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ffoTi-0004ko-Oy
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id b15-v6so5114083wrv.10
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:34:58 -0700 (PDT)
Date: Wed, 18 Jul 2018 14:20:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180718132046.GJ21825@stefanha-x1.localdomain>
References: <20180712101219.32707-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Content-Disposition: inline
In-Reply-To: <20180712101219.32707-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v3 0/2] Add NRF51 SOC non-volatile memory
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 12:12:17PM +0200, Steffen G=F6rtz wrote:
> Add some non-volatile memories and a non-volatile
> memory controller for the nRF51.
> Furthermore, a testsuite for the bbc:microbit and
> nrf51 soc was added.
>=20
> Examination of the real device showed that
> NVMs remained unchanged when the write/erase enabled
> bits are not set in the controller, so we can
> safely ignore all writes.
> More: https://github.com/douzepouze/gsoc18-qemu/blob/master/notes.md#test=
-nvmc-behavior-out-of-micropython-repl
>=20
> The CODE/FLASH NVM is not currently included in this
> peripheral. It is hosted in the SOC and must be read-only
> to provide an accurate model.
>=20
> Steffen G=F6rtz (2):
>   arm: Add NRF51 SOC non-volatile memory controller
>   tests: Add bbc:microbit / nRF51 test suite

Please include a changelog in the cover letter so that it's clear what
has changed in this revision.

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTz6uAAoJEJykq7OBq3PIOkYIAJySIaodAUx/lF3+ql3wc6Mz
IJ5HXH3j/QZphZScyM6L2+YpWOAgaTeo4FKZi1+DFhima3/oKsVB/cLaVMBhx6uV
ckJPvSQRdPPcVHbDkINYAU/d0zI+hi9KPubuypiM90C19bgJfqFhfisdwMyrdhrF
Fnr+rap/TrSkKODNvATeSs4jgjDMMyakNSXVUOwuvRpJb+J2GV5bcyKxmNa6RHVp
A3JpZ7rZ9RoBJiIDUVFmBG1M5GKBKeObQA10ZPBHCSgOOSNBRQFIvGYNRCK1ELjj
rA3YQOMU9Y8iJ+PT3Je2cAz/NYfHC7NW0AhdxDebnA0AWhbdrwAUWKIdcQm2vtU=
=ksdC
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--
