Received: from eggs.gnu.org ([2001:4830:134:3::10]:58595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fvs0r-0002Nt-0Q
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fvrid-0002C4-QU
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:16:44 -0400
MIME-Version: 1.0
References: <20180831103816.13479-1-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Aug 2018 15:16:31 -0700
Message-ID: <CACPK8Xdgq4ToH7yOh-v=bqLb6uhqTKeEt9DXOrXx8SaA6UV57A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] aspeed: misc fixes and enhancements
 (SMC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, alistair@alistair23.me, crosthwaite.peter@gmail.com

On Fri, 31 Aug 2018 at 03:38, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> This series adds a couple of cleanups and two main features to the
> Aspeed machines :
>
>  - a 'mmio-exec' property to boot directly from a memory region alias
>    of the FMC flash module using MMIO execution. This is not activated
>    by default because boot time needs to be improved on recent
>    firmwares.
>
>  - support for DMA to access the flash modules. Our primary need is
>    the checksum calculation which is used to evaluate the best clock
>    settings for reads.

I gave this series a number of tests and it looked good.

 Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
