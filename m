Received: from eggs.gnu.org ([2001:4830:134:3::10]:35297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gFb8C-0003mK-As
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gFb88-0002Ax-Tt
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:36:40 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gFb88-0001sK-JY
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 04:36:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id q6-v6so8348378wrw.11
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 01:36:28 -0700 (PDT)
Date: Thu, 25 Oct 2018 09:36:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181025083625.GA25480@stefanha-x1.localdomain>
References: <20181025005052.27661-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20181025005052.27661-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] arm: Add nRF51 SoC UART support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 03:50:49AM +0300, Julia Suvorova via Qemu-devel wro=
te:
> This series adds support for the nRF51 SoC UART, that used in
> BBC Micro:bit board, and QTest for it.
>=20
> v3:
>     * serial_hd() moved to the board code
>     * sysbus_init_child_obj() used for initialization
>     * qemu_chr_fe_accept_input() called after byte popping
>=20
> v2:
>     * Suspend/Enable functionality added
>     * Connection to SoC moved to a separate patch
>     * Added QTest for checking reception functionality
>     * Mini-kernel test changed to fit current implementation
>     * Addressed review comments on R_*, uart_can_receive, VMState,
>       uart_transmit
>=20
> Julia Suvorova (3):
>   hw/char: Implement nRF51 SoC UART
>   hw/arm/nrf51_soc: Connect UART to nRF51 SoC
>   tests/boot-serial-test: Add microbit board testcase
>=20
>  hw/arm/microbit.c            |   2 +
>  hw/arm/nrf51_soc.c           |  20 +++
>  hw/char/Makefile.objs        |   1 +
>  hw/char/nrf51_uart.c         | 330 +++++++++++++++++++++++++++++++++++
>  hw/char/trace-events         |   4 +
>  include/hw/arm/nrf51_soc.h   |   3 +
>  include/hw/char/nrf51_uart.h |  78 +++++++++
>  tests/boot-serial-test.c     |  19 ++
>  8 files changed, 457 insertions(+)
>  create mode 100644 hw/char/nrf51_uart.c
>  create mode 100644 include/hw/char/nrf51_uart.h
>=20
> --=20
> 2.17.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb0YCJAAoJEJykq7OBq3PIchoIAKalplt4yEysSkHLBLMpezfr
x7Xs/k+xTbe8a9zHYXU2r51lfpYTfqfoC7pagsad17/JMIu/JnvVuWV4pZSor3nG
ph00sN24qoXYSspiyj+Bd5tm9+X6xBJLhDvc1WCPj8mvoOfPoVd3SHm8EvfAdePU
v5WZK7Hvtm3ppUoKzu7R3yhdYt/zhMg7533TZyUdKQV7NhZUPNncnqNig3nqmuAU
mp0MjiBFUthNcfm0S6OD6EyvIJYwRozBL8O7Nm5BXTNTL6WYvIijVi0UN9CTeiEb
yjW+O4Ag9d4QSzNKTVkQ0Ka9WyJgsfecr/N/zuHTNEv1ZigT/st6lE3C1a6XgJI=
=/y4H
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
