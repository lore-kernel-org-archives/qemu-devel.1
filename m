Received: from eggs.gnu.org ([2001:4830:134:3::10]:38052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqb9-0006NT-Li
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqb6-000202-8Z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:28:31 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqb5-0001zf-Tl
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:28:28 -0400
Received: by mail-pg1-x544.google.com with SMTP id z4-v6so2655549pgv.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:28:27 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <765f30ea-a930-bc6d-d070-3593a2e30e10@linaro.org>
Date: Thu, 23 Aug 2018 07:28:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/22] hw/misc/iotkit-sysinfo: Implement
 IoTKit system information block
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
> Implement the IoTKit system control element's system information
> block; this is just a pair of read-only version/config registers,
> plus the usual PID/CID ID registers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs            |   1 +
>  include/hw/misc/iotkit-sysinfo.h |  37 +++++++++
>  hw/misc/iotkit-sysinfo.c         | 128 +++++++++++++++++++++++++++++++
>  MAINTAINERS                      |   2 +
>  default-configs/arm-softmmu.mak  |   1 +
>  5 files changed, 169 insertions(+)
>  create mode 100644 include/hw/misc/iotkit-sysinfo.h
>  create mode 100644 hw/misc/iotkit-sysinfo.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
