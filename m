Received: from eggs.gnu.org ([2001:4830:134:3::10]:46422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1degva-0004AC-EU
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1degvV-0000DI-Kx
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:14:34 -0400
Date: Mon, 7 Aug 2017 14:14:10 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170807121410.2h5k6duxw7aia3ow@kamzik.brq.redhat.com>
References: <1502106581-11714-1-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502106581-11714-1-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] hw/arm/virt: Add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

On Mon, Aug 07, 2017 at 11:49:41AM +0000, Eric Auger wrote:
> Add virt-2.10 machine type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> ---
>  hw/arm/virt.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 31739d7..6b7a0fe 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1639,7 +1639,7 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> -static void virt_2_9_instance_init(Object *obj)
> +static void virt_2_10_instance_init(Object *obj)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> @@ -1699,10 +1699,25 @@ static void virt_2_9_instance_init(Object *obj)
>      vms->irqmap = a15irqmap;
>  }
>  
> +static void virt_machine_2_10_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(2, 10)
> +
> +#define VIRT_COMPAT_2_9 \
> +    HW_COMPAT_2_9
> +
> +static void virt_2_9_instance_init(Object *obj)
> +{
> +    virt_2_10_instance_init(obj);
> +}
> +
>  static void virt_machine_2_9_options(MachineClass *mc)
>  {
> +    virt_machine_2_10_options(mc);
> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_9);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(2, 9)
> +DEFINE_VIRT_MACHINE(2, 9)
>  
>  #define VIRT_COMPAT_2_8 \
>      HW_COMPAT_2_8
> -- 
> 1.9.1
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
