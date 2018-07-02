Received: from eggs.gnu.org ([2001:4830:134:3::10]:57887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxvg-0004UJ-Eq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fZxvb-0004cI-TP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:27:40 -0400
Date: Mon, 2 Jul 2018 13:27:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702122733.GC2155@stefanha-x1.localdomain>
References: <20180627143815.1829-1-joel@jms.id.au>
	<20180627143815.1829-3-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20180627143815.1829-3-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] arm: Add BBC micro:bit machine
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


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2018 at 12:08:14AM +0930, Joel Stanley wrote:
> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> new file mode 100644
> index 000000000000..e9e0d35ca79c
> --- /dev/null
> +++ b/hw/arm/microbit.c
> @@ -0,0 +1,56 @@
> +/*
> + * BBC micro:bit machine
> + * http://tech.microbit.org/hardware/
> + *
> + * Copyright 2018 Joel Stanley <joel@jms.id.au>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/arm/arm.h"
> +#include "exec/address-spaces.h"
> +
> +#include "hw/arm/nrf51_soc.h"
> +
> +#define FLASH_BASE      0x00000000

Unused, please remove.

Aside from that:
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOho1AAoJEJykq7OBq3PIjJYH/RiWVrGgbbchLAaGMs1293/A
CrxioGLNC9QM4DtQJ2gPLX1E93rPxB2MD/Y4+M7s5RoHEB4AbXKZ8LvLpX5swjvC
IGok8Ju6LGozwnmOm8ijQN3uqCDQcTTo+n8AVzZgbiZyvFbtrYGo6P/ePQxjetK+
oiT+acdlwM3THPL/8HECSreWoC5wyqHL7gM6g5TeKTVy9bSPlWsrrxEELl/47NTq
i3OuDKvNmuIzx2CZyx/0614okauNG5Q1v7M0EEn2wCJ4kiwmF80k6S3Qa8AKqJMx
wka7vUgX5hKq6uGd1rujRT0VsM+HiAS8gTphrjnUqtkSMjM2E4oI23Wk45eW8ps=
=TIVn
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
