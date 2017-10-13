Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36w1-0007JA-DF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36vx-0004ix-ID
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:51:57 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:44712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36vx-0004id-BJ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:51:53 -0400
Received: by mail-pf0-x22c.google.com with SMTP id x7so11300136pfa.1
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:51:53 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60b51a65-a313-8a31-55d8-e30473ce31e5@linaro.org>
Date: Fri, 13 Oct 2017 13:51:50 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 07/30] fpu/softfloat: implement
 float16_abs helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> This will be required when expanding the MINMAX() macro for 16
> bit/half-precision operations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/fpu/softfloat.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +    return make_float16(float16_val(a) & 0x7fff);
> +}
>  /*----------------------------------------------------------------------------

Watch the spacing.


r~
