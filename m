Received: from eggs.gnu.org ([2001:4830:134:3::10]:58556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cX0Yh-0000TL-Sv
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cX0Yh-0006ek-74
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 02:02:55 -0500
MIME-Version: 1.0
In-Reply-To: <1485422381-29019-3-git-send-email-eric.auger@redhat.com>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
	<1485422381-29019-3-git-send-email-eric.auger@redhat.com>
From: Vijay Kilari <vijay.kilari@gmail.com>
Date: Fri, 27 Jan 2017 12:32:50 +0530
Message-ID: <CALicx6uLp5SapC5PiDRB6OdaVWXVNYUCORAQ7EsPJ-KNNF5cTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 2/4] hw/intc/arm_gicv3_kvm: Rename
 KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, shannon.zhao@linaro.org, Christoffer Dall <christoffer.dall@linaro.org>, drjones@redhat.com, "Kumar, Vijaya" <Vijaya.Kumar@cavium.com>, peterx@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Eric,

On Thu, Jan 26, 2017 at 2:49 PM, Eric Auger <eric.auger@redhat.com> wrote:
> Rename KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS into KVM_DEV_ARM_VGIC_CPU_SYSREGS
> as exposed in the kernel user API and pulled by update-linux-headers.sh.

I will fix it in my next qemu patch series.
I have updated kernel to use KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS in
latest kernel patch
version v11. I so you can drop this patch.

>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> KVM_DEV_ARM_VGIC_CPU_SYSREGS may be fixed at kernel level instead
> ---
>  hw/intc/arm_gicv3_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 267c2d6..d8ecbc3 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -108,7 +108,7 @@ static inline void kvm_gicr_access(GICv3State *s, int offset, int cpu,
>  static inline void kvm_gicc_access(GICv3State *s, uint64_t reg, int cpu,
>                                     uint64_t *val, bool write)
>  {
> -    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_CPU_SYSREGS,
>                        KVM_VGIC_ATTR(reg, s->cpu[cpu].gicr_typer),
>                        val, write);
>  }
> --
> 2.5.5
>
