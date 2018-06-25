Received: from eggs.gnu.org ([2001:4830:134:3::10]:55835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSUh-0002vc-5s
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXSUg-0002ji-CP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:29:27 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXSUf-0002jG-VC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:29:26 -0400
Received: by mail-oi0-x241.google.com with SMTP id 21-v6so2005612oip.8
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 07:29:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619093124.24011-8-luc.michel@greensocs.com>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<20180619093124.24011-8-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 15:29:04 +0100
Message-ID: <CAFEAcA-3_6axe2Bvx5zehGvVYs_egiUZyh_e56P7Lkh927OzaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] xlnx-zynqmp: Improve GIC wiring and
 MMIO mapping
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

On 19 June 2018 at 10:31,  <luc.michel@greensocs.com> wrote:
> From: Luc MICHEL <luc.michel@greensocs.com>
>
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
>   * for the firsts 0x1000 bytes from 0xf9010000 to 0xf901f000
>   * for the seconds 0x1000 bytes from 0xf9020000 to 0xf902f000
> Mappings of the virtual interface and virtual CPU interface are mapped
> only when virtualization extensions are requested. The
> XlnxZynqMPGICRegion struct has been enhanced to be able to catch all
> this information.
>
> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
> ---
>  hw/arm/xlnx-zynqmp.c         | 92 ++++++++++++++++++++++++++++++++----
>  include/hw/arm/xlnx-zynqmp.h |  4 +-
>  2 files changed, 86 insertions(+), 10 deletions(-)

Nothing obviously wrong-looking in here; a review from one of
the Xilinx folk would be good.

thanks
-- PMM
