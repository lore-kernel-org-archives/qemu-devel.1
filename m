Received: from eggs.gnu.org ([209.51.188.92]:58680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpJV-0006XE-O0
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hBpJS-0003lw-15
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 19:28:59 -0400
MIME-Version: 1.0
References: <20190401031155.21293-1-richard.henderson@linaro.org>
	<20190401031155.21293-2-richard.henderson@linaro.org>
In-Reply-To: <20190401031155.21293-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Apr 2019 16:27:15 -0700
Message-ID: <CAKmqyKOAAC_NpxBCBwK+0R=GO8b2YxEfzU0Thh9QNSB_x1FAWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/8] target/riscv: Name the
 argument sets for all of insn32 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>

On Sun, Mar 31, 2019 at 8:12 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn32.decode | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6f3ab7aa52..77f794ed70 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -34,9 +34,13 @@
>  %imm_u    12:s20                 !function=ex_shift_12
>
>  # Argument sets:
> +&empty
>  &b    imm rs2 rs1
>  &i    imm rs1 rd
> +&j    imm rd
>  &r    rd rs1 rs2
> +&s    imm rs1 rs2
> +&u    imm rd
>  &shift     shamt rs1 rd
>  &atomic    aq rl rs2 rs1 rd
>
> @@ -44,9 +48,9 @@
>  @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>  @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
>  @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
> -@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
> -@u       ....................      ..... .......         imm=%imm_u          %rd
> -@j       ....................      ..... .......         imm=%imm_j          %rd
> +@s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
> +@u       ....................      ..... ....... &u      imm=%imm_u          %rd
> +@j       ....................      ..... ....... &j      imm=%imm_j          %rd
>
>  @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
>  @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
> --
> 2.17.1
>
>
