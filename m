Received: from eggs.gnu.org ([2001:4830:134:3::10]:60363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTtGf-00059F-Ha
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTtGe-0004N1-TC
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:48:29 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTtGe-0004Mi-Nr
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 13:48:28 -0500
Received: by mail-oi1-x244.google.com with SMTP id m6so11867306oig.11
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 10:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 18:48:14 +0000
Message-ID: <CAFEAcA8RniYSkvAv5zLMzyRbyekuE47ZQ7Rrv-7joO5bqmhm7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/4] hw/arm: versal: Correct number of
 IRQs in GIC setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, mbilal <muhammad_bilal@mentor.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, Luc Michel <luc.michel@greensocs.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>, figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On Thu, 29 Nov 2018 at 16:36, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The Versal GIC has 192 IRQs not 256 as we previously had setup.
> This series fixes the setup and moves the virtio-mmio nodes
> to use other reserved interrupts.
>
> Since we don't have 32 reserved lines, we also reduce the number of
> virtio-mmio regions to 8 (we do have some more lines free but let's
> leave some for future use).
>
> Cheers,
> Edgar
>
> Edgar E. Iglesias (4):
>   hw/arm: versal: Remove bogus virtio-mmio creation
>   hw/arm: versal: Reduce number of virtio-mmio instances
>   hw/arm: versal: Use IRQs 111 - 118 for virtio-mmio
>   hw/arm: versal: Correct the nr of IRQs to 192

Applied to target-arm.next for 4.0, thanks.

-- PMM
