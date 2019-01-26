Received: from eggs.gnu.org ([209.51.188.92]:46313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBxj-0006EH-K7
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBxi-0002QD-SW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:36:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBxi-0002Oo-EN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:36:42 -0500
Received: by mail-pg1-x544.google.com with SMTP id y4so4850591pgc.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:36:40 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <12ccda0a-75cf-47f5-dbd0-07eef85a189f@linaro.org>
Date: Fri, 25 Jan 2019 16:36:36 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/23] hw/arm/armsse: Add
 unimplemented-device stubs for MHUs
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

On 1/21/19 10:51 AM, Peter Maydell wrote:
> The SSE-200 has two Message Handling Units (MHUs), which sit behind
> the APB PPC0. Wire up some unimplemented-device stubs for these,
> since we don't yet implement a real model of this device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  3 +++
>  hw/arm/armsse.c         | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
