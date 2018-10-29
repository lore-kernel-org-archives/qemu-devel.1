Received: from eggs.gnu.org ([2001:4830:134:3::10]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHBpn-0008Ag-3Y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHBpl-0006D6-2X
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:14 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHBph-00067z-FR
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 14:00:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id v198-v6so5152674oif.2
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:00:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-81205b33-ccd0-4600-9fbd-0a025c55dcfa@palmer-si-x1c4>
References: <CAKmqyKPXFOw3hv+wYbVPn2c4xPCiUXVyzDPJ3XpOuBx0zp9xGw@mail.gmail.com>
	<mhng-81205b33-ccd0-4600-9fbd-0a025c55dcfa@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 17:59:47 +0000
Message-ID: <CAFEAcA_oMG2qo_W_OFfdkPomu7-hc4vkFSZnC0CLQ_PD6zmW+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Add Alistair as a RISC-V Maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 29 October 2018 at 17:14, Palmer Dabbelt <palmer@sifive.com> wrote:
> I don't think we have anything ready to go right now: your PCIe patches
> still have some outstanding feedback (on interrupt stuff), and Bastian's
> decodetree stuff has some patches from Richard Henderson that should be
> merged in.  I was hoping to get through reviewing Michael's patches to fix
> the FS dirty bit, but haven't had time yet -- they're tested, but I haven't
> actually read through them.
>
> Maybe we should get a RISC-V QEMU mailing list so we can keep everyone in
> sync without spamming the whole world?

We can sort out a qemu-riscv mailing list like the ones we have
for ppc and arm if you like:
https://wiki.qemu.org/Contribute/MailingLists

Our general principle is that all posts should cc qemu-devel as
well as the subsystem list; the idea is that if you only care
about riscv you can just subscribe to the lower volume list, but
people on qemu-devel still get to see everything without having
to subscribe to half a dozen different other lists.

NB: softfreeze is tomorrow, which is our deadline by which any
pull requests for new feature work should be on the mailing list.
After that it's bugfixes only. So my feeling is that both the
decodetree and the PCI patches have missed the boat for 3.1
and can be dealt with in a more leisurely timescale.

If you have bugfixes in your tree that could do with being
upstreamed, this is a good time in the release cycle to look
at doing that, I think.

thanks
-- PMM
