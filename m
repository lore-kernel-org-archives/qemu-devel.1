Received: from eggs.gnu.org ([2001:4830:134:3::10]:36706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ga200-0007g2-K9
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:20:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ga1zy-0007Zb-VQ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 12:20:40 -0500
MIME-Version: 1.0
References: <cover.1545246859.git.alistair.francis@wdc.com>
	<19f7305e-ae63-3a5b-87dd-e0cfd835462f@linaro.org>
In-Reply-To: <19f7305e-ae63-3a5b-87dd-e0cfd835462f@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 20 Dec 2018 09:20:05 -0800
Message-ID: <CAKmqyKNY4FCzXcpBMWawVA9RWGBZ7vctRLaQGhsODH6HCXkK9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/23] Add RISC-V TCG backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On Wed, Dec 19, 2018 at 10:07 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/19/18 11:16 AM, Alistair Francis wrote:
> > This patch set adds RISC-V backend support to QEMU. This is based on
> > Michael Clark's original work with extra work on top.
> >
> > This has been somewhat tested and can run other architecture softmmu
> > code. It seems that any complex OS will eventually hang, but we can
> > run the BIOS and OS startup code for a number of different operating
> > systems.
> >
> > I haven't tested linux user support at all yet. I think Michael had that
> > working reliably though and hopefully my changes haven't broken it.
> >
> > There are still some todos in the code (there are missing instructions
> > and byte swapping) but these should assert instead of generating invalid
> > code.
>
> Queued to tcg-next, with the extrh fix.

Thanks Richard!

>
> Some of those todos are no longer todos, since e.g. bswap is now optional.
> Those asserts should never fire (as a good assert should do, I suppose).
>
> The missing instructions are only for riscv32, which afaik is just now making
> its way to glibc.  So a chroot complete enough to build qemu is a ways away.
> I'm ok with leaving that incomplete for now.
>
>
> r~
