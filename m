Received: from eggs.gnu.org ([2001:4830:134:3::10]:48828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCz1-0000k1-Bk
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCyx-0008Q9-H7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:09:19 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHCyx-0008Pv-BT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:09:15 -0500
Received: by mail-ot0-x242.google.com with SMTP id b54so11294099otd.8
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:09:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106154813.19936-14-andrew.smirnov@gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<20171106154813.19936-14-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:08:54 +0000
Message-ID: <CAFEAcA-NHA1Pya+p659F3ZWXvcwbA3SRJTb1tPzzqW2mzytSxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/30] i.MX: Add code to emulate i.MX7
 CCM, PMU and ANALOG IP blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Add minimal code needed to allow upstream Linux guest to boot.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/misc/Makefile.objs      |   1 +
>  hw/misc/imx7_ccm.c         | 233 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/misc/imx7_ccm.h | 130 +++++++++++++++++++++++++
>  3 files changed, 364 insertions(+)
>  create mode 100644 hw/misc/imx7_ccm.c
>  create mode 100644 include/hw/misc/imx7_ccm.h
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 29fb922cef..ac1be05a03 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -34,6 +34,7 @@ obj-$(CONFIG_IMX) +=3D imx31_ccm.o
>  obj-$(CONFIG_IMX) +=3D imx25_ccm.o
>  obj-$(CONFIG_IMX) +=3D imx6_ccm.o
>  obj-$(CONFIG_IMX) +=3D imx6_src.o
> +obj-$(CONFIG_IMX) +=3D imx7_ccm.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-hpdmc.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-pfpu.o
>  obj-$(CONFIG_MAINSTONE) +=3D mst_fpga.o
> diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
> new file mode 100644
> index 0000000000..2876164cfa
> --- /dev/null
> +++ b/hw/misc/imx7_ccm.c
> @@ -0,0 +1,233 @@
> +/*
> + * Copyright (c) 2017, Impinj, Inc.
> + *
> + * i.MX7 CCM, PMU and ANALOG IP blocks emulation code

Should these really all be in one single device rather
than one device per IP block ?

thanks
-- PMM
