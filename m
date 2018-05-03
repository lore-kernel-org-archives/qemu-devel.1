Received: from eggs.gnu.org ([2001:4830:134:3::10]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM3i-0002e3-4H
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEM3h-0005lL-6T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:46:38 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:33513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEM3g-0005k9-Vf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:46:37 -0400
Received: by mail-lf0-x241.google.com with SMTP id m18-v6so28143428lfb.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 14:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-20-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-20-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 21:46:09 +0000
Message-ID: <CAKmqyKP6SqH93BB7uAiJE-astDV3EUwD=S7AHUQ62ToC0oTQ2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 19/29] target-microblaze: dec_msr: Fix
 MTS to FSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Iglesias <edgar.iglesias@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>

On Thu, May 3, 2018 at 2:38 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Fix moves to FSR. Not only bit 31 is accessible.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 05449fb941..97d7782bc6 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -533,11 +533,9 @@ static void dec_msr(DisasContext *dc)
>                   break;
>               case SR_EAR:
>               case SR_ESR:
> +            case SR_FSR:
>                   tcg_gen_mov_i32(cpu_SR[sr], cpu_R[dc->ra]);
>                   break;
> -            case 0x7:
> -                tcg_gen_andi_i32(cpu_SR[SR_FSR], cpu_R[dc->ra], 31);
> -                break;
>               case 0x800:
>                   tcg_gen_st_i32(cpu_R[dc->ra],
>                                  cpu_env, offsetof(CPUMBState, slr));
> --
> 2.14.1
