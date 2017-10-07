Received: from eggs.gnu.org ([2001:4830:134:3::10]:53202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0csY-0000eB-QU
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0csX-0001oK-Nw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:22:06 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:37496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e0csX-0001o6-JV
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:22:05 -0400
Received: by mail-ua0-x244.google.com with SMTP id s41so4198uab.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 17:22:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1503467674.git.shorne@gmail.com>
References: <cover.1503467674.git.shorne@gmail.com>
From: Stafford Horne <shorne@gmail.com>
Date: Sat, 7 Oct 2017 09:21:44 +0900
Message-ID: <CAAfxs76NSQFnQ0D23yUcbGzcY9a_VHOH7SyBiBHJk4YdR7V7sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] OpenRISC SMP Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Hello,

Any takers on this?  If not Ill consider sending a pull request
if/when the merge window is open.

-Stafford

On Wed, Aug 23, 2017 at 2:57 PM, Stafford Horne <shorne@gmail.com> wrote:
> Hello,
>
> This series adds SMP support for OpenRISC.  The platform is based on the
> work that Stefan Kristiansson did around 2012 implemented in Verilog and
> run on FPGAs.  I have been working to upstream this work, these are my QEMU
> patches I have been used to help with testing.
>
> I have documented the platform in the OpenRISC 1.2 specification proposal
> available here:
>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
>
> My latest kernel patches are available here:
>   https://github.com/stffrdhrn/linux.git openrisc-4.13-smp-qspinlock
>
> Stafford Horne (5):
>   openrisc/ompic: Add OpenRISC Multicore PIC (OMPIC)
>   target/openrisc: Make coreid and numcores configurable in state
>   openrisc/cputimer: Perparation for Multicore
>   openrisc: Initial SMP support
>   openrisc: Only kick cpu on timeout, not on update
>
>  default-configs/or1k-softmmu.mak |   1 +
>  hw/intc/Makefile.objs            |   1 +
>  hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
>  hw/openrisc/cputimer.c           |  64 ++++++++++----
>  hw/openrisc/openrisc_sim.c       |  87 ++++++++++++++-----
>  target/openrisc/cpu.c            |   1 -
>  target/openrisc/cpu.h            |   7 +-
>  target/openrisc/machine.c        |   8 +-
>  target/openrisc/sys_helper.c     |   8 +-
>  9 files changed, 308 insertions(+), 48 deletions(-)
>  create mode 100644 hw/intc/ompic.c
>
> --
> 2.13.5
>
