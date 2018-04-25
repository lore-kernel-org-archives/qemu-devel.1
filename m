Received: from eggs.gnu.org ([2001:4830:134:3::10]:39347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLmn-0004r9-29
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLmh-0007U8-Ex
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:52:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLmh-0007U0-6j
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:52:39 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-8-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <567972f4-77cd-8ffd-84e4-87467f66025a@redhat.com>
Date: Wed, 25 Apr 2018 16:52:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] Change references to serial_hds[] to
 serial_hd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Change all the uses of serial_hds[] to go via the new
> serial_hd() function. Code change produced with:
>  find hw -name '*.[ch]' | xargs sed -i -e 's/serial_hds\[\([^]]*\)\]/serial_hd(\1)/g'
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/allwinner-a10.c                   |  4 ++--
>  hw/arm/aspeed_soc.c                      |  4 ++--
>  hw/arm/bcm2835_peripherals.c             |  4 ++--
>  hw/arm/digic.c                           |  2 +-
>  hw/arm/fsl-imx25.c                       |  2 +-
>  hw/arm/fsl-imx31.c                       |  2 +-
>  hw/arm/fsl-imx6.c                        |  4 ++--
>  hw/arm/fsl-imx7.c                        |  2 +-
>  hw/arm/highbank.c                        |  2 +-
>  hw/arm/integratorcp.c                    |  4 ++--
>  hw/arm/kzm.c                             |  4 ++--
>  hw/arm/mps2-tz.c                         |  2 +-
>  hw/arm/mps2.c                            |  4 ++--
>  hw/arm/msf2-soc.c                        |  4 ++--
>  hw/arm/musicpal.c                        |  8 ++++----
>  hw/arm/omap1.c                           |  6 +++---
>  hw/arm/omap2.c                           | 10 +++++-----
>  hw/arm/pxa2xx.c                          | 16 ++++++++--------
>  hw/arm/realview.c                        |  8 ++++----
>  hw/arm/stellaris.c                       |  2 +-
>  hw/arm/stm32f205_soc.c                   |  2 +-
>  hw/arm/strongarm.c                       |  2 +-
>  hw/arm/versatilepb.c                     |  8 ++++----
>  hw/arm/vexpress.c                        |  8 ++++----
>  hw/arm/virt.c                            |  4 ++--
>  hw/arm/xilinx_zynq.c                     |  4 ++--
>  hw/arm/xlnx-zynqmp.c                     |  2 +-
>  hw/char/exynos4210_uart.c                |  2 +-
>  hw/char/serial-isa.c                     |  4 ++--
>  hw/char/xen_console.c                    |  2 +-
>  hw/cris/axis_dev88.c                     |  2 +-
>  hw/hppa/machine.c                        |  4 ++--
>  hw/isa/isa-superio.c                     |  4 ++--
>  hw/lm32/lm32_boards.c                    |  8 ++++----
>  hw/lm32/milkymist.c                      |  4 ++--
>  hw/m68k/mcf5206.c                        |  4 ++--
>  hw/m68k/mcf5208.c                        |  6 +++---
>  hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
>  hw/mips/boston.c                         |  2 +-
>  hw/mips/mips_jazz.c                      |  8 ++++----
>  hw/mips/mips_malta.c                     |  2 +-
>  hw/mips/mips_mipssim.c                   |  4 ++--
>  hw/misc/macio/macio.c                    |  4 ++--
>  hw/moxie/moxiesim.c                      |  4 ++--
>  hw/nios2/10m50_devboard.c                |  2 +-
>  hw/openrisc/openrisc_sim.c               |  2 +-
>  hw/ppc/e500.c                            | 12 ++++++------
>  hw/ppc/ppc405_uc.c                       | 16 ++++++++--------
>  hw/ppc/ppc440_bamboo.c                   |  8 ++++----
>  hw/ppc/sam460ex.c                        |  8 ++++----
>  hw/ppc/spapr.c                           |  4 ++--
>  hw/ppc/virtex_ml507.c                    |  2 +-
>  hw/riscv/sifive_e.c                      |  4 ++--
>  hw/riscv/sifive_u.c                      |  4 ++--
>  hw/riscv/spike.c                         |  4 ++--
>  hw/riscv/virt.c                          |  2 +-
>  hw/sh4/r2d.c                             |  2 +-
>  hw/sh4/sh7750.c                          |  4 ++--
>  hw/sparc/leon3.c                         |  4 ++--
>  hw/sparc/sun4m.c                         |  4 ++--
>  hw/sparc64/niagara.c                     |  4 ++--
>  hw/sparc64/sun4u.c                       |  2 +-
>  hw/xtensa/sim.c                          |  4 ++--
>  hw/xtensa/xtfpga.c                       |  2 +-

Phew, that was a big patch, but looks good as far as I can see:

Reviewed-by: Thomas Huth <thuth@redhat.com>
