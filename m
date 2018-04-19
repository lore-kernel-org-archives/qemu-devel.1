Received: from eggs.gnu.org ([2001:4830:134:3::10]:52238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9DFA-0007IM-MO
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1f9DF9-0008Mh-QI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:12 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1f9DF9-0008Ki-IH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:21:11 -0400
Received: by mail-lf0-x243.google.com with SMTP id r125-v6so1298514lfe.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419112131.16932-3-edgar.iglesias@gmail.com>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Apr 2018 10:20:38 -0700
Message-ID: <CAKmqyKOY1bYwE+UP1K6Jm-XscDYLtaohq3DSXhHeE-PTEgEKxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/5] target-microblaze: Fix trap checks
 for FPU insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>

On Thu, Apr 19, 2018 at 4:21 AM, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Fix trap checks for FPU insns when extended FPU insns are enabled.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index df62563815..5f9efcdd11 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1406,7 +1406,7 @@ static void dec_fpu(DisasContext *dc)
>
>      if ((dc->tb_flags & MSR_EE_FLAG)
>            && (dc->cpu->env.pvr.regs[2] & PVR2_ILL_OPCODE_EXC_MASK)
> -          && (dc->cpu->cfg.use_fpu != 1)) {
> +          && !dc->cpu->cfg.use_fpu) {
>          tcg_gen_movi_tl(cpu_SR[SR_ESR], ESR_EC_ILLEGAL_OP);
>          t_gen_raise_exception(dc, EXCP_HW_EXCP);
>          return;
> --
> 2.14.1
>
>
