Received: from eggs.gnu.org ([2001:4830:134:3::10]:39715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHGd-00011Z-Ra
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqHGb-0001Ww-Uz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:20:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqHGb-0001Uv-K8
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:20:41 -0400
Received: by mail-oi0-x242.google.com with SMTP id j205-v6so7615816oib.4
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 05:20:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730162458.23186-1-peter.maydell@linaro.org>
References: <20180730162458.23186-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 13:20:17 +0100
Message-ID: <CAFEAcA-O=zofLVPmH9V5JnAw-JY4aZe4dYeW1MMaAdsd9hSFXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] mps2: Implement FPGAIO counters and
 dual-timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>

Ping? Patch 2 has been reviewed but the rest are still waiting.

thanks
-- PMM

On 30 July 2018 at 17:24, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds some missing timer and counter devices
> to the MPS2 boards:
>
>  * the MPS2 "fpgaio" register bank includes some registers
>    which provide various kinds of free-running counter
>  * the boards have an instance fo the CMSDK "dual timer module"
>
> Together these are sufficient for QEMU's mps2-an505
> emulation to pass the "timer test" subsection of the
> self-test program which can be found (behind a clickthrough
> EULA) in the Cortex-M33_IoT_kit_2_0.zip at:
>  https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/download-fpga-images
>
> The dual-timer patch ended up a bit big; I can try to split
> that up if people would prefer that for review.
>
> thanks
> -- PMM
>
> Peter Maydell (5):
>   hw/misc/mps2-fpgaio: Implement 1Hz and 100Hz counters
>   hw/misc/mps2-fpgaio: Implement PSCNTR and COUNTER
>   hw/timer/cmsdk-apb-dualtimer: Implement CMSDK dual timer module
>   hw/arm/iotkit: Wire up the dualtimer
>   hw/arm/mps2: Wire up dual-timer in mps2-an385 and mps2-an511
>
>  hw/timer/Makefile.objs                 |   1 +
>  include/hw/arm/iotkit.h                |   3 +-
>  include/hw/misc/mps2-fpgaio.h          |  10 +
>  include/hw/timer/cmsdk-apb-dualtimer.h |  72 ++++
>  hw/arm/iotkit.c                        |   8 +-
>  hw/arm/mps2.c                          |  11 +
>  hw/misc/mps2-fpgaio.c                  | 146 ++++++-
>  hw/timer/cmsdk-apb-dualtimer.c         | 515 +++++++++++++++++++++++++
>  MAINTAINERS                            |   2 +
>  default-configs/arm-softmmu.mak        |   1 +
>  hw/timer/trace-events                  |   5 +
>  11 files changed, 767 insertions(+), 7 deletions(-)
>  create mode 100644 include/hw/timer/cmsdk-apb-dualtimer.h
>  create mode 100644 hw/timer/cmsdk-apb-dualtimer.c
