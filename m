Received: from eggs.gnu.org ([209.51.188.92]:50344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghNGr-0007Kc-A2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghNGp-000589-B4
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:28:25 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghNGo-00057k-N9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:28:23 -0500
Received: by mail-oi1-x244.google.com with SMTP id t204so7793788oie.7
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 15:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20190103094211.28473-1-geert+renesas@glider.be>
	<acd10959-a781-d3bf-dc67-bda878740ec9@redhat.com>
	<CAFEAcA9jk1ocW8h33-f9mRM52mT96o+bviaRe6MRErkyxBtqYQ@mail.gmail.com>
	<CAMuHMdX6gwnw7RYQNik4QQmfWoTmemMgrUaPuW9Rgd56pW+4jQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX6gwnw7RYQNik4QQmfWoTmemMgrUaPuW9Rgd56pW+4jQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Jan 2019 23:28:10 +0000
Message-ID: <CAFEAcA9-eo7_1Wm20JkwCs_yG-r6v3aw19T0BVpp6qePw+JnmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH QEMU v5] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Auger Eric <eric.auger@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Alex Williamson <alex.williamson@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

So I should start out upfront by saying that I'm aware that
the reality is that people do want to do passthrough with
this kind of hardware, and that's not an unreasonable
thing to do. I just don't really like the way that pushes
the software into having to do ugly things...

Overall I'll let Eric call the shots about how well this
feature fits into our sysbus-fdt support; he knows this
code much better than I do. (I would have preferred us
not to have sysbus-fdt passthrough at all, in an
ideal world :-))

On Wed, 9 Jan 2019 at 16:30, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jan 9, 2019 at 5:03 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > whitelists for the devices we want to allow passthrough of and
> > that we've tested to work.
>
> In the end, this will become a loooooong list (SoC x devices)...

Well, yes, but it deters people from trying to do passthrough
with hardware that's not designed in a way that makes
passthrough reasonably supportable at a software level.

> Reality is that on embedded, on-SoC devices are usually not on a PCI bus.
> But IOMMUs are present, and virtualization is wanted.

I don't insist on PCI. Probeable, and consistent in
terms of what they provide and how you interact with
them, is what we want. Embedded on-SoC devices are
generally neither. (The host kernel could in theory
provide an API that exposed only devices that were safely
pass-through-able in a consistent way, I suppose, but it
doesn't, or we wouldn't be having to fish through the
device tree nodes making guesses about what's safe to
allow and what isn't and having heuristics about not
providing clocks info being ok if we think the clock
might only be used for power management...)

thanks
-- PMM
