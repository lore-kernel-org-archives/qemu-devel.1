Received: from eggs.gnu.org ([209.51.188.92]:42086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h2zu0-0002op-Jd
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bmeng.cn@gmail.com>) id 1h2zty-0007Nx-LK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 10:58:12 -0400
MIME-Version: 1.0
References: <20190210201726.3567-1-lukas.auer@aisec.fraunhofer.de>
	<CAEUhbmUtSAeznt1DCwJ7tS=YFeqwnYBemS6278=QQ60qs_MthA@mail.gmail.com>
	<c9f69861058412a1f71418a9c892daf0821a9e33.camel@aisec.fraunhofer.de>
In-Reply-To: <c9f69861058412a1f71418a9c892daf0821a9e33.camel@aisec.fraunhofer.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 10 Mar 2019 22:57:52 +0800
Message-ID: <CAEUhbmXjCqRRtNDqq5E5y60sDz+4=WqMuxFhaLndot7TSJuUiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/riscv/virt: re-add machine-specific
 compatible string to /soc/ node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Cc: "palmer@sifive.com" <palmer@sifive.com>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>, "mjc@sifive.com" <mjc@sifive.com>, "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>, "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>

Hi Lukas,

On Sun, Mar 10, 2019 at 9:44 PM Auer, Lukas
<lukas.auer@aisec.fraunhofer.de> wrote:
>
> Hi Bin,
>
> On Sun, 2019-03-10 at 09:07 +0800, Bin Meng wrote:
> > Hi Lukas,
> >
> > On Mon, Feb 11, 2019 at 6:13 AM Lukas Auer
> > <lukas.auer@aisec.fraunhofer.de> wrote:
> > > Re-add the previous compatible string "riscv-virtio-soc" to the soc
> > > device tree node to allow U-Boot and Linux to bind machine-specific
> > > drivers to it. The current compatible string "simple-bus" is
> > > retained.
> > >
> > > This is required by U-Boot to bind devices early, as part of the
> > > pre-relocation driver model.
> > >
> >
> > I see no problem with U-Boot working with current compatible string
> > "simple-bus". In fact I had planned to remove the compatible string
> > "riscv-virtio-soc" in U-Boot but did not get time to work on it.
> >
>
> It is only required if U-Boot is running in machine-mode. For
> relocation it needs to use the CLINT driver to send appropriate IPIs to
> the other harts. To be able to probe the driver, the device and its
> parent device tree node (soc) must therefore be available in the pre-
> relocation device model.
> This patch was the easiest way I could think of for achieving this. It
> could be that there is a better way of solving this.
>

I tested your SMP U-Boot series in both M-mode and S-mode, using a 4
core 'virt' target. Works fine. I am using QEMU 3.1.0 so it is
"simple-bus".

Regards,
Bin
