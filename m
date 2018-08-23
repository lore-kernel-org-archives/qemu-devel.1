Received: from eggs.gnu.org ([2001:4830:134:3::10]:49246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstP1-0001Q7-Lz
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstOw-00019M-FK
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:10 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstOt-00016K-V8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:28:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id z4-v6so2962494pgv.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:28:03 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07b40f59-894b-a38f-89c0-81f44d23d26b@linaro.org>
Date: Thu, 23 Aug 2018 10:27:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/22] hw/arm/mps2-tz: Create PL081s and
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
> The AN505 FPGA image includes four PL081 DMA controllers, each
> of which is gated by a Master Security Controller that allows
> the guest to prevent a non-secure DMA controller from accessing
> memory that is used by secure guest code. Create and wire
> up these devices.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2 changes:
>  - use 'sizeof(*msc)', 'sizeof(*dma)' as suggested
>    by Phillipe in code review
>  - s/init_sysbus_child/sysbus_init_child_obj/, required by
>    rebase on current master
> ---
>  hw/arm/mps2-tz.c | 100 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 93 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
