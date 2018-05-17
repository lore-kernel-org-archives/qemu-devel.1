Received: from eggs.gnu.org ([2001:4830:134:3::10]:51344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKz2-00074h-GU
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKz1-0007Pu-KD
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:24 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJKz1-0007PT-F3
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:23 -0400
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so5532026otg.10
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:38:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503214201.29082-1-frasse.iglesias@gmail.com>
References: <20180503214201.29082-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:38:02 +0100
Message-ID: <CAFEAcA_NCRE8sgd0XxtKxce-f0hbfyCZOFgvKXDmUgF94cA2sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] xlnx-zynqmp: Add emulation of the
 ZynqMP GDMA and ADMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Alistair Francis <alistair23@gmail.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 3 May 2018 at 22:41, Francisco Iglesias <frasse.iglesias@gmail.com> wrote:
> Hi,
>
> The ZynqMP Soc contains two separate instances of a generic DMA, one located in
> the FPD (full power domain) called GDMA and a second one located in the LPD
> (low power domain) called ADMA. This patch series attempts to add emulation
> support for these two DMAs on the ZynqMP board. The first patch in the series
> adds a model of the ZynqMP generic DMA (the ZDMA). The second patch in the
> series connects the two instances of the ZDMA, the GDMA and the ADMA, to the
> ZynqMP board.
>
> Best regards,
> Francisco Iglesias
>
> Changelog:
> v2 -> v3
>   * Use sizeof(s->dsc_dst) as the memcpy length when loading dsc_dst.
>   * Remove an unnecessary qemu_log.
>   * Move the setting of DMA_DONE til after the DMA transfer while loop.
>   * Add dsc_src and dsc_dst to vmstate_zdma.
>
> v1 -> v2
>   * Don't unpause the DMA channel if CONT is zero and clear CONT after
>     unpausing.
>   * Added 'state' to the vmstate_zdma.
>   * Renamed defines and variables in 'xlnx-zynqmp: Connect the ZynqMP GDMA and
>     ADMA' to better reflect they are channels variables.

Applied to target-arm.next, thanks.

-- PMM
