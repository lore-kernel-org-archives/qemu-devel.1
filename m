Received: from eggs.gnu.org ([2001:4830:134:3::10]:35290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1e7iJJ-00063j-Ad
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1e7iJI-0006VM-Gh
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 09:35:01 -0400
Date: Thu, 26 Oct 2017 15:34:45 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Oct 24, 2017 at 07:57:37PM +0200, Jason A. Donenfeld wrote:
> Hey folks,
> 
> In case you're curious, this is the kind of hideous workaround
> required until this is fixed:
> 
> https://git.zx2c4.com/WireGuard/commit/?id=2456a56729f7247bf88476317fed0ac822a31e92
> 
> Please let me know if you intend to fix this or if you will accept
> working patches from me for it, or if you simply don't care.
>

You could make the PL011 user instantiate-able and make the necessary
changes to use the dynamic FDT node generation framework (sysbus-fdt),
and then you'd be able to add as many additional UARTs as you like to
mach-virt's platform bus. I played around with that idea once, and have
some patches rotting somewhere that could maybe be dug back up.

drew
