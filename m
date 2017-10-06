Received: from eggs.gnu.org ([2001:4830:134:3::10]:38158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UJO-0001mD-8L
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0UJM-0004xL-VC
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:13:14 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:47457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0UJM-0004vm-P4
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:13:12 -0400
Received: by mail-wr0-x236.google.com with SMTP id y44so7931163wrd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 08:13:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920070135.31379-6-clg@kaod.org>
References: <20170920070135.31379-1-clg@kaod.org>
	<20170920070135.31379-6-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 16:12:51 +0100
Message-ID: <CAFEAcA-AnBaHadyHaOuS4648b3W3AXngMs9k9hCCDXyXBSLvTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/6] misc: add pca9552 LED blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 20 September 2017 at 08:01, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> Specs are available here :
>
>   https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
>
> This is a simple model supporting the basic registers for led and GPIO
> mode. The device also supports two blinking rates but not the model
> yet.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>


> --- /dev/null
> +++ b/include/hw/misc/pca9552.h
> @@ -0,0 +1,32 @@
> +/*
> + * PCA9552 I2C LED blinker
> + *
> + * Copyright (c) 2017, IBM Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later. See the COPYING file in the top-level directory.
> + */
> +#ifndef PCA9552_H
> +#define PCA9552_H
> +
> +#include "hw/i2c/i2c.h"
> +
> +#define TYPE_PCA9552 "pca9552"
> +#define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
> +
> +
> +#define PCA9552_NR_REGS 10
> +
> +typedef struct PCA9552State {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +    uint8_t buf[1]; /* just to remember how to handle a larger buffer */

Changing this later is going to be a migration compatibility break
(or at least a bit painful to keep compat).
Do we know how big the buffer is supposed to be? If so it would
be best to make it the correct size to start with.

> +
> +    uint8_t regs[PCA9552_NR_REGS];
> +} PCA9552State;

thanks
-- PMM
