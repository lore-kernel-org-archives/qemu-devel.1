Received: from eggs.gnu.org ([2001:4830:134:3::10]:48336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejmDX-0003vC-Ml
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejmDW-0004Ml-Nn
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:26:23 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejmDW-0004MJ-JD
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:26:22 -0500
Received: by mail-ot0-x231.google.com with SMTP id m20so4297265otf.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:26:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207042438.15422-13-andrew.smirnov@gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-13-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 13:26:01 +0000
Message-ID: <CAFEAcA8Hjsb+KW4A0ks696+zXOeDErndeQDFvOqshyONpyaSSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 12/14] i.MX: Add i.MX7 SOC
 implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 7 February 2018 at 04:24, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> The following interfaces are partially or fully emulated:

Hi Andrey. I was just going through this series to apply to
target-arm.next, and I noticed that fsl-imx7.c is GPL-2-or-later,
but fsl-imx7.h is GPL-2-only. Is that intentional?

If this is just an accidental error, and you send an email to
say you meant 2-or-later, then I can fix this in my target-arm
tree by copying the license paragraphs from fsl-imx7.c to fsl-imx7.h.

> --- /dev/null
> +++ b/hw/arm/fsl-imx7.c
> @@ -0,0 +1,580 @@
> +/*
> + * Copyright (c) 2018, Impinj, Inc.
> + *
> + * i.MX7 SoC definitions
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * Based on hw/arm/fsl-imx6.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +

> --- /dev/null
> +++ b/include/hw/arm/fsl-imx7.h
> @@ -0,0 +1,221 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX7 SoC definitions
> + *
> + * Author: Andrey Smirnov <andrew.smirnov@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +

thanks
-- PMM
