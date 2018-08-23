Received: from eggs.gnu.org ([2001:4830:134:3::10]:32889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqQx-0004Ki-S7
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqQt-0003zH-MN
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:17:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqQt-0003ys-CK
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:17:55 -0400
Received: by mail-pf1-x441.google.com with SMTP id h79-v6so1892995pfk.8
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:17:55 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56bb43b1-765d-0fe4-2ae4-26cab7e32efd@linaro.org>
Date: Thu, 23 Aug 2018 07:17:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/22] hw/arm/iotkit: Wire up the watchdogs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:11 AM, Peter Maydell wrote:
> The IoTKit includes three different instances of the
> CMSDK APB watchdog; create and wire them up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/iotkit.h |  6 +++++
>  hw/arm/iotkit.c         | 58 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
