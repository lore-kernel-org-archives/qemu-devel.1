Received: from eggs.gnu.org ([2001:4830:134:3::10]:41330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSN32-0007Dt-IJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSN31-0005w8-QB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:52 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSN31-0005vi-LI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:51 -0400
Received: by mail-oi0-x243.google.com with SMTP id e8-v6so17901729oii.2
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606093101.30518-3-luc.michel@greensocs.com>
References: <20180606093101.30518-1-luc.michel@greensocs.com>
	<20180606093101.30518-3-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 14:39:30 +0100
Message-ID: <CAFEAcA_77paTb9e-H-OqVS_3JTFgufxhTj6dn3Gr82xk6ZygaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/6] intc/arm_gic: Remove some dead code
 and put some functions static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 6 June 2018 at 10:30,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
>
> Some functions are now only used in arm_gic.c, put them static. Some of
> them where only used by the NVIC implementation and are not used
> anymore, so remove them.
>
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c      | 23 ++---------------------
>  hw/intc/gic_internal.h |  4 ----
>  2 files changed, 2 insertions(+), 25 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
