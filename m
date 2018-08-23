Received: from eggs.gnu.org ([2001:4830:134:3::10]:56155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstaU-0007mb-KU
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstaP-0001wM-JC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:40:02 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstaO-0001um-Uz
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:39:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id m4-v6so2450478pgv.12
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:39:56 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-22-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fa98dccc-7dbe-f57b-7c9f-eab2d452ff28@linaro.org>
Date: Thu, 23 Aug 2018 10:39:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/22] hw/arm/mps2-tz: Instantiate SPI
 controllers
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
> The SPI controllers in the MPS2 AN505 board are PL022s.
> We have a model of the PL022, so create these devices.
> 
> We don't currently model the LCD controller that sits behind
> one of the PL022s; the others are intended to control devices
> that sit on the FPGA's general purpose SPI connector or
> "shield" expansion connectors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2-tz.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
