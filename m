Received: from eggs.gnu.org ([2001:4830:134:3::10]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e7iut-0003Fl-7K
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e7iun-0005hn-JU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:13:51 -0400
MIME-Version: 1.0
In-Reply-To: <20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 26 Oct 2017 16:13:33 +0200
Message-ID: <CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 26, 2017 at 3:34 PM, Andrew Jones <drjones@redhat.com> wrote:
> You could make the PL011 user instantiate-able and make the necessary
> changes to use the dynamic FDT node generation framework (sysbus-fdt),
> and then you'd be able to add as many additional UARTs as you like to
> mach-virt's platform bus. I played around with that idea once, and have
> some patches rotting somewhere that could maybe be dug back up.

The problem with this approach is that then different architectures
need different fancy options, which makes things a hassle. With the
old guarantee of each machine providing four serial ports, you could
just do -serial 1 -serial 2 and not have to worry about it. Much
nicer.

Making FDT dynamic also sounds complicated.

Could we just do the simple patch of adding four pl011s in there?
