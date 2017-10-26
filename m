Received: from eggs.gnu.org ([2001:4830:134:3::10]:55232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7jGn-0005V6-BE
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7jGm-0006Nr-Hx
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:36:29 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:48713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7jGm-0006Mu-Af
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:36:28 -0400
Received: by mail-wm0-x242.google.com with SMTP id p75so8419174wmg.3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 07:36:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
	<CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 15:36:06 +0100
Message-ID: <CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 15:13, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The problem with this approach is that then different architectures
> need different fancy options, which makes things a hassle. With the
> old guarantee of each machine providing four serial ports

This has *never* been guaranteed or indeed true. It's just happened
to be true for the x86 PC machine and perhaps for some others that
you've been using. For instance, the MIPS boston board only has
one uart. highbank has one. integratorcp has 2. The microblaze
boards only have one uart. And so on. In cases where we're
modelling real hardware, if the real board only has one UART
then we're only going to provide one UART, so in some cases you
just have to deal with that and have some way in your communication
protocol to multiplex across a single communications channel.

> Could we just do the simple patch of adding four pl011s in there?

I'm still thinking about this. (You definitely can't have four,
though, because we already have 2 in the trustzone-enabled
config, so we can only add another 2.)

thanks
-- PMM
