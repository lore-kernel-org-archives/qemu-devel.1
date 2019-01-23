Received: from eggs.gnu.org ([209.51.188.92]:51681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSBl-0006iR-Sb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSBl-0001FX-0u
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:09 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:37269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmSBk-0001EM-Q8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:08 -0500
Received: by mail-pg1-x52a.google.com with SMTP id c25so1803895pgb.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:44:08 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <125e6614-4126-71eb-0d88-78097cb3df7d@linaro.org>
Date: Wed, 23 Jan 2019 15:44:04 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/23] armv7m: Don't assume the NVIC's CPU
 is CPU 0
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
> Currently the ARMv7M NVIC object's realize method assumes that the
> CPU the NVIC is attached to is CPU 0, because it thinks there can
> only ever be one CPU in the system. To allow a dual-Cortex-M33
> setup we need to remove this assumption; instead the armv7m
> wrapper object tells the NVIC its CPU, in the same way that it
> already tells the CPU what the NVIC is.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armv7m.c       | 6 ++++--
>  hw/intc/armv7m_nvic.c | 3 +--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
