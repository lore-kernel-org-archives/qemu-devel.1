Received: from eggs.gnu.org ([209.51.188.92]:34978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWXu-0000iN-23
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWXt-0000wq-Bl
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:24:38 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWXr-0000sp-5o
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:24:37 -0500
Received: by mail-pl1-x643.google.com with SMTP id bj4so12632114plb.7
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:24:27 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad033d80-e4e9-718d-1e43-42827dbed99d@linaro.org>
Date: Wed, 20 Feb 2019 10:24:23 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/8] hw/arm/iotkit-sysctl: Add SSE-200
 registers
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
> The SYSCTL block in the SSE-200 has some extra registers that
> are not present in the IoTKit version. Add these registers
> (as reads-as-written stubs), enabled by a new QOM property.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/iotkit-sysctl.h |  20 +++
>  hw/arm/armsse.c                 |   2 +
>  hw/misc/iotkit-sysctl.c         | 245 +++++++++++++++++++++++++++++++-
>  3 files changed, 262 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
