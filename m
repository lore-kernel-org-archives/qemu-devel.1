Received: from eggs.gnu.org ([2001:4830:134:3::10]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbsz-0000bc-FN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdbsy-0003yL-On
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:43:57 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdbsy-0003xy-J5
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:43:56 -0400
Received: by mail-oi0-x244.google.com with SMTP id i12-v6so55856108oik.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:43:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-16-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-16-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 14:43:35 +0100
Message-ID: <CAFEAcA8H5Gx3C2Zx=AtyjY-FHZOtBceGmpHiJqCFiNi802oD4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 15/20] intc/arm_gic: Implement the
 virtual interface registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> Implement the read and write functions for the virtual interface of the
> virtualization extensions in the GICv2.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---
>  hw/intc/arm_gic.c | 161 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 159 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(I was going to ask for tracepoints and a call to gic_update_virt()
but I see they are in later patches.)

thanks
-- PMM
