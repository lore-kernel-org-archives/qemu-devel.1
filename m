Received: from eggs.gnu.org ([2001:4830:134:3::10]:36189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgug-0006ui-Ck
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:11:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqguf-00030z-G2
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:11:30 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqguf-0002zy-AD
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:11:29 -0500
Received: by mail-oi0-x244.google.com with SMTP id f186so13085718oig.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 07:11:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-59-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-59-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 15:11:08 +0000
Message-ID: <CAFEAcA8PGMrnXzdz7=DrC=qtvzognTKAp_EDVhDkkTboeKzhPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 58/67] target/arm: Implement SVE
 floating-point arithmetic with immediate
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
>  target/arm/helper-sve.h    | 56 +++++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 68 ++++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 14 +++++++++
>  4 files changed, 211 insertions(+)

> +#define float16_two  make_float16(0x4000)
> +#define float32_two  make_float32(0x40000000)
> +#define float64_two  make_float64(0x4000000000000000ULL)

I think Alex's softfloat series puts these in the common
header now ?

Anyway
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
