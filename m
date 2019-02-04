Received: from eggs.gnu.org ([209.51.188.92]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqcjs-00074F-N4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqccM-0000E6-W0
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:40:52 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqccM-0000AS-LZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:40:50 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so12334870ota.12
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20190128223118.5255-1-richard.henderson@linaro.org>
	<20190128223118.5255-5-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 11:40:34 +0000
Message-ID: <CAFEAcA_bSCTUoVKK2YGLr_CXtbh5LmAyxfYzQpKMMzce=+M5KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/12] exec: Add target-specific tlb
 bits to MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 28 Jan 2019 at 22:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These bits can be used to cache target-specific data in cputlb
> read from the page tables.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/memattrs.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d4a1642098..d4a3477d71 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -37,6 +37,16 @@ typedef struct MemTxAttrs {
>      unsigned int user:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +    /*
> +     * The following are target-specific page-table bits.  These are not
> +     * related to actual memory transactions at all.  However, this structure
> +     * is part of the tlb_fill interface, cached in the cputlb structure,
> +     * and has unused bits.  These fields will be read by target-specific
> +     * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
> +     */
> +    unsigned int target_tlb_bit0 : 1;
> +    unsigned int target_tlb_bit1 : 1;
> +    unsigned int target_tlb_bit2 : 1;
>  } MemTxAttrs;
>
>  /* Bus masters which don't specify any attributes will get this,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
