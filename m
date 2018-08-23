Received: from eggs.gnu.org ([2001:4830:134:3::10]:36032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqXG-0001mb-Uu
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqXC-0007Kh-Nw
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:24:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqXC-0007KL-Ed
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:24:26 -0400
Received: by mail-pg1-x542.google.com with SMTP id z4-v6so2648501pgv.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:24:26 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c17853df-177a-b5b8-f8f1-8767b302c16f@linaro.org>
Date: Thu, 23 Aug 2018 07:24:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/22] hw/misc/iotkit-sysctl: Implement
 IoTKit system control element
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
> The Arm IoTKit includes a system control element which
> provides a block of read-only ID registers and a block
> of read-write control registers. Implement a minimal
> version of this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/iotkit-sysctl.h |  49 ++++++
>  hw/misc/iotkit-sysctl.c         | 261 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   2 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   7 +
>  6 files changed, 321 insertions(+)
>  create mode 100644 include/hw/misc/iotkit-sysctl.h
>  create mode 100644 hw/misc/iotkit-sysctl.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
