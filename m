Received: from eggs.gnu.org ([2001:4830:134:3::10]:50453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fVZky-0007AY-IB
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fVZkx-0000K4-On
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:50:28 -0400
Date: Wed, 20 Jun 2018 11:50:00 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180620095000.mbhnrfmlnupzeig5@toto>
References: <20180529124707.3025-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180529124707.3025-1-edgar.iglesias@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] xlnx-zynqmp: Change the Cortex-R5
 for Cortex-R5F
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, luc.michel@greensocs.com, sstabellini@kernel.org, f4bug@amsat.org

On Tue, May 29, 2018 at 02:47:05PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> The ZynqMP actually has Cortex-R5Fs with the optional FPU enabled.

Hi Peter,

Any comments on this series?

Cheers,
Edgar


> 
> Cheers,
> Edgar
> 
> ChangeLog:
> 
> v1 -> v2:
> * Update ZCU102 description to mention R5Fs
> 
> Edgar E. Iglesias (2):
>   target-arm: Add the Cortex-R5F
>   xlnx-zynqmp: Swap Cortex-R5 for Cortex-R5F
> 
>  hw/arm/xlnx-zcu102.c | 2 +-
>  hw/arm/xlnx-zynqmp.c | 2 +-
>  target/arm/cpu.c     | 9 +++++++++
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> -- 
> 2.14.1
> 
