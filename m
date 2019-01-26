Received: from eggs.gnu.org ([209.51.188.92]:39238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBX4-0007di-Rq
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBX1-00070M-Gb
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:09:09 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBWz-0006yE-FU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:09:07 -0500
Received: by mail-pg1-x542.google.com with SMTP id z10so4841926pgp.7
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:09:05 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ead5f94-49bb-ac82-6d21-ae13e7bc9fb9@linaro.org>
Date: Fri, 25 Jan 2019 16:09:01 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/23] hw/arm/armsse: Make SRAM bank size
 configurable
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
> For the IoTKit the SRAM bank size is always 32K (15 bits); for the
> SSE-200 this is a configurable parameter, which defaults to 32K but
> can be changed when it is built into a particular SoC. For instance
> the Musca-B1 board sets it to 128K (17 bits).
> 
> Make the bank size a QOM property. We follow the SSE-200 hardware in
> naming the parameter SRAM_ADDR_WIDTH, which specifies the number of
> address bits of a single SRAM bank.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  1 +
>  hw/arm/armsse.c         | 18 ++++++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
