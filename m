Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY6GN-0006vO-Kv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fY6GJ-0006NN-Da
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:57:19 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:39523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fY6GJ-0006MS-4O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:57:15 -0400
Received: by mail-wm0-x22c.google.com with SMTP id p11-v6so4538118wmc.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 01:57:14 -0700 (PDT)
Date: Wed, 27 Jun 2018 09:57:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180627085711.GA4325@stefanha-x1.localdomain>
References: <20180626104943.2756-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20180626104943.2756-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v2] arm: Add NRF51 random number generator
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 12:49:43PM +0200, Steffen G=F6rtz wrote:
> Add a model of the NRF51 random number generator peripheral.
>=20
> Changes since v1:
>   - Add implementation access size hints to MemoryRegionOps
>   - Fail on error if qcrypto_random_bytes fails
>   - Add references to Nrf51 datasheets

Please put the changelog below '---' so it's excluded from the git log.
(Once the final version of the patch has been merged, the changelog is
no longer useful since git log lacks previous patch versions.)

>=20
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  hw/misc/Makefile.objs       |   1 +
>  hw/misc/nrf51_rng.c         | 242 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/nrf51_rng.h |  73 +++++++++++
>  3 files changed, 316 insertions(+)
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 include/hw/misc/nrf51_rng.h
>=20
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 00e834d0f0..fd8cc97249 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -70,3 +70,4 @@ obj-$(CONFIG_AUX) +=3D auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
>  obj-y +=3D mmio_interface.o
>  obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
> +obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
> diff --git a/hw/misc/nrf51_rng.c b/hw/misc/nrf51_rng.c
> new file mode 100644
> index 0000000000..f9fdcd08e6
> --- /dev/null
> +++ b/hw/misc/nrf51_rng.c
> @@ -0,0 +1,242 @@
> +/*
> + * nrf51_rng.c
> + *
> + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */

=46rom my v1 review:

Please include a reference to the datasheet for this device and
mention the full name "Random Number Generator" so the purpose of this
device is clear.

The reference manual URL is:
http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

(Including the URL is nice because it saves the reader from doing web
searches and deciding whether the results correspond with the device
that was modeled.)

Aside from that:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM1FnAAoJEJykq7OBq3PI2e8H/0G3jZicGRvj2NBdAfiGtMgd
cYjhe98thHtQAr3KeX+n5OzpycjE0812naTUmA2h7txYJ8czNTciChsgdK4b0wC6
IX1GuE95VlIBmMDHEyZQZMpQATqTYuFJdxP0WMhH6NCkHNeKeO9CztVMY7hd0Imu
lp9ZI44b8+ZeGJUbLRGlSncmyC1Qz0T2v8ZFRBWVlLCYArbJZgaypowAP88mxWuh
RhiCArd3glfnQMYJ/A1+iZazNVkt52iGSCTRjhZgYMY2XFVOxh6BwRwRclh+xKuV
t0nHWDIa9Sjs4tQhaZjvjTf8VSBQXv4Lm+x6RXEfUu1DHYS+wiDZXA7HfNgYHqI=
=4NZQ
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
