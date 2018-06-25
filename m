Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXThp-0006rd-H0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTho-0007ZK-MO
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:47:05 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTho-0007Z9-GB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:47:04 -0400
Received: by mail-ot0-x244.google.com with SMTP id 92-v6so15567811otw.9
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:47:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-10-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:46:43 +0100
Message-ID: <CAFEAcA-gGuY5JG+DmU3vrfiky0wsz2YBtUe2uYnFxL+ZrRiiSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 09/35] target/arm: Implement SVE load
 and broadcast element
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

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  5 +++
>  target/arm/sve_helper.c    | 41 +++++++++++++++++++++++++
>  target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  5 +++
>  4 files changed, 113 insertions(+)


> +/* Copy Zn into Zn, and store zero into inactive elements.  */
> +void HELPER(sve_movz_b)(void *vd, void *vn, void *vg, uint32_t desc)

Given the prototype, presumably "into Zd" ?

> +{
> +    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
> +    uint64_t *d = vd, *n = vn;
> +    uint8_t *pg = vg;
> +    for (i = 0; i < opr_sz; i += 1) {
> +        d[i] = n[i] & expand_pred_b(pg[H1(i)]);
> +    }
> +}

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
