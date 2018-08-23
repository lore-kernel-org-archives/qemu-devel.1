Received: from eggs.gnu.org ([2001:4830:134:3::10]:33308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqRw-0004zk-4M
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqRr-0004ZP-Se
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:19:00 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqRr-0004Yu-Jt
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:18:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id m4-v6so2106688pgv.12
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:18:55 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea5e417a-c7d1-ec50-ac75-ed497451ed6b@linaro.org>
Date: Thu, 23 Aug 2018 07:18:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/22] hw/arm/iotkit: Wire up the S32KTIMER
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
> The IoTKit has a CMSDK timer device that runs on the S32KCLK.
> Create this and wire it up.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/iotkit.h | 2 +-
>  hw/arm/iotkit.c         | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
