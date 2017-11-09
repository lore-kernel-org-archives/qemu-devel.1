Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCcdm-00051z-6N
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 21:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCcdj-0000Yk-1r
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 21:32:26 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:55369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCcdi-0000YW-SW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 21:32:22 -0500
Received: by mail-qt0-x241.google.com with SMTP id v41so5919208qtv.12
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 18:32:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<301f422d963bc19b9ee5f6ebbe6bc3450b18664b.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db393cbf-0630-8b9e-1a53-b9b75117876a@amsat.org>
Date: Wed, 8 Nov 2017 23:32:18 -0300
MIME-Version: 1.0
In-Reply-To: <301f422d963bc19b9ee5f6ebbe6bc3450b18664b.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 18/45] hw/intc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, armbru@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, alistair23@gmail.com

On 11/08/2017 07:57 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Acked-by: Cornelia Huck <cohuck@redhat.com> (s390x part)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/intc/arm_gic_kvm.c   | 12 ++++++------
>  hw/intc/omap_intc.c     |  4 ++--
>  hw/intc/openpic.c       |  7 ++++---
>  hw/intc/openpic_kvm.c   |  8 ++++----
>  hw/intc/s390_flic_kvm.c |  4 ++--
>  5 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
> index ae095d08a3..a5478d3e20 100644
> --- a/hw/intc/arm_gic_kvm.c
> +++ b/hw/intc/arm_gic_kvm.c
> @@ -316,12 +316,12 @@ static void kvm_arm_gic_put(GICState *s)
>      num_cpu = ((reg & 0xe0) >> 5) + 1;
>  
>      if (num_irq < s->num_irq) {
> -            fprintf(stderr, "Restoring %u IRQs, but kernel supports max %d\n",
> -                    s->num_irq, num_irq);
> +            error_report("Restoring %u IRQs, but kernel supports max %d",
> +                         s->num_irq, num_irq);
>              abort();
>      } else if (num_cpu != s->num_cpu) {
> -            fprintf(stderr, "Restoring %u CPU interfaces, kernel only has %d\n",
> -                    s->num_cpu, num_cpu);
> +            error_report("Restoring %u CPU interfaces, kernel only has %d",
> +                         s->num_cpu, num_cpu);
>              /* Did we not create the VCPUs in the kernel yet? */
>              abort();
>      }
> @@ -411,8 +411,8 @@ static void kvm_arm_gic_get(GICState *s)
>      s->num_cpu = ((reg & 0xe0) >> 5) + 1;
>  
>      if (s->num_irq > GIC_MAXIRQ) {
> -            fprintf(stderr, "Too many IRQs reported from the kernel: %d\n",
> -                    s->num_irq);
> +            error_report("Too many IRQs reported from the kernel: %d",
> +                         s->num_irq);
>              abort();
>      }
>  
> diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
> index 6844c1aa83..7fc239715a 100644
> --- a/hw/intc/omap_intc.c
> +++ b/hw/intc/omap_intc.c
> @@ -539,8 +539,8 @@ static void omap2_inth_write(void *opaque, hwaddr addr,
>          /* TODO: Make a bitmap (or sizeof(char)map) of access privileges
>           * for every register, see Chapter 3 and 4 for privileged mode.  */
>          if (value & 1)
> -            fprintf(stderr, "%s: protection mode enable attempt\n",
> -                            __func__);
> +            error_report("%s: protection mode enable attempt",
> +                          __func__);
>          return;
>  
>      case 0x50:	/* INTC_IDLE */
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 10d6e871fb..7b1cafcc50 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -34,6 +34,7 @@
>   *
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/ppc/mac.h"
>  #include "hw/pci/pci.h"
> @@ -173,7 +174,7 @@ static int inttgt_to_output(int inttgt)
>          }
>      }
>  
> -    fprintf(stderr, "%s: unsupported inttgt %d\n", __func__, inttgt);
> +    error_report("%s: unsupported inttgt %d", __func__, inttgt);
>      return OPENPIC_OUTPUT_INT;
>  }
>  
> @@ -547,7 +548,7 @@ static void openpic_set_irq(void *opaque, int n_IRQ, int level)
>      IRQSource *src;
>  
>      if (n_IRQ >= OPENPIC_MAX_IRQ) {
> -        fprintf(stderr, "%s: IRQ %d out of range\n", __func__, n_IRQ);
> +        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
>          abort();
>      }
>  
> @@ -1221,7 +1222,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQDest *dst, int cpu)
>      src = &opp->src[irq];
>      if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
>              !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
> -        fprintf(stderr, "%s: bad raised IRQ %d ctpr %d ivpr 0x%08x\n",
> +        error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
>                  __func__, irq, dst->ctpr, src->ivpr);
>          openpic_update_irq(opp, irq);
>          retval = opp->spve;
> diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
> index fa83420254..60c784ae86 100644
> --- a/hw/intc/openpic_kvm.c
> +++ b/hw/intc/openpic_kvm.c
> @@ -150,8 +150,8 @@ static void kvm_openpic_region_add(MemoryListener *listener,
>  
>      ret = ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
>      if (ret < 0) {
> -        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
> -                strerror(errno), reg_base);
> +        error_report("%s: %s %" PRIx64 "", __func__,
> +                     strerror(errno), reg_base);
>      }
>  }
>  
> @@ -184,8 +184,8 @@ static void kvm_openpic_region_del(MemoryListener *listener,
>  
>      ret = ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
>      if (ret < 0) {
> -        fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
> -                strerror(errno), reg_base);
> +        error_report("%s: %s %" PRIx64 "", __func__,
> +                     strerror(errno), reg_base);
>      }
>  }
>  
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index d208cb81c4..e710bfdcda 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -83,7 +83,7 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
>      rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  
>      if (rc) {
> -        fprintf(stderr, "flic: couldn't enable pfault\n");
> +        error_report("flic: couldn't enable pfault");
>      }
>  }
>  
> @@ -97,7 +97,7 @@ static void flic_disable_wait_pfault(KVMS390FLICState *flic)
>      rc = ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
>  
>      if (rc) {
> -        fprintf(stderr, "flic: couldn't disable pfault\n");
> +        error_report("flic: couldn't disable pfault");
>      }
>  }
>  
> 
