Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cgIzY-0001Ds-SW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1cgIzV-000201-QG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:33:04 -0500
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 21 Feb 2017 18:59:06 +0000
Message-ID: <DM5PR03MB2827328F46EE12C1CDA89B4F9E510@DM5PR03MB2827.namprd03.prod.outlook.com>
References: <20170220173430.31630-1-clement.deschamps@antfield.fr>
	<20170220173430.31630-3-clement.deschamps@antfield.fr>
In-Reply-To: <20170220173430.31630-3-clement.deschamps@antfield.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] bcm2835: add bcm2835_sdhost to bcm2835
 platform
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Clement Deschamps <clement.deschamps@antfield.fr>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "gregory.estrade@gmail.com" <gregory.estrade@gmail.com>

Hi Clement,

I think Peter already gave you a great high-level suggestion, but FWIW I sp=
otted one minor niggle here:

> diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
> index 31c83308f2..c2b7664264 100644
> --- a/hw/sd/Makefile.objs
> +++ b/hw/sd/Makefile.objs
> @@ -6,3 +6,4 @@ common-obj-$(CONFIG_SDHCI) +=3D sdhci.o
>  obj-$(CONFIG_MILKYMIST) +=3D milkymist-memcard.o
>  obj-$(CONFIG_OMAP) +=3D omap_mmc.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_mmci.o
> +obj-$(CONFIG_RASPI) +=3D bcm2835_sdhost.o

I think the Makefile addition should be part of the other patch (1/2) in th=
e series.

Andrew
