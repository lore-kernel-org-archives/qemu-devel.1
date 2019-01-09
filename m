Received: from eggs.gnu.org ([209.51.188.92]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghBC4-0005wY-57
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:34:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghBC3-0004V7-5Z
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:34:40 -0500
References: <20190105023831.66910-1-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a2c4b0e3-f850-8e8b-eeb9-25e77d06cfb6@vivier.eu>
Date: Wed, 9 Jan 2019 11:34:08 +0100
MIME-Version: 1.0
In-Reply-To: <20190105023831.66910-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] ioapic: use TYPE_FOO MACRO
 than constant string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-trivial@nongnu.org, lvivier@redhat.com, qemu-devel@nongnu.org

On 05/01/2019 03:38, Li Qiang wrote:
> Make them more QOMConventional.
> Cc:qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/i386/kvm/ioapic.c     | 2 +-
>  hw/i386/pc.c             | 4 ++--
>  hw/intc/ioapic.c         | 2 +-
>  include/hw/i386/ioapic.h | 3 +++
>  4 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
> index 5b40d75439..e453692199 100644
> --- a/hw/i386/kvm/ioapic.c
> +++ b/hw/i386/kvm/ioapic.c
> @@ -163,7 +163,7 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo kvm_ioapic_info = {
> -    .name  = "kvm-ioapic",
> +    .name  = TYPE_KVM_IOAPIC,
>      .parent = TYPE_IOAPIC_COMMON,
>      .instance_size = sizeof(KVMIOAPICState),
>      .class_init = kvm_ioapic_class_init,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f248662e97..af68a61615 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1665,9 +1665,9 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
>      unsigned int i;
>  
>      if (kvm_ioapic_in_kernel()) {
> -        dev = qdev_create(NULL, "kvm-ioapic");
> +        dev = qdev_create(NULL, TYPE_KVM_IOAPIC);
>      } else {
> -        dev = qdev_create(NULL, "ioapic");
> +        dev = qdev_create(NULL, TYPE_IOAPIC);
>      }
>      if (parent_name) {
>          object_property_add_child(object_resolve_path(parent_name, NULL),
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 4e529729b4..9d75f84d3b 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -429,7 +429,7 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo ioapic_info = {
> -    .name          = "ioapic",
> +    .name          = TYPE_IOAPIC,
>      .parent        = TYPE_IOAPIC_COMMON,
>      .instance_size = sizeof(IOAPICCommonState),
>      .class_init    = ioapic_class_init,
> diff --git a/include/hw/i386/ioapic.h b/include/hw/i386/ioapic.h
> index 9c8816f11f..59fcb158a7 100644
> --- a/include/hw/i386/ioapic.h
> +++ b/include/hw/i386/ioapic.h
> @@ -23,6 +23,9 @@
>  #define IOAPIC_NUM_PINS 24
>  #define IO_APIC_DEFAULT_ADDRESS 0xfec00000
>  
> +#define TYPE_KVM_IOAPIC "kvm-ioapic"
> +#define TYPE_IOAPIC "ioapic"
> +
>  void ioapic_eoi_broadcast(int vector);
>  
>  #endif /* HW_IOAPIC_H */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
