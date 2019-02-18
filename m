Received: from eggs.gnu.org ([209.51.188.92]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvm7R-0007Jh-O1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gvm7R-0004Lr-1x
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:50:13 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-9-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <aa7290ec-34e1-2fe7-8bcb-0a9db90bd418@redhat.com>
Date: Mon, 18 Feb 2019 17:50:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/10] pflash: Clean up after commit
 368a354f02b part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 02/18/19 13:56, Markus Armbruster wrote:
> QOMification left parameter @qdev unused in pflash_cfi01_register()
> and pflash_cfi02_register().  All callers pass NULL.  Remove.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/collie.c                          | 4 ++--
>  hw/arm/digic_boards.c                    | 2 +-
>  hw/arm/gumstix.c                         | 4 ++--
>  hw/arm/mainstone.c                       | 2 +-
>  hw/arm/musicpal.c                        | 4 ++--
>  hw/arm/omap_sx1.c                        | 4 ++--
>  hw/arm/versatilepb.c                     | 2 +-
>  hw/arm/xilinx_zynq.c                     | 2 +-
>  hw/arm/z2.c                              | 3 +--
>  hw/block/pflash_cfi01.c                  | 2 +-
>  hw/block/pflash_cfi02.c                  | 2 +-
>  hw/i386/pc_sysfw.c                       | 2 +-
>  hw/lm32/lm32_boards.c                    | 4 ++--
>  hw/lm32/milkymist.c                      | 2 +-
>  hw/microblaze/petalogix_ml605_mmu.c      | 3 +--
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 +-
>  hw/mips/mips_malta.c                     | 2 +-
>  hw/mips/mips_r4k.c                       | 2 +-
>  hw/ppc/ppc405_boards.c                   | 6 +++---
>  hw/ppc/sam460ex.c                        | 2 +-
>  hw/ppc/virtex_ml507.c                    | 2 +-
>  hw/sh4/r2d.c                             | 2 +-
>  include/hw/block/flash.h                 | 4 ++--
>  23 files changed, 31 insertions(+), 33 deletions(-)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
