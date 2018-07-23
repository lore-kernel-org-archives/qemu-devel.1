Received: from eggs.gnu.org ([2001:4830:134:3::10]:36150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhZrN-0001Lq-8C
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhZrJ-00080j-Aq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:22:41 -0400
Date: Mon, 23 Jul 2018 14:22:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723142224.11e912ec@redhat.com>
In-Reply-To: <20180704124923.32483-2-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-2-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] hw/arm/virt: Add virt-3.1 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, wei@redhat.com

On Wed,  4 Jul 2018 14:49:18 +0200
Andrew Jones <drjones@redhat.com> wrote:

> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/virt.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 281ddcdf6e26..880441275031 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1757,10 +1757,7 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> -#define VIRT_COMPAT_2_12 \
> -    HW_COMPAT_2_12
> -
> -static void virt_3_0_instance_init(Object *obj)
> +static void virt_3_1_instance_init(Object *obj)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> @@ -1830,10 +1827,24 @@ static void virt_3_0_instance_init(Object *obj)
>      vms->irqmap = a15irqmap;
>  }
>  
> +static void virt_machine_3_1_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
> +
> +static void virt_3_0_instance_init(Object *obj)
> +{
> +    virt_3_1_instance_init(obj);
> +}
> +
>  static void virt_machine_3_0_options(MachineClass *mc)
>  {
> +    virt_machine_3_1_options(mc);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
> +DEFINE_VIRT_MACHINE(3, 0)
> +
> +#define VIRT_COMPAT_2_12 \
> +    HW_COMPAT_2_12
>  
>  static void virt_2_12_instance_init(Object *obj)
>  {
