Received: from eggs.gnu.org ([2001:4830:134:3::10]:35300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1QJ-00069n-4R
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1QF-0000bN-4t
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:08:51 -0400
Date: Tue, 8 May 2018 13:08:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508120844.GL19710@stefanha-x1.localdomain>
References: <20180503090532.3113-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VBq/nvTu32OVLBUP"
Content-Disposition: inline
In-Reply-To: <20180503090532.3113-1-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/2] arm: Add nRF51 SoC and micro:bit
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>


--VBq/nvTu32OVLBUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 06:35:30PM +0930, Joel Stanley wrote:
> Hello,
>=20
> This short series implements a minimal definition of the Nordic
> Semiconductor nRF51, a Cortex-M0 ARM SoC, and the BBC micro:bit, a
> machine that will use this SoC.
>=20
> This work will serve as the base for our Google Summer of Code and
> Outreachy interns who will work on implementing a number of features on
> top of this base.
>=20
> I've tested this with a microbit micropython firmware, and checked that
> it starts running by looking at it with gdb.
>=20
> I chose to keep the nrf51 and the microbit seperate, to not confuse the
> peripherals that are on the microbit but are not part of the nrf51, and
> vice versa.
>=20
> Please review!
>=20
> Joel Stanley (2):
>   arm: Add Nordic Semiconductor nRF51 SoC
>   arm: Add BBC micro:bit machine
>=20
>  default-configs/arm-softmmu.mak |   1 +
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/microbit.c               |  33 +++++++++++
>  hw/arm/nrf51_soc.c              | 101 ++++++++++++++++++++++++++++++++
>  include/hw/arm/nrf51_soc.h      |  31 ++++++++++
>  5 files changed, 167 insertions(+)
>  create mode 100644 hw/arm/microbit.c
>  create mode 100644 hw/arm/nrf51_soc.c
>  create mode 100644 include/hw/arm/nrf51_soc.h

Thanks for sending this!

Please add a MAINTAINERS file entry.  If you're up for it, I suggest
adding yourself for now.  Julia and Steffen could add themselves later,
depending on their willingness to stay involved after GSoC and Outreachy
end.

Stefan

--VBq/nvTu32OVLBUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8ZNMAAoJEJykq7OBq3PIVogIAKW2xJTXgbP80Y1UooZpb2pk
yipmYonwAFp3MrGx0wGFgnkemvcO9kpKlU5CfthHyHejhSkwM64NEtSSXLPqjtDL
UbVrWNlKoWIx+7UXzy6V2ujLHQtd6l1USe3NyaiaekQllk/UPr58RPZVfIchecaP
DZXPyyFsIzACyXN4zvkrgQMTv9qIkmW5goFhiXAu9z+y1vZUkic4OjGoTDGNg9ar
J+lEHxgQ34UWwHAk1dgvF76Yopi/9OIms4Cfgl6fa2lvXfytbxifquW3m5sf6y8N
+BAI/YEIVBXFMiirEJIZdfw1vdMCak3E7fVcg16k+wSQmgLnd6WAky5LSn52Dsw=
=YQh7
-----END PGP SIGNATURE-----

--VBq/nvTu32OVLBUP--
