Received: from eggs.gnu.org ([2001:4830:134:3::10]:43641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhGu-0003TN-J5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqhGt-0007x0-Qr
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:34:28 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqhGt-0007wf-LV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:34:27 -0500
Received: by mail-ot0-x236.google.com with SMTP id w2so1574859otg.2
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:34:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-64-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:34:06 +0000
Message-ID: <CAFEAcA_+j5Fsi6eqhgnrMmExwgvORhpH3hdb=C9DH3ZLQ8VmYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 63/67] target/arm: Implement
 SVE floating-point trig multiply-add coefficient
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  4 +++
>  target/arm/sve_helper.c    | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 26 +++++++++++++++++
>  target/arm/sve.decode      |  3 ++
>  4 files changed, 103 insertions(+)

> +/* FP Trig Multiply-Add. */
> +
> +void HELPER(sve_ftmad_h)(void *vd, void *vn, void *vm, void *vs, uint32_t desc)
> +{
> +    static const float16 coeff[16] = {
> +        0x3c00, 0xb155, 0x2030, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +        0x3c00, 0xb800, 0x293a, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
> +    };

Comment that these are constants from the pseudocode, or whatever
we agreed for the earlier patch with constant tables...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
