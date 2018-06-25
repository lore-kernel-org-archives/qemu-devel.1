Received: from eggs.gnu.org ([2001:4830:134:3::10]:51185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPAm-0003o4-3O
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPAl-0007qN-9r
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:56:40 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXPAl-0007pf-2m
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:56:39 -0400
Received: by mail-oi0-x243.google.com with SMTP id l22-v6so12040088oib.4
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 03:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529660880-30376-1-git-send-email-sai.pavan.boddu@xilinx.com>
References: <1529660880-30376-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 11:56:18 +0100
Message-ID: <CAFEAcA-Wt4wVcriayGw-xCaWJskM01X=2z5GBoSTiFiRPtHvcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] xilinx_spips: Make dma transactions as
 per dma_burst_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, KONRAD Frederic <frederic.konrad@adacore.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 22 June 2018 at 10:47, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com> wrote:
> From: Sai Pavan Boddu <saipava@xilinx.com>
>
> Qspi dma has a burst length of 64 bytes, So limit the transactions w.r.t
> dma-burst-size property.
>
> Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
> Changes for V2:
>    Remove dynamic allocation of dma_buf and limit burst size to 2k
> Changes for V3:
>    Instead of proceeding with max burst size, report user the error.
> Changes for V4:
>    move dma_buf to the bottom of XlnxZynqMPQSPIPS
>
>  hw/ssi/xilinx_spips.c         | 23 ++++++++++++++++++++---
>  include/hw/ssi/xilinx_spips.h |  5 ++++-
>  2 files changed, 24 insertions(+), 4 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
