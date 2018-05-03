Received: from eggs.gnu.org ([2001:4830:134:3::10]:37787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKRs-0005gT-LS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKRr-0005de-KZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:03:28 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:42434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKRr-0005ch-D2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:03:27 -0400
Received: by mail-lf0-x244.google.com with SMTP id u21-v6so27776050lfu.9
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-2-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:03:00 +0000
Message-ID: <CAKmqyKPscC5atJwWQAbG0reoevzjfoYG-55LHqgX6vfsqd7gig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 01/29] target-microblaze: dec_load: Use
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

On Thu, May 3, 2018 at 2:19 AM Edgar E. Iglesias <edgar.iglesias@gmail.com>
wrote:

> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

> Use bool instead of unsigned int to represent flags.
> No functional change.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/translate.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 100883e2cc..33f21aa5b7 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -897,14 +897,15 @@ static inline TCGv *compute_ldst_addr(DisasContext
*dc, TCGv *t)
>   static void dec_load(DisasContext *dc)
>   {
>       TCGv t, v, *addr;
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
