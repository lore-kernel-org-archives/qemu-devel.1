Received: from eggs.gnu.org ([209.51.188.92]:51970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSDE-0007nJ-MT
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSDC-0002YN-Th
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:45:39 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmSDC-0002XD-O7
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:45:38 -0500
Received: by mail-pl1-x643.google.com with SMTP id 101so1958224pld.6
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:45:37 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0c5f3a76-bba9-95de-9aa1-c33d8587e4d5@linaro.org>
Date: Wed, 23 Jan 2019 15:45:33 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/23] armv7m: Pass through
 start-powered-off CPU property
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

On 1/21/19 10:50 AM, Peter Maydell wrote:
> Expose "start-powered-off" as a property of the ARMv7M container,
> which we just pass through to the CPU object in the same way that we
> do for "init-svtor" and "idau". (We want this for the SSE-200, which
> powers up only the first CPU at reset and leaves the second powered
> down.)
> 
> As with the other CPU properties here, we can't just use alias
> properties, because the CPU QOM object is not created until armv7m
> realize time.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armv7m.h |  1 +
>  hw/arm/armv7m.c         | 10 ++++++++++
>  2 files changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
