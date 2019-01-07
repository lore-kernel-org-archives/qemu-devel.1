Received: from eggs.gnu.org ([209.51.188.92]:58468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPFN-0001UI-N2
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ggPFM-0002gB-H1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 02:22:53 -0500
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-10-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4821a853-bd25-7972-66dd-95092d216868@redhat.com>
Date: Mon, 7 Jan 2019 08:22:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190104175847.6290-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/16] hw/devices: Move TI touchscreen
 declarations into a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>, Richard Henderson <rth@twiddle.net>, Jan Kiszka <jan.kiszka@web.de>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Rob Herring <robh@kernel.org>

On 2019-01-04 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Since uWireSlave is only used in this new header, there is no
> need to expose it via "qemu/typedefs.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS                     |  2 ++
>  hw/arm/nseries.c                |  2 +-
>  hw/arm/palm.c                   |  2 +-
>  hw/input/tsc2005.c              |  2 +-
>  hw/input/tsc210x.c              |  4 ++--
>  include/hw/arm/omap.h           |  6 +-----
>  include/hw/devices.h            | 14 --------------
>  include/hw/input/ti_uwire_tsc.h | 28 ++++++++++++++++++++++++++++

I'd maybe rather name the new file "tsc2xxx.h" instead, so that it
resembles the names of the .c files. Just my 0.02 =E2=82=AC.

 Thomas
