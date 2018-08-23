Received: from eggs.gnu.org ([2001:4830:134:3::10]:44869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstG0-0007rn-7Z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstFw-0002WV-Pb
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:18:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:32892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstFw-0002Vp-DG
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:18:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id t14-v6so2951233pgf.0
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:18:48 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b704614-7648-4eac-4031-1d9369edcdf4@linaro.org>
Date: Thu, 23 Aug 2018 10:18:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/22] hw/misc/tz-msc: Model TrustZone
 Master Security Controller
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
> Implement a model of the TrustZone Master Securtiy Controller,
> as documented in the Arm CoreLink SIE-200 System IP for
> Embedded TRM  (DDI0571G):
>   https://developer.arm.com/products/architecture/m-profile/docs/ddi0571/g
> 
> The MSC is intended to sit in front of a device which can
> be a bus master (eg a DMA controller) and programmably gate
> its transactions. This allows a bus-mastering device to be
> controlled by non-secure code but still restricted from
> making accesses to addresses which are secure-only.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/tz-msc.h        |  79 ++++++++
>  hw/misc/tz-msc.c                | 308 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   2 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   9 +
>  6 files changed, 400 insertions(+)
>  create mode 100644 include/hw/misc/tz-msc.h
>  create mode 100644 hw/misc/tz-msc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
