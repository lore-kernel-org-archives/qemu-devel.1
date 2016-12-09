Received: from eggs.gnu.org ([2001:4830:134:3::10]:34872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cFLBX-0001jY-NH
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cFLBT-0006Qs-Dd
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 08:25:59 -0500
References: <20161209022314.14399-1-david@gibson.dropbear.id.au>
	<20161209022314.14399-2-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <eb9403ac-e1f9-7dc9-458e-723a661884b5@redhat.com>
Date: Fri, 9 Dec 2016 14:25:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161209022314.14399-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-2.9 1/5] pseries: Add pseries-2.9 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com



On 09/12/2016 03:23, David Gibson wrote:
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
>  include/hw/compat.h |  3 +++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cfadc46..0f25e83 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2761,18 +2761,37 @@ static const TypeInfo spapr_machine_info = {
>      type_init(spapr_machine_register_##suffix)
>  
>  /*
> + * pseries-2.9
> + */
> +static void spapr_machine_2_9_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_2_9_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
> +
> +/*
>   * pseries-2.8
>   */
> +#define SPAPR_COMPAT_2_8                            \
> +    HW_COMPAT_2_8
> +
>  static void spapr_machine_2_8_instance_options(MachineState *machine)
>  {
> +    spapr_machine_2_9_instance_options(machine);
>  }
>  
>  static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_2_9_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
>  }
>  
> -DEFINE_SPAPR_MACHINE(2_8, "2.8", true);
> +DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
>  
>  /*
>   * pseries-2.7
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 0f06e11..f8b8354 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
>  
> +#define HW_COMPAT_2_8 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_7 \
>      {\
>          .driver   = "virtio-pci",\
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
