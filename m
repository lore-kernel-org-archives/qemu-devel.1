Received: from eggs.gnu.org ([2001:4830:134:3::10]:57781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxg0X-0001Kr-L7
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fxg0W-0004M5-Q2
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:41 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fxg0W-0004L3-HX
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 18:10:40 -0400
Received: by mail-lf1-x141.google.com with SMTP id x207-v6so7343698lff.3
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 15:10:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904231442.18932-1-alistair.francis@wdc.com>
References: <20180904231442.18932-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Sep 2018 15:10:08 -0700
Message-ID: <CAKmqyKOyExBaxYFi6i+rOBcHikMfoQn1EGU7Hbep8M5HHwHVVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] riscv-pullreq queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Sep 4, 2018 at 4:14 PM, Alistair Francis
<alistair.francis@wdc.com> wrote:
> The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd241557452:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27-v2' into staging (2018-08-27 16:44:20 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pullreq-20180904
>
> for you to fetch changes up to 3b18c3fa870f11b8a1841bb7537e5bc11100160c:
>
>   riscv: remove define cpu_init() (2018-09-04 13:24:39 -0700)

Disregard this, I have sent a v2.

Alistair

>
> ----------------------------------------------------------------
> A misc collection of RISC-V related patches for 3.1.
>
> ----------------------------------------------------------------
> Alistair Francis (2):
>       hw/riscv/virtio: Set the soc device tree node as a simple-bus
>       hw/riscv/spike: Set the soc device tree node as a simple-bus
>
> Emilio G. Cota (2):
>       target/riscv: optimize indirect branches
>       target/riscv: call gen_goto_tb on DISAS_TOO_MANY
>
> Igor Mammedov (1):
>       riscv: remove define cpu_init()
>
> Michael Clark (4):
>       RISC-V: Update address bits to support sv39 and sv48
>       RISC-V: Improve page table walker spec compliance
>       RISC-V: Use atomic_cmpxchg to update PLIC bitmaps
>       RISC-V: Simplify riscv_cpu_local_irqs_pending
>
>  hw/riscv/sifive_plic.c         | 49 ++++++++++-----------
>  hw/riscv/spike.c               |  2 +-
>  hw/riscv/virt.c                |  2 +-
>  include/hw/riscv/sifive_plic.h |  1 -
>  target/riscv/cpu.h             |  9 ++--
>  target/riscv/cpu_bits.h        |  2 -
>  target/riscv/helper.c          | 98 ++++++++++++++++++++++++------------------
>  target/riscv/translate.c       |  9 +---
>  8 files changed, 87 insertions(+), 85 deletions(-)
>
