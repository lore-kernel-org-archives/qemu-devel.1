Received: from eggs.gnu.org ([209.51.188.92]:44624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrX-0000wf-Io
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJgrW-0002ck-0X
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:39 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJgrV-0002EL-GF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:04:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id j11so115129pff.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:04:28 -0700 (PDT)
Date: Thu, 25 Apr 2019 09:04:25 -0700 (PDT)
In-Reply-To: <20190401031155.21293-1-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-f96f6f0d-cec7-477e-96c8-af5485b43bc7@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/8] target/riscv: decodetree
 improvments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:47 PDT (-0700), richard.henderson@linaro.org wrote:
> There's new support in decodetree for pattern groups.
> I believe that patch 5, or something close to it, was
> posted as an RFC as part of the original pattern group
> patch set, but this cleans that up further.
>
>
> r~
>
>
> Richard Henderson (8):
>   target/riscv: Name the argument sets for all of insn32 formats
>   target/riscv: Use --static-decode for decodetree
>   target/riscv: Merge argument sets for insn32 and insn16
>   target/riscv: Merge argument decode for RVC shifti
>   target/riscv: Use pattern groups in insn16.decode
>   target/riscv: Split RVC32 and RVC64 insns into separate files
>   target/riscv: Split gen_arith_imm into functional and temp
>   target/riscv: Remove spaces from register names
>
>  target/riscv/cpu.c                      |  16 +-
>  target/riscv/insn_trans/trans_rvc.inc.c | 347 ------------------------
>  target/riscv/insn_trans/trans_rvi.inc.c |  20 +-
>  target/riscv/translate.c                |  40 ++-
>  target/riscv/Makefile.objs              |  15 +-
>  target/riscv/insn16-32.decode           |  28 ++
>  target/riscv/insn16-64.decode           |  30 ++
>  target/riscv/insn16.decode              | 154 ++++++-----
>  target/riscv/insn32.decode              |  10 +-
>  9 files changed, 205 insertions(+), 455 deletions(-)
>  delete mode 100644 target/riscv/insn_trans/trans_rvc.inc.c
>  create mode 100644 target/riscv/insn16-32.decode
>  create mode 100644 target/riscv/insn16-64.decode

Thanks!  I'm happy taking this as it stands, since all those decode issues I
pointed out aren't regressions in this patch set.  Let me know if you want to
fix those or if you want me to -- as you can probably tell my email queue is a
bit long... :)

I've dropped this on my integration branch, but I probably won't submit a pull
for a week or so.
