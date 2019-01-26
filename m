Received: from eggs.gnu.org ([209.51.188.92]:37081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBqu-0003z0-Vr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBqs-0005Rx-DT
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:29:39 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:46823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBqs-0005KA-5l
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:29:38 -0500
Received: by mail-pl1-x632.google.com with SMTP id t13so5261080ply.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:29:22 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5048ae3e-bf82-ea78-afef-d1118afa6e31@linaro.org>
Date: Fri, 25 Jan 2019 16:29:18 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/23] hw/arm/armsse: Put each CPU in its
 own cluster object
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
> Create a cluster object to hold each CPU in the SSE. They are
> logically distinct and may be configured differently (for instance
> one may not have an FPU where the other does).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  2 ++
>  hw/arm/armsse.c         | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
