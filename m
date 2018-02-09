Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDOI-0001Ck-9U
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:27:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDOD-0006D5-Kv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:27:18 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekDOD-0006Cd-Fy
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:27:13 -0500
Received: by mail-it0-x231.google.com with SMTP id e1so11764239ita.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 10:27:13 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-31-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf5584fe-3da6-f4c5-560f-851e2b8f64d5@linaro.org>
Date: Fri, 9 Feb 2018 10:27:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 30/32] arm/translate-a64: add all FP16
 ops in simd_scalar_pairwise
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
>      case 0x2f: /* FMINP */
> -        /* FP op, size[0] is 32 or 64 bit */
> +        /* FP op, size[0] is 32 or 64 bit*/

If you're going to frob the whitespace, you might as well update to include the
fact that it can be 16 bit too...

>          if (!u) {
> -            unallocated_encoding(s);
> -            return;
> +            if (!arm_dc_feature(s, ARM_FEATURE_V8_FP16)) {
> +                unallocated_encoding(s);
> +                return;
> +            } else {
> +                size = MO_16;
> +            }
> +        } else {
> +            size = extract32(size, 0, 1) ? MO_64 : MO_32;
>          }

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
