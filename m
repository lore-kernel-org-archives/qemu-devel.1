Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMf1v-0004m3-EP
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gMexq-0006AQ-P9
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 15:07:11 -0500
MIME-Version: 1.0
References: <20181108120628.29926-1-kbastian@mail.uni-paderborn.de>
	<20181108120628.29926-2-kbastian@mail.uni-paderborn.de>
In-Reply-To: <20181108120628.29926-2-kbastian@mail.uni-paderborn.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Nov 2018 12:06:36 -0800
Message-ID: <CAKmqyKNewd1mk48KuSwe-5HjS8h9p0f_3Z_rmc05WX+_rP5BHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] target/riscv: Fix FCLASS_D being
 treated as RV64 only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Nov 8, 2018 at 4:07 AM Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/translate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 18d7b6d147..5359088e24 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -1237,13 +1237,14 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          tcg_temp_free(t0);
>          break;
>
> -#if defined(TARGET_RISCV64)
>      case OPC_RISC_FMV_X_D:
>          /* also OPC_RISC_FCLASS_D */
>          switch (rm) {
> +#if defined(TARGET_RISCV64)
>          case 0: /* FMV */
>              gen_set_gpr(rd, cpu_fpr[rs1]);
>              break;
> +#endif
>          case 1:
>              t0 = tcg_temp_new();
>              gen_helper_fclass_d(t0, cpu_fpr[rs1]);
> @@ -1255,6 +1256,7 @@ static void gen_fp_arith(DisasContext *ctx, uint32_t opc, int rd,
>          }
>          break;
>
> +#if defined(TARGET_RISCV64)
>      case OPC_RISC_FMV_D_X:
>          t0 = tcg_temp_new();
>          gen_get_gpr(t0, rs1);
> --
> 2.19.1
>
>
