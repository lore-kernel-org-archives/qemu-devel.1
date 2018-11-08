Received: from eggs.gnu.org ([2001:4830:134:3::10]:53980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgcH-0006Lm-WC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgcD-0000yq-7f
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:28:45 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gKgcB-0000s1-TH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:28:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id y15-v6so20413200wru.9
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:28:33 -0800 (PST)
Date: Thu, 8 Nov 2018 09:28:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181108092830.GA17083@stefanha-x1.localdomain>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-6-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20181102170730.12432-6-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v4 05/13] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 01:07:22PM -0400, Steffen G=F6rtz wrote:
> The nRF51 contains three regions of non-volatile memory (NVM):
> - CODE (R/W): contains code
> - FICR (R): Factory information like code size, chip id etc.
> - UICR (R/W): Changeable configuration data. Lock bits, Code
>   protection configuration, Bootloader address, Nordic SoftRadio
>   configuration, Firmware configuration.
>=20
> Read and write access to the memories is managed by the
> Non-volatile memory controller.
>=20
> Memory schema:
>  [ CPU ] -+- [ NVM, either FICR, UICR or CODE ]
>           |      |
>           \- [ NVMC ]
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/nvram/Makefile.objs       |   1 +
>  hw/nvram/nrf51_nvm.c         | 333 +++++++++++++++++++++++++++++++++++
>  include/hw/nvram/nrf51_nvm.h |  70 ++++++++
>  3 files changed, 404 insertions(+)
>  create mode 100644 hw/nvram/nrf51_nvm.c
>  create mode 100644 include/hw/nvram/nrf51_nvm.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5AG9AAoJEJykq7OBq3PIrSgH/06nhkEF7O0r5wlTO0xDE1Dq
1B9KgqRGjGl638Hcr8KpIT/yaWilC5a7ZROHglNwkUgc23SzPZrbU5OELl95uonf
SrYeJLFm2OuFLcZKg2EgiVevQKd8hjRhnbt2WfvhxOkHPNQrYOVVcxqmD4RuqgAu
ugYhz9uWjGzjaD3kL24jYQmGtLqpxkjRQewOX9yK5GfhXqftxRHxOoTQKaLulYOH
/bI+hZP4Uxtxnl5Rf7z35rOfnvsI+S5VAnjB9ySKUFjRFa6qf+PBD+R98PNP26f1
koxF3v6qA/PN1LhjJ940CbWNlWG3a4UIKsAtoLmKGfnDgltyan1s7vhJSCbwn0Y=
=SJBY
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
