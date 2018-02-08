Received: from eggs.gnu.org ([2001:4830:134:3::10]:47126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuTV-00070m-8P
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejuTQ-00065V-AT
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:15:25 -0500
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:39573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejuTQ-00065H-5F
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:15:20 -0500
Received: by mail-it0-x232.google.com with SMTP id c80so8303443itb.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 14:15:20 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-18-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05283e69-89b3-2379-84a6-b329419a5f05@linaro.org>
Date: Thu, 8 Feb 2018 14:15:16 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 17/32] arm/translate-a64: initial decode
 for simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> @@ -11472,6 +11512,8 @@ static void disas_data_proc_simd(DisasContext *s, uint32_t insn)
>      if (fn) {
>          fn(s, insn);
>      } else {
> +        /* fprintf(stderr, "%s: failed to find %#4x @ %#" PRIx64 "\n", */
> +        /*         __func__, insn, s->pc); */
>          unallocated_encoding(s);

Prolly wanna drop this.  ;-)  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
