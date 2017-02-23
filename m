Received: from eggs.gnu.org ([2001:4830:134:3::10]:48841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyRP-000796-JV
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgyRO-0004Bi-IE
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:48:35 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgyRO-0004BW-Ce
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:48:34 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so37942618wmv.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:48:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170222112338.25492-2-clement.deschamps@antfield.fr>
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
	<20170222112338.25492-2-clement.deschamps@antfield.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Feb 2017 18:48:12 +0000
Message-ID: <CAFEAcA84OnAiAujSa-N5dtK0TO5KeCyiXxKvTwShXrqieGaxhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/3] bcm2835_sdhost: add bcm2835 sdhost
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Baumann <andrew.baumann@microsoft.com>

On 22 February 2017 at 11:23, Clement Deschamps
<clement.deschamps@antfield.fr> wrote:
> This adds the BCM2835 SDHost controller from Arasan.
>
> Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
> ---
>  hw/sd/Makefile.objs            |   1 +
>  hw/sd/bcm2835_sdhost.c         | 429 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/sd/bcm2835_sdhost.h |  48 +++++
>  3 files changed, 478 insertions(+)
>  create mode 100644 hw/sd/bcm2835_sdhost.c
>  create mode 100644 include/hw/sd/bcm2835_sdhost.h
>
> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 31c83308f2..c2b7664264 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -6,3 +6,4 @@ common-obj-$(CONFIG_SDHCI) += sdhci.o
>  obj-$(CONFIG_MILKYMIST) += milkymist-memcard.o
>  obj-$(CONFIG_OMAP) += omap_mmc.o
>  obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
> +obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
> new file mode 100644
> index 0000000000..03c93ddb25
> --- /dev/null
> +++ b/hw/sd/bcm2835_sdhost.c
> @@ -0,0 +1,429 @@
> +/*
> + * Raspberry Pi (BCM2835) SD Host Controller
> + *
> + * Copyright (c) 2017 Antfield SAS
> + *
> + * Authors:
> + *  Clement Deschamps <clement.deschamps@antfield.fr>
> + *  Luc Michel <luc.michel@antfield.fr>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.
> + * See the COPYING file in the top-level directory.

GPL-2-only is OK if that's what you strongly want, but if all the
authors are OK with it we prefer GPL-2-or-later (see the note in
the LICENSE file). Similarly with the header file.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
