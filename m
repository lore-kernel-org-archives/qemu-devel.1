Received: from eggs.gnu.org ([2001:4830:134:3::10]:57045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fv7Jc-0000JP-G0
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 16:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fv7JX-0003cq-LW
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 16:43:48 -0400
Date: Mon, 27 Aug 2018 14:19:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180827131931.GA20843@stefanha-x1.localdomain>
References: <20180816141303.20518-1-joel@jms.id.au>
	<20180816141303.20518-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20180816141303.20518-3-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v5 2/3] arm: Add Nordic Semiconductor nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Jim Mussared <jim.mussared@gmail.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 16, 2018 at 11:43:02PM +0930, Joel Stanley wrote:
> The nRF51 is a Cortex-M0 microcontroller with an on-board radio module,
> plus other common ARM SoC peripherals.
>=20
>  http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf
>=20
> This defines a basic model of the CPU and memory, with no peripherals
> implemented at this stage.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v2:
>   put memory as struct fileds in state structure
>   pass OBJECT(s) as owner, not NULL
>   Add missing addresses for ficr
>   Fix flash and sram sizes for microbit
>   Embed cpu object in state object an initalise it without use of armv7m_=
init
>   Link to datasheet
> v3:
>   rebase nrf51 on m0 changes
>   remove unused kernel_filename
>   clarify flash and sram size
>   make flash and sram size properties of the soc state
> v4:
>   set the number of interrupts to 32
> v5:
>  move back to armv7m calls, as v4 of Stefan's patch removed the
>  m_profile changes
> ---
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/nrf51_soc.c              | 119 ++++++++++++++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h      |  42 +++++++++++
>  4 files changed, 163 insertions(+)
>  create mode 100644 hw/arm/nrf51_soc.c
>  create mode 100644 include/hw/arm/nrf51_soc.h

Besides what has already been discussed:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbg/pjAAoJEJykq7OBq3PIYfAIAKU5HKGzSlW3FNQI9LBIYfiU
xaQtcQpNZCPdPOMcWfhYsJpiu+3Y2TyepbEt8gX8LREhc3BXoRZv16D7ENKt9DbT
lqBanTi/r4PdgxaAPAy+wsfiSgZ4xWFy/eeTi+jBcraSzVP9xZGTlF+oegZ0HB8w
sUtBsLtDNlIGAnpQyMbimaffyPrsQ+ImbEzyCuGGerkXWnbbxvsPSozTWXi9Kj+Z
am5fTiszM7c9XAb/FjWYdGjqJLu7j83o0ns1zC/qqRLwDGn1BPFGplvDV5zO94Y/
5n1j08nRmEMNESwXMfrnOSTkSgl+tJivdR9ZlliPtD5pnmEF8UlGZxtYASySyIM=
=ObAi
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
