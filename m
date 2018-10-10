Received: from eggs.gnu.org ([2001:4830:134:3::10]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAIcB-0007nt-JJ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gAIc8-0000ha-CG
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:49:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gAIc7-0000gH-TF
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:49:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id u6-v6so141053plz.4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:49:39 -0700 (PDT)
Date: Wed, 10 Oct 2018 10:49:36 -0700 (PDT)
In-Reply-To: <cover.1539023064.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-99c18a25-be61-4fa6-93c6-313a0fa37372@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5]  Misc RISC-V patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Clark <mjc@sifive.com>, alistair23@gmail.com, Alistair.Francis@wdc.com

On Mon, 08 Oct 2018 11:25:07 PDT (-0700), Alistair.Francis@wdc.com wrote:
> These are some patches that I have cherry picked from Michael's RISC-V
> tree that are ready to be applied.
> Unless anyone has any comments against these I'll send a PR later this
> week.
>
> Michael Clark (5):
>   RISC-V: Allow setting and clearing multiple irqs
>   RISC-V: Move non-ops from op_helper to cpu_helper
>   RISC-V: Update CSR and interrupt definitions
>   RISC-V: Add missing free for plic_hart_config
>   RISC-V: Don't add NULL bootargs to device-tree
>
>  hw/riscv/sifive_clint.c                 |   8 +-
>  hw/riscv/sifive_plic.c                  |   4 +-
>  hw/riscv/sifive_u.c                     |   4 +-
>  hw/riscv/spike.c                        |   6 +-
>  hw/riscv/virt.c                         |   6 +-
>  target/riscv/Makefile.objs              |   2 +-
>  target/riscv/cpu.c                      |   6 +-
>  target/riscv/cpu.h                      |  22 +-
>  target/riscv/cpu_bits.h                 | 683 +++++++++++++-----------
>  target/riscv/{helper.c => cpu_helper.c} |  35 +-
>  target/riscv/op_helper.c                |  34 +-
>  11 files changed, 438 insertions(+), 372 deletions(-)
>  rename target/riscv/{helper.c => cpu_helper.c} (95%)

I tried pinging Michael but he hasn't responded.  As far as I'm concerned, as 
long as you've tested these then they seem fine -- they look pretty safe.  If 
you're not set up to make QEMU PRs then I can do so, as we should really get 
the ball rolling on our big patch backlog.
