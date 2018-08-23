Received: from eggs.gnu.org ([2001:4830:134:3::10]:46704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstKE-00042a-Cb
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstKB-0005Vi-1b
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:23:14 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstKA-0005Uv-QM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:23:10 -0400
Received: by mail-pg1-x541.google.com with SMTP id s15-v6so2940440pgv.8
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:23:10 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3d7fefa3-009b-ccb5-8091-a983ce9ff3f4@linaro.org>
Date: Thu, 23 Aug 2018 10:23:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 13/22] hw/arm/iotkit: Wire up the lines for
 MSCs
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
> The IoTKit doesn't have any MSCs itself but it does need
> some wiring to connect the external signals from MSCs
> in the outer board model up to the registers and the
> NVIC IRQ line.
> 
> We also need to expose a MemoryRegion corresponding to
> the AHB bus, so that MSCs in the outer board model can
> use that as their downstream port. (In the FPGA this is
> the "AHB Slave Expansion" ports shown in the block
> diagram in the AN505 documentation.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/iotkit.h |  8 ++++++++
>  hw/arm/iotkit.c         | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
