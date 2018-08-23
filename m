Received: from eggs.gnu.org ([2001:4830:134:3::10]:46324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstJ4-0002oX-F9
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstJ1-0004ZE-9d
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:22:02 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:44381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstJ1-0004Yb-27
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:21:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id k21-v6so3104050pff.11
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:21:58 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a28d02d-b5b0-62c1-47b7-fd1bcb4779c4@linaro.org>
Date: Thu, 23 Aug 2018 10:21:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 12/22] hw/misc/iotkit-secctl: Wire up
 registers for controlling MSCs
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
> The IoTKit does not have any Master Security Contollers itself,
> but it does provide registers in the secure privilege control
> block which allow control of MSCs in the external system.
> Add support for these registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/iotkit-secctl.h | 14 +++++++
>  hw/misc/iotkit-secctl.c         | 73 +++++++++++++++++++++++++++++----
>  2 files changed, 79 insertions(+), 8 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>  
> +static bool needed_always(void *opaque)
> +{
> +    return true;
> +}

We really should either make NULL imply just this,
or export one copy from generic code.  Soon...


r~
