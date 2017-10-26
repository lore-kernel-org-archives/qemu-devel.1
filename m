Received: from eggs.gnu.org ([2001:4830:134:3::10]:52258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e7kpA-0005xR-VQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1e7kp8-0001sb-Ae
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:16:04 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
	<CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
	<CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 26 Oct 2017 18:15:57 +0200
Message-ID: <CAHmME9pE79krWx-zD=VGiScT4c=4TZ1wVxYFiF3m+8wsx9Fqeg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 26, 2017 at 4:36 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> This has *never* been guaranteed or indeed true. It's just happened
> to be true for the x86 PC machine and perhaps for some others that
> you've been using. For instance, the MIPS boston board only has
> one uart. highbank has one. integratorcp has 2. The microblaze
> boards only have one uart. And so on. In cases where we're
> modelling real hardware, if the real board only has one UART
> then we're only going to provide one UART, so in some cases you
> just have to deal with that and have some way in your communication
> protocol to multiplex across a single communications channel.

Interesting. Malta provides quite a few, which is what I'm using on
MIPS, so I guess I've benefited from the uniformity. Since the ARM
virt machine is virtual, it seems like it'd be worthwhile to make it
broadly useful, and adding a few more serial outputs is basically
free.

Right now on build.wireguard.com, I'm just using this horrendous patch
that hopefully hurts to look at: https://=D7=90.cc/iKBdlvI3/patch (since I
only need 2). The goal would be for everything else to remain the same
in the deployment, but to not have to use that patch.


>> Could we just do the simple patch of adding four pl011s in there?
>
> I'm still thinking about this. (You definitely can't have four,
> though, because we already have 2 in the trustzone-enabled
> config, so we can only add another 2.)

The trustzone one could be the 5th? Since it's only useful for trustzone.
