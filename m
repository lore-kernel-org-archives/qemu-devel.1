Received: from eggs.gnu.org ([209.51.188.92]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWB2-0007o8-Ph
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWAz-0004FI-E9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:00:59 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWAv-0004CR-2H
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:00:53 -0500
Received: by mail-pl1-x641.google.com with SMTP id q3so5224360pll.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:00:51 -0800 (PST)
References: <20190219125808.25174-1-peter.maydell@linaro.org>
	<20190219125808.25174-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8615f5d6-6080-e560-91c3-8afa2a5606ce@linaro.org>
Date: Wed, 20 Feb 2019 10:00:46 -0800
MIME-Version: 1.0
In-Reply-To: <20190219125808.25174-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/8] hw/misc/armsse-mhu.c: Model the
 SSE-200 Message Handling Unit
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

On 2/19/19 4:58 AM, Peter Maydell wrote:
> Implement a model of the Message Handling Unit (MHU) found in
> the Arm SSE-200. This is a simple device which just contains
> some registers which allow the two cores of the SSE-200
> to raise interrupts on each other.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/armsse-mhu.h    |  44 +++++++
>  hw/misc/armsse-mhu.c            | 198 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   2 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   4 +
>  6 files changed, 250 insertions(+)
>  create mode 100644 include/hw/misc/armsse-mhu.h
>  create mode 100644 hw/misc/armsse-mhu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
