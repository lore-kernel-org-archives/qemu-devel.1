Received: from eggs.gnu.org ([2001:4830:134:3::10]:38293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKSZ-0006AQ-M4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKSY-0006JE-Rb
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:11 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:42439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKSY-0006IL-Ky
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:10 -0400
Received: by mail-lf0-x243.google.com with SMTP id u21-v6so27778845lfu.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-3-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:03:43 +0000
Message-ID: <CAKmqyKNM+yH7GmxN_+y74F_T2LKbxnmhpGGpHJuenQTMhQsq1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 02/29] target-microblaze: dec_store: Use
 bool instead of unsigned int
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

On Thu, May 3, 2018 at 2:22 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Use bool instead of unsigned int to represent flags.
> Also, use extract32 instead of open coding the bit extract.

> No functional change.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/translate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 33f21aa5b7..6fe679ca6d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1027,14 +1027,15 @@ static void dec_store(DisasContext *dc)
>   {
>       TCGv t, *addr, swx_addr;
>       TCGLabel *swx_skip = NULL;
> -    unsigned int size, rev = 0, ex = 0;
> +    unsigned int size;
> +    bool rev = false, ex = false;
>       TCGMemOp mop;

>       mop = dc->opcode & 3;
>       size = 1 << mop;
>       if (!dc->type_b) {
> -        rev = (dc->ir >> 9) & 1;
> -        ex = (dc->ir >> 10) & 1;
> +        rev = extract32(dc->ir, 9, 1);
> +        ex = extract32(dc->ir, 10, 1);
>       }
>       mop |= MO_TE;
>       if (rev) {
> --
> 2.14.1
