Received: from eggs.gnu.org ([209.51.188.92]:59563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmpcC-0007s8-RG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmpUX-0000DV-8K
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:37:05 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gmpUX-0000D5-39
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 19:37:05 -0500
Received: by mail-pg1-x542.google.com with SMTP id y4so3409964pgc.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 16:37:04 -0800 (PST)
Date: Thu, 24 Jan 2019 16:37:03 -0800 (PST)
In-Reply-To: <cover.1547510220.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-1a177030-8a1a-450d-a3de-6e8c819dde12@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8]  Upstream RISC-V fork patches,
 part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>

On Mon, 14 Jan 2019 15:57:41 PST (-0800), Alistair Francis wrote:
>
> Alistair Francis (1):
>   RISC-V: Add priv_ver to DisasContext
>
> Michael Clark (5):
>   RISC-V: Implement mstatus.TSR/TW/TVM
>   RISC-V: Use riscv prefix consistently on cpu helpers
>   RISC-V: Add misa to DisasContext
>   RISC-V: Add misa.MAFD checks to translate
>   RISC-V: Add misa runtime write support
>
> Richard Henderson (2):
>   RISC-V: Split out mstatus_fs from tb_flags
>   RISC-V: Mark mstatus.fs dirty
>
>  linux-user/riscv/signal.c |   4 +-
>  target/riscv/cpu.c        |   2 +-
>  target/riscv/cpu.h        |  31 ++--
>  target/riscv/cpu_bits.h   |  11 ++
>  target/riscv/cpu_helper.c |  10 +-
>  target/riscv/csr.c        |  91 +++++++++---
>  target/riscv/fpu_helper.c |   6 +-
>  target/riscv/op_helper.c  |  47 ++++--
>  target/riscv/translate.c  | 292 ++++++++++++++++++++++++++++++++------
>  9 files changed, 388 insertions(+), 106 deletions(-)

Thanks.  Assuming that squash is OK I'll include these in my next PR, otherwise 
just send me a v2 and I'll swap them out.
