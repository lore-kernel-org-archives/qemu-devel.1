Received: from eggs.gnu.org ([2001:4830:134:3::10]:49203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9WD7-0006sy-Fe
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9WD6-0003yl-HJ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:08:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9WD6-0003yV-6E
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:08:36 -0400
Received: by mail-oi1-x241.google.com with SMTP id u197-v6so15855821oif.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 07:08:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 15:08:14 +0100
Message-ID: <CAFEAcA8PHLZGfYpwU=zsG8eZ==hWu-b9CLJ_7Z+8+C5YvgZfuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 00/12] arm: Add first models of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> In QEMU we'd like to have a virtual developer board with the Versal SoC
> and a selected set of peripherals under the control of QEMU.
> We'd like to gradually extend this board as QEMU gains more support
> for Versal hardware components. QEMU will generate a device-tree
> describing only the components it supports and includes in the virtual
> dev board.

So, the SoC implementation and the GEM and HVC bugfix patches
here are straightforward. What I'm less sure about is the "virtual"
nature of the board model. What do we gain doing this rather than
just modelling some particular Versal dev board?

At the moment we have a fairly clear distinction:
 * most machine models are models of real hardware, and the
   real hardware is the litmus test for how things are supposed
   to work (and, like real hardware, the user provides the DTB)
 * the "virt" board is special, because it is purely virtual and
   contains only a few specific devices, so it can run Linux guests

This would seem to be an odd hybrid, with an SoC that's a model
of real hardware but also some virtual "QEMU controls what's
present and creates the dtb" aspects.

thanks
-- PMM
