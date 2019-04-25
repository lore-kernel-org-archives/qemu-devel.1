Received: from eggs.gnu.org ([209.51.188.92]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6n-0003v7-42
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJV6m-0008QY-04
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:37 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJV6l-0008OM-N1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 23:31:35 -0400
Received: by mail-pf1-x443.google.com with SMTP id z5so10394019pfn.3
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 20:31:35 -0700 (PDT)
Date: Wed, 24 Apr 2019 20:31:32 -0700 (PDT)
In-Reply-To: <20190401031155.21293-2-richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-4fc40e41-5464-469e-9334-1edc4f8294e3@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org

On Sun, 31 Mar 2019 20:11:48 PDT (-0700), richard.henderson@linaro.org wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

If I understand decodetree correctly, this isn't used until patch 5.
Otherwise,

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I don't care enough about this to make you re-spin the patch set, so I'm OK
taking it as it stands unless there's anything else that crops up as I look
through the rest of the patches...

Thanks!

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
