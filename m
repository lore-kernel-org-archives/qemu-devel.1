Received: from eggs.gnu.org ([2001:4830:134:3::10]:37868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY4B-00018P-Lb
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgY4A-0007ww-Q0
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:39 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgY4A-0007wC-Ip
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:15:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id k3-v6so7277890pgq.5
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:15:38 -0700 (PDT)
References: <20180720145647.8810-1-peter.maydell@linaro.org>
	<20180720145647.8810-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0b4983d9-e6e0-c97b-3868-f923bc13def5@linaro.org>
Date: Fri, 20 Jul 2018 09:15:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180720145647.8810-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/arm: Improve exception-taken
 logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 07/20/2018 07:56 AM, Peter Maydell wrote:
> Improve the exception-taken logging by logging in
> v7m_exception_taken() the exception we're going to take
> and whether it is secure/nonsecure.
> 
> This requires us to move logging at many callsites from after the
> call to before it, so that the logging appears in a sensible order.
> 
> (This will make tail-chaining produce more useful logs; for the
> current callers of v7m_exception_taken() we know which exception
> we're going to take, so custom log messages at the callsite sufficed;
> for tail-chaining only v7m_exception_taken() knows the exception
> number that we're going to tail-chain to.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
