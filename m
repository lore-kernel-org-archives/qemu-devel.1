Received: from eggs.gnu.org ([2001:4830:134:3::10]:42325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGnN7-0000Cb-4m
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGnN2-0002cC-VU
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:20:45 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGnN2-0002az-Ou
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:20:40 -0400
Received: by mail-pl0-x242.google.com with SMTP id 59-v6so1488900plc.13
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 08:20:40 -0700 (PDT)
References: <20180510140141.12120-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72c275da-00d0-9d45-9d3b-2a724e734493@linaro.org>
Date: Thu, 10 May 2018 08:20:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180510140141.12120-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: Don't set Invalid for
 float-to-int(MAXINT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

On 05/10/2018 07:01 AM, Peter Maydell wrote:
> In float-to-integer conversion, if the floating point input
> converts exactly to the largest or smallest integer that
> fits in to the result type, this is not an overflow.
> In this situation we were producing the correct result value,
> but were incorrectly setting the Invalid flag.
> For example for Arm A64, "FCVTAS w0, d0" on an input of
> 0x41dfffffffc00000 should produce 0x7fffffff and set no flags.
> 
> Fix the boundary case to take the right half of the if()
> statements.
> 
> This fixes a regression from 2.11 introduced by the softfloat
> refactoring.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: ab52f973a50
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  fpu/softfloat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
