Received: from eggs.gnu.org ([2001:4830:134:3::10]:46187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gFHST-0000w4-Lp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gFHIF-0006kT-41
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:25:43 -0400
Date: Wed, 24 Oct 2018 12:25:25 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181024112525.wdysex6exqd5aued@kamzik.brq.redhat.com>
References: <20181024085602.16611-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024085602.16611-1-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Set VIRT_COMPAT_3_0 compat
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

On Wed, Oct 24, 2018 at 10:56:02AM +0200, Eric Auger wrote:
> We are missing the VIRT_COMPAT_3_0 definition and setting.
> Let's add them.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/virt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f677825f9..a2b8d8f7c2 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1871,6 +1871,9 @@ static void virt_machine_3_1_options(MachineClass *mc)
>  }
>  DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
>  
> +#define VIRT_COMPAT_3_0 \
> +    HW_COMPAT_3_0
> +
>  static void virt_3_0_instance_init(Object *obj)
>  {
>      virt_3_1_instance_init(obj);
> @@ -1879,6 +1882,7 @@ static void virt_3_0_instance_init(Object *obj)
>  static void virt_machine_3_0_options(MachineClass *mc)
>  {
>      virt_machine_3_1_options(mc);
> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
>  }
>  DEFINE_VIRT_MACHINE(3, 0)
>  
> -- 
> 2.17.2
> 
>

Oops, I should have done this with the 3.1 machine type. Thanks for the
catching and patching.

Reviewed-by: Andrew Jones <drjones@redhat.com>
