Received: from eggs.gnu.org ([2001:4830:134:3::10]:51112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTqdD-0005CJ-U1
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fTqdD-0007m5-2n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:27:19 -0400
Date: Fri, 15 Jun 2018 17:27:08 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180615152708.t2aa2p5lzuzexwjy@kamzik.brq.redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
	<1529072910-16156-4-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529072910-16156-4-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/11] hw/intc/arm_gicv3: Introduce
 redist-region-count array property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, zhaoshenglong@huawei.com, lersek@redhat.com, ard.biesheuvel@linaro.org, christoffer.dall@arm.com, marc.zyngier@arm.com

On Fri, Jun 15, 2018 at 04:28:22PM +0200, Eric Auger wrote:
> To prepare for multiple redistributor regions, we introduce
> an array of uint32_t properties that stores the redistributor
> count of each redistributor region.
> 
> Non accelerated VGICv3 only supports a single redistributor region.
> The capacity of all redist regions is checked against the number of
> vcpus.
> 
> Machvirt is updated to set those properties, ie. a single
> redistributor region with count set to the number of vcpus
> capped by 123.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> v2 -> v3:
> - add missing return in arm_gic_realize
> - in gicv3_init_irqs_and_mmio, compute/check rdist_capacity first
> - rdist region 0 size set to MIN(smp_cpus, redist0_capacity)
> - add GICV3_REDIST_SIZE
> ---
>  hw/arm/virt.c                      | 11 ++++++++++-
>  hw/intc/arm_gicv3.c                | 12 +++++++++++-
>  hw/intc/arm_gicv3_common.c         | 38 +++++++++++++++++++++++++++++++++-----
>  hw/intc/arm_gicv3_kvm.c            |  9 +++++++--
>  include/hw/intc/arm_gicv3_common.h |  8 ++++++--
>  5 files changed, 67 insertions(+), 11 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
