Received: from eggs.gnu.org ([2001:4830:134:3::10]:58798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmXa-0001wO-QB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmXW-0001sX-T3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:12:02 -0500
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:42507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmXW-0001sI-LH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:11:58 -0500
Received: by mail-pl0-x235.google.com with SMTP id 93-v6so142102plc.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:11:58 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a15143ec-080a-a9d5-c7cf-547d7d98e5fa@linaro.org>
Date: Tue, 27 Feb 2018 13:11:54 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/19] hw/misc/mps2-fpgaio: FPGA control
 block for MPS2 AN505
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> The MPS2 AN505 FPGA image includes a "FPGA control block"
> which is a small set of registers handling LEDs, buttons
> and some counters.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   1 +
>  include/hw/misc/mps2-fpgaio.h   |  43 ++++++++++
>  hw/misc/mps2-fpgaio.c           | 176 ++++++++++++++++++++++++++++++++++++++++
>  default-configs/arm-softmmu.mak |   1 +
>  hw/misc/trace-events            |   6 ++
>  5 files changed, 227 insertions(+)
>  create mode 100644 include/hw/misc/mps2-fpgaio.h
>  create mode 100644 hw/misc/mps2-fpgaio.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
