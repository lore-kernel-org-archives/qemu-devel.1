Received: from eggs.gnu.org ([2001:4830:134:3::10]:34143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNi9-0002on-0o
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epNi3-0002YC-Lf
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:29:09 -0500
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:32849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epNi3-0002Wh-F5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 19:29:03 -0500
Received: by mail-pf0-x235.google.com with SMTP id q13so4179797pff.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:29:03 -0800 (PST)
References: <20180223153636.29809-1-alex.bennee@linaro.org>
	<20180223153636.29809-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1bebcc59-0987-b204-41af-0b87172e0751@linaro.org>
Date: Fri, 23 Feb 2018 16:28:59 -0800
MIME-Version: 1.0
In-Reply-To: <20180223153636.29809-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 21/31] arm/translate-a64: add FP16
 FNEG/FABS to simd_two_reg_misc_fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 02/23/2018 07:36 AM, Alex Bennée wrote:
> Neither of these operations alter the floating point status registers
> so we can do a pure bitwise operation, either squashing any sign
> bit (ABS) or inverting it (NEG).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - fixup re-base conflicts
>   - make both operations pure bitwise TCG
> ---
>  target/arm/translate-a64.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
