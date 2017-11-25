Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIfEn-0005ZK-Ts
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIfEk-0003xn-Qh
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:31:37 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:34525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIfEk-0003wG-KJ
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 13:31:34 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id CDDB8D34FF
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 19:31:32 +0100 (CET)
Date: Sat, 25 Nov 2017 19:31:19 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171125193119.39a3d62f@bahia.lan>
In-Reply-To: <20171125151610.20547-4-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ppc: e500: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Sat, 25 Nov 2017 13:16:07 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> platform_bus_create_devtree() already rejects all dynamic sysbus
> devices except TYPE_ETSEC_COMMON, so register it as the only
> allowed dynamic sysbus device for the ppce500 machine-type.
> 

Maybe drop the code that rejects unsupported sysbus devices, but this
can be done in a followup patch.

Anyway,

Reviewed-by: Greg Kurz <groug@kaod.org>

> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/ppc/e500plat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 438118c29b..81d03e1038 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "e500.h"
> +#include "hw/net/fsl_etsec/etsec.h"
>  #include "hw/boards.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/kvm.h"
> @@ -64,8 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
>      mc->desc = "generic paravirt e500 platform";
>      mc->init = e500plat_init;
>      mc->max_cpus = 32;
> -    /*TODO: allow only sysbus devices that really work with this machine */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
>  }
>  
