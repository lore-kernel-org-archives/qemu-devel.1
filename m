Received: from eggs.gnu.org ([2001:4830:134:3::10]:51833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEBy-0004KN-FD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epEBx-0006Bo-HF
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:19:18 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:42290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epEBx-0006Ag-9P
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:19:17 -0500
Received: by mail-pl0-x234.google.com with SMTP id 31so4960033ple.9
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 06:19:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-26-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-26-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 14:18:56 +0000
Message-ID: <CAFEAcA9=_kCGqv8Ck6Ttg=wEotYdTj7VYcs_w09+3D=7k5pARA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 25/67] target/arm: Implement SVE Integer
 Wide Immediate - Predicated Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +/* Two operand predicated copy immediate with merge.  All valid immediates
> + * can fit within 17 signed bits in the simd_data field.
> + */
> +void HELPER(sve_cpy_m_b)(void *vd, void *vn, void *vg,
> +                         uint64_t mm, uint32_t desc)
> +{
> +    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
> +    uint64_t *d = vd, *n = vn;
> +    uint8_t *pg = vg;
> +
> +    mm = (mm & 0xff) * (-1ull / 0xff);

What is this expression doing? I guess from context that it's
replicating the low 8 bits of mm across the 64-bit value,
but this is too obscure to do without a comment or wrapping
it in a helper function with a useful name, I think.


Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
