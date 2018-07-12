Received: from eggs.gnu.org ([2001:4830:134:3::10]:49430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcb9-0001VQ-MG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdcb8-0000Bo-CE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:29:35 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:39980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdcb8-0000BO-7P
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:29:34 -0400
Received: by mail-oi0-x244.google.com with SMTP id w126-v6so56127914oie.7
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:29:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132954.24269-20-luc.michel@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-20-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 15:29:13 +0100
Message-ID: <CAFEAcA-F8Lj1SxFJZ1-GwdYaFSGP214eGTrFFoBHh0aasbBraA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 19/20] xlnx-zynqmp: Improve
 GIC wiring and MMIO mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>

On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
> This commit improve the way the GIC is realized and connected in the
> ZynqMP SoC. The security extensions are enabled only if requested in the
> machine state. The same goes for the virtualization extensions.
>
> All the GIC to APU CPU(s) IRQ lines are now connected, including FIQ,
> vIRQ and vFIQ. The missing CPU to GIC timers IRQ connections are also
> added (HYP and SEC timers).
>
> The GIC maintenance IRQs are back-wired to the correct GIC PPIs.
>
> Finally, the MMIO mappings are reworked to take into account the ZynqMP
> specificities. the GIC (v)CPU interface is aliased 16 times:

"specifics". "The"

>   * for the firsts 0x1000 bytes from 0xf9010000 to 0xf901f000
>   * for the seconds 0x1000 bytes from 0xf9020000 to 0xf902f000

"second"

> Mappings of the virtual interface and virtual CPU interface are mapped
> only when virtualization extensions are requested. The
> XlnxZynqMPGICRegion struct has been enhanced to be able to catch all
> this information.
>
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> ---

Nothing obviously wrong here, but I'll leave the details for
one of the Xilinx folk to review.

thanks
-- PMM
