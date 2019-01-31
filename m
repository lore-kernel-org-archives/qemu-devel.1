Received: from eggs.gnu.org ([209.51.188.92]:59226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpL4k-00048P-N3
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpL4j-0000LV-Ug
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:44:50 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpL4g-0000Hx-2G
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:44:47 -0500
Received: by mail-pf1-x444.google.com with SMTP id c123so2171733pfb.0
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 14:44:39 -0800 (PST)
References: <20190131112240.8395-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ef2114c-fd8e-daf9-61e3-a2f4962d66c8@linaro.org>
Date: Thu, 31 Jan 2019 14:44:35 -0800
MIME-Version: 1.0
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] hw/arm/boot: Support DTB autoload for
 firmware-only boots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, Igor Mammedov <imammedo@redhat.com>, patches@linaro.org

On 1/31/19 3:22 AM, Peter Maydell wrote:
> Peter Maydell (5):
>   hw/arm/boot: Fix block comment style in arm_load_kernel()
>   hw/arm/boot: Factor out "direct kernel boot" code into its own
>     function
>   hw/arm/boot: Factor out "set up firmware boot" code
>   hw/arm/boot: Clarify why arm_setup_firmware_boot() doesn't set
>     env->boot_info
>   hw/arm/boot: Support DTB autoload for firmware-only boots
> 
>  hw/arm/boot.c | 166 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 96 insertions(+), 70 deletions(-)

Nice cleanup.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
