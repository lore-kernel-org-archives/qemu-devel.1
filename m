Received: from eggs.gnu.org ([2001:4830:134:3::10]:57483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Ub7-0001nZ-Bm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Ub6-0001Ra-KI
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:25:17 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Ub2-0001Oi-U1
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 08:25:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id u197-v6so15593853oif.5
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 05:25:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 13:24:51 +0100
Message-ID: <CAFEAcA-tC0wHgkh+CA2s+G015kvdd47h-R+VCbjCRRZVTsUghA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 3 October 2018 at 16:07, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Add support for selecting the Memory Region that the GEM
> will do DMA to.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---


> @@ -1500,6 +1506,13 @@ static void gem_realize(DeviceState *dev, Error **errp)
>      CadenceGEMState *s = CADENCE_GEM(dev);
>      int i;
>
> +    if (s->dma_mr) {
> +        s->dma_as = g_malloc0(sizeof(AddressSpace));
> +        address_space_init(s->dma_as, s->dma_mr, NULL);

Why not just have the CadenceGEMState embed the AddressSpace

    AddressSpace dma_as;

rather than doing a separate memory allocation here?

> +    } else {
> +        s->dma_as = &address_space_memory;
> +    }

thanks
-- PMM
