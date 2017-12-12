Received: from eggs.gnu.org ([2001:4830:134:3::10]:51778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOliY-0003Wt-46
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOliX-00044p-7n
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:39:34 -0500
Date: Tue, 12 Dec 2017 15:39:22 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212143922.cl7wyhupqdopqcdj@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512745328-5109-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/virt: Add virt-2.12 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <shannon.zhao@linaro.org>

On Fri, Dec 08, 2017 at 03:02:06PM +0000, Peter Maydell wrote:
> Add virt-2.12 machine type.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/compat.h |  3 +++
>  hw/arm/virt.c       | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)


Reviewed-by: Andrew Jones <drjones@redhat.com>

> 
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index cf389b4..263de97 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_2_11 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_10 \
>      {\
>          .driver   = "virtio-mouse-device",\
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 151592b..543f9bd 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1618,7 +1618,7 @@ static void machvirt_machine_init(void)
>  }
>  type_init(machvirt_machine_init);
>  
> -static void virt_2_11_instance_init(Object *obj)
> +static void virt_2_12_instance_init(Object *obj)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(obj);
>      VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> @@ -1678,10 +1678,25 @@ static void virt_2_11_instance_init(Object *obj)
>      vms->irqmap = a15irqmap;
>  }
>  
> +static void virt_machine_2_12_options(MachineClass *mc)
> +{
> +}
> +DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
> +
> +#define VIRT_COMPAT_2_11 \
> +    HW_COMPAT_2_11
> +
> +static void virt_2_11_instance_init(Object *obj)
> +{
> +    virt_2_12_instance_init(obj);
> +}
> +
>  static void virt_machine_2_11_options(MachineClass *mc)
>  {
> +    virt_machine_2_12_options(mc);
> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
>  }
> -DEFINE_VIRT_MACHINE_AS_LATEST(2, 11)
> +DEFINE_VIRT_MACHINE(2, 11)
>  
>  #define VIRT_COMPAT_2_10 \
>      HW_COMPAT_2_10
> -- 
> 2.7.4
> 
> 
