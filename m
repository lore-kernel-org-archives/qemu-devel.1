Received: from eggs.gnu.org ([2001:4830:134:3::10]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmKI-0004uD-VQ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:58:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmKE-0005p1-3K
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:58:19 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmKD-0005oM-Sw
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:58:14 -0500
Received: by mail-pl0-x242.google.com with SMTP id y8-v6so112519pll.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:58:13 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a91e29e-8109-1cce-2b19-f70e1f20fdb3@linaro.org>
Date: Tue, 27 Feb 2018 12:58:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/19] hw/core/split-irq: Device that
 splits IRQ lines
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
> In some board or SoC models it is necessary to split a qemu_irq line
> so that one input can feed multiple outputs.  We currently have
> qemu_irq_split() for this, but that has several deficiencies:
>  * it can only handle splitting a line into two
>  * it unavoidably leaks memory, so it can't be used
>    in a device that can be deleted
> 
> Implement a qdev device that encapsulates splitting of IRQs, with a
> configurable number of outputs.  (This is in some ways the inverse of
> the TYPE_OR_IRQ device.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/core/Makefile.objs       |  1 +
>  include/hw/core/split-irq.h | 57 +++++++++++++++++++++++++++++
>  include/hw/irq.h            |  4 +-
>  hw/core/split-irq.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 150 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/core/split-irq.h
>  create mode 100644 hw/core/split-irq.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
