Received: from eggs.gnu.org ([209.51.188.92]:35963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBUu-0006kS-8O
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnBUm-00058m-VN
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:06:52 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:33961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnBUl-00054h-TB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 19:06:48 -0500
Received: by mail-pg1-x52d.google.com with SMTP id j10so4852875pga.1
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 16:06:46 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0cd3160-ec07-dd74-5975-8a84f855cef6@linaro.org>
Date: Fri, 25 Jan 2019 16:06:43 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/23] hw/arm/armsse: Make number of SRAM
 banks parameterised
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
> The SSE-200 has four banks of SRAM, each with its own
> Memory Protection Controller, where the IoTKit has only one.
> Make the number of SRAM banks a field in ARMSSEInfo.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  9 +++--
>  hw/arm/armsse.c         | 78 ++++++++++++++++++++++++++---------------
>  2 files changed, 56 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
