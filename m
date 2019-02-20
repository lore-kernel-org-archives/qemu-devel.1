Received: from eggs.gnu.org ([209.51.188.92]:56411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWFB-0002Zf-TK
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWF9-0005ie-MT
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:05:17 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWF8-0005hf-2i
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:05:14 -0500
Received: by mail-pg1-x543.google.com with SMTP id m2so9988585pgl.5
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:05:13 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7ca763d-e441-c1fb-6b66-b70155258ad2@linaro.org>
Date: Wed, 20 Feb 2019 10:05:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] hw/arm/armsse: Wire up the MHUs
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

On 2/19/19 4:58 AM, Peter Maydell wrote:
> Create and connect the MHUs in the SSE-200.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  3 ++-
>  hw/arm/armsse.c         | 40 ++++++++++++++++++++++++++++++----------
>  2 files changed, 32 insertions(+), 11 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        /*
> +         * An SSE-200 with only one CPU should have only one MHU created,
> +         * with the region where the second MHU usually is being RAZ/WI.
> +         * We don't implement that SSE-200 config; if we want to support
> +         * it then this code needs to be enhanced to handle creating the
> +         * RAZ/WI region instead of the second MHU.
> +         */
> +        assert(info->num_cpus > 1);
> +
> +        for (i = 0; i < ARRAY_SIZE(s->mhu); i++) {

Nit: x > 1 is probably better as x == ARRAY_SIZE(s->mhu).


r~
