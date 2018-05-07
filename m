Received: from eggs.gnu.org ([2001:4830:134:3::10]:37580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFjVm-00051g-H0
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFjVl-0005TK-P4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:01:18 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:43520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFjVl-0005Su-JH
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:01:17 -0400
Received: by mail-ot0-x22b.google.com with SMTP id y10-v6so32758188otg.10
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:01:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180507143006.7jodoxul7aplhyh3@sirius.home.kraxel.org>
References: <20180507101013.32736-1-kraxel@redhat.com>
	<CAFEAcA-a74RLKXi=v7w-8v9h6A_QFSKeNxK64AvCYKxc_VN+uA@mail.gmail.com>
	<20180507121126.gjeufzppsc7qspgm@sirius.home.kraxel.org>
	<CAFEAcA_hgd7P5fjgqpc00_PzoAdMzBuABombyAnk4ej6a2itoA@mail.gmail.com>
	<20180507143006.7jodoxul7aplhyh3@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 May 2018 18:00:56 +0100
Message-ID: <CAFEAcA_yutOHAQWcvqm-cfB8EUwmrsw0JrRPF6+eTPtzVOpnpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vga: print friendly error message in case
 multiple vga devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 May 2018 at 15:30, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The only one which passes global_vmstate == false is "-device
> secondary-vga", and that does *not* register vga ioports (the
> registers can be accessed via mmio pci bar though).

Looks like virtio-vga does as well.

> So, right now global_vmstate == "registers vga ioports", and
> I don't expect that to change.

If we want that to remain true I think it's more likely
to continue to hold if we (a) document it and (b) give
the parameter a name that closer matches its function.
But since vga_common_init() doesn't actually do anything
related to registering the ioports, it's kind of odd.
My assumption reading the code was "this is purely for
migration back compat and if we wrote a new VGA device
model we should have it pass 'false', whether it has
IO ports or not.

thanks
-- PMM
