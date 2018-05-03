Received: from eggs.gnu.org ([2001:4830:134:3::10]:38873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKTJ-0006ri-J7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fEKTI-00073k-L2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:57 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:39872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fEKTI-00072l-DY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:04:56 -0400
Received: by mail-lf0-x242.google.com with SMTP id j193-v6so27778726lfg.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 13:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180503091922.28733-1-edgar.iglesias@gmail.com>
	<20180503091922.28733-4-edgar.iglesias@gmail.com>
In-Reply-To: <20180503091922.28733-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 03 May 2018 20:04:29 +0000
Message-ID: <CAKmqyKNAUk8J8vQqkBsMPVxJkGkjOV+7OcfTp+3=Erw87cfQxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 03/29] target-microblaze:
 compute_ldst_addr: Use bool instead of int
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

> Use bool instead of int to represent flags.
> No functional change.

> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   target/microblaze/translate.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 6fe679ca6d..9232b42a8a 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -845,13 +845,13 @@ static void dec_imm(DisasContext *dc)

>   static inline TCGv *compute_ldst_addr(DisasContext *dc, TCGv *t)
>   {
> -    unsigned int extimm = dc->tb_flags & IMM_FLAG;
> -    /* Should be set to one if r1 is used by loadstores.  */
> -    int stackprot = 0;
> +    bool extimm = dc->tb_flags & IMM_FLAG;
> +    /* Should be set to true if r1 is used by loadstores.  */
> +    bool stackprot = false;

>       /* All load/stores use ra.  */
>       if (dc->ra == 1 && dc->cpu->cfg.stackprot) {
> -        stackprot = 1;
> +        stackprot = true;
>       }

>       /* Treat the common cases first.  */
> @@ -864,7 +864,7 @@ static inline TCGv *compute_ldst_addr(DisasContext
*dc, TCGv *t)
>           }

>           if (dc->rb == 1 && dc->cpu->cfg.stackprot) {
> -            stackprot = 1;
> +            stackprot = true;
>           }

>           *t = tcg_temp_new();
> --
> 2.14.1
