Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSN2p-00073B-Az
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSN2o-0005ri-Ev
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:39 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSN2o-0005rU-8y
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:39:38 -0400
Received: by mail-oi0-x242.google.com with SMTP id 188-v6so4503997oid.12
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:39:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606093101.30518-2-luc.michel@greensocs.com>
References: <20180606093101.30518-1-luc.michel@greensocs.com>
	<20180606093101.30518-2-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 14:39:17 +0100
Message-ID: <CAFEAcA_uCfgs_ciEQPtyRGJ7yBgDrSiGrS8G9qgawH9si7yhVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] intc/arm_gic: Refactor operations on
 the distributor
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
> In preparation for the virtualization extensions implementation,
> refactor the name of the functions and macros that act on the GIC
> distributor to make that fact explicit. It will be useful to
> differentiate them from the ones that will act on the virtual
> interfaces.
>
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c        | 164 ++++++++++++++++++++-------------------
>  hw/intc/arm_gic_common.c |   6 +-
>  hw/intc/arm_gic_kvm.c    |  23 +++---
>  hw/intc/gic_internal.h   |  51 ++++++------
>  4 files changed, 127 insertions(+), 117 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
