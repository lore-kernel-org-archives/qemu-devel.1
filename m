Received: from eggs.gnu.org ([2001:4830:134:3::10]:47726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSNTY-0003WD-VK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSNTT-0001ur-Br
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:07:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSNTT-0001uY-7D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:07:11 -0400
Received: by mail-oi0-x244.google.com with SMTP id 188-v6so4591998oid.12
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 07:07:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601141223.26630-1-peter.maydell@linaro.org>
References: <20180601141223.26630-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 15:06:50 +0100
Message-ID: <CAFEAcA-jg7iQuYeRSteJVoq9nd4ysvCJcGZTibhRBDhgr3pQ9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/6] More conversions away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <huth@tuxfamily.org>, "patches@linaro.org" <patches@linaro.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 1 June 2018 at 15:12, Peter Maydell <peter.maydell@linaro.org> wrote:
> Half a dozen miscellaneous conversions away from old_mmio usage
> in the MemoryRegionOps struct. This leaves us with only 10
> remaining in the tree.
>
> NB: mips parts tested only via 'make check'.
>
> thanks
> -- PMM
>
> Peter Maydell (6):
>   hw/sh/sh7750: Convert away from old_mmio
>   hw/m68k/mcf5206: Convert away from old_mmio
>   hw/block/pflash_cfi02: Convert away from old_mmio
>   hw/watchdog/wdt_i6300esb: Convert away from old_mmio
>   hw/input/pckbd: Convert away from old_mmio
>   hw/char/parallel: Convert away from old_mmio

Ping for review on patches 1, 4, 5, 6, please?

thanks
-- PMM
