Received: from eggs.gnu.org ([209.51.188.92]:46122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYr8-0005Qo-UM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYqc-0006jF-S7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:55:28 -0400
References: <20190427141459.19728-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dadba93d-fdf3-25b8-b3e2-5b43a4618292@redhat.com>
Date: Tue, 30 Apr 2019 21:55:11 +0200
MIME-Version: 1.0
In-Reply-To: <20190427141459.19728-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] hw/microblaze: Kconfig cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Thomas Huth <thuth@redhat.com>

On 27/04/19 16:14, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Edgar, Peter,
>=20
> Few fixes while cleaning Kconfig, trying to optimize builds.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
>   hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze PMU
>   hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machine=
s
>=20
>  hw/Kconfig            | 3 +++
>  hw/dma/Makefile.objs  | 1 -
>  hw/intc/Makefile.objs | 2 +-
>  hw/timer/Kconfig      | 3 ---
>  4 files changed, 4 insertions(+), 5 deletions(-)
>=20

Queued, thanks.

Paolo
