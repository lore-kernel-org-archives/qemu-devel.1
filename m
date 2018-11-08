Received: from eggs.gnu.org ([2001:4830:134:3::10]:54344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgeK-0000GJ-04
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgeE-000350-F3
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:30:51 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gKge7-0002gx-MC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:30:40 -0500
Received: by mail-wm1-x341.google.com with SMTP id t15-v6so498861wmt.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:30:33 -0800 (PST)
Date: Thu, 8 Nov 2018 09:30:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181108093031.GB17083@stefanha-x1.localdomain>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
	<20181102170730.12432-12-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20181102170730.12432-12-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v4 11/13] hw/timer/nrf51_timer: Add nRF51
 Timer peripheral
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


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 01:07:28PM -0400, Steffen G=F6rtz wrote:
> This patch adds the model for the nRF51 timer peripheral.
> Currently, only the TIMER mode is implemented.
>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/timer/Makefile.objs         |   1 +
>  hw/timer/nrf51_timer.c         | 368 +++++++++++++++++++++++++++++++++
>  hw/timer/trace-events          |   5 +
>  include/hw/timer/nrf51_timer.h |  75 +++++++
>  4 files changed, 449 insertions(+)
>  create mode 100644 hw/timer/nrf51_timer.c
>  create mode 100644 include/hw/timer/nrf51_timer.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5AI3AAoJEJykq7OBq3PI/jMIAMoB2Zlv7Rb+u7K+0jn95X9T
y4m3N0Wrb4tk3C4Msb97n7RVxIc/v8keOk9zRK4HDejWXiXXLVkG6EuOgjfgGfCg
vHVcEb5ogH2zIni3dLWjaWThp4/d0UsGGxQ5BZquOSIvi9qnSt4xpcaXKPhwEl7S
hH6u9A9Ni9X9NRoUBO0Uvx7/dkUcVxudBk00Hkwnb9Kw99vf3UTQXPKQPWujQfHi
nfWMdfwAh3gNHPBa0ZrVi8PN+CI4mmaGAPidUBIiYwWfz8LCRx1iBgjRl1xMuFrU
6WROzBaFQX5ORPPbHPsfDvM4Aruo8Lu5j6FkJ09p29KM+xbCIoICj+BoDPq8548=
=nwFQ
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
