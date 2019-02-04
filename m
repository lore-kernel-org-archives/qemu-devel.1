Received: from eggs.gnu.org ([209.51.188.92]:46077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqc31-0007In-GM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqc30-0006AG-NA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:04:19 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqc30-00069W-ER
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:04:18 -0500
Received: by mail-wr1-x441.google.com with SMTP id s12so13902316wrt.4
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 03:04:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190204052712.30833-1-richard.henderson@linaro.org>
	<20190204052712.30833-3-richard.henderson@linaro.org>
Message-ID: <a4109cd7-184e-de1f-7d2a-0576eba1e8ed@linaro.org>
Date: Mon, 4 Feb 2019 11:04:14 +0000
MIME-Version: 1.0
In-Reply-To: <20190204052712.30833-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm: Restructure
 disas_fp_int_conv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

On 2/4/19 5:27 AM, Richard Henderson wrote:
> +    default:
> +        switch (sf << 6 | type << 5 | rmode << 3 | opcode) {
> +        case 0b01100110: /* FMOV half <-> 32-bit int */
> +        case 0b01100111:
> +        case 0b11100110: /* FMOV half <-> 64-bit int */
> +        case 0b11100111:
> +            if (!dc_isar_feature(aa64_fp16, s)) {
> +                goto do_unallocated;
> +            }
> +            /* fallthru */
> +        case 0b00000110: /* FMOV 32-bit */
> +        case 0b00000111:
> +        case 0b10100110: /* FMOV 64-bit */
> +        case 0b10100111:
> +        case 0b11001110: /* FMOV top half of 128-bit */
> +        case 0b11001111:

There's an error in here that a full risu run has diagnosed.


r~
