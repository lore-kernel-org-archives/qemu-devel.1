Received: from eggs.gnu.org ([209.51.188.92]:43584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9kY-0001ul-Ao
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9kV-0000kO-FE
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:05 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9kR-0000LL-HP
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:00 -0500
Received: by mail-pf1-x444.google.com with SMTP id g62so8197275pfd.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:26:50 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e212532-c18e-6476-eb53-5eaeef8bcf0a@linaro.org>
Date: Mon, 28 Jan 2019 08:26:46 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/23] hw/misc/armsse-cpuid: Implement
 SSE-200 CPU_IDENTITY register block
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
> The SSE-200 has a CPU_IDENTITY register block, which is a set of
> read-only registers. As well as the usual PID/CID registers, there
> is a single CPUID register which indicates whether the CPU is CPU 0
> or CPU 1. Implement a model of this register block.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/armsse-cpuid.h  |  41 ++++++++++
>  hw/misc/armsse-cpuid.c          | 134 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   2 +
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   4 +
>  6 files changed, 183 insertions(+)
>  create mode 100644 include/hw/misc/armsse-cpuid.h
>  create mode 100644 hw/misc/armsse-cpuid.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
