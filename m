Received: from eggs.gnu.org ([2001:4830:134:3::10]:59297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDjG-0000tn-0t
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daDjC-0003Bd-Rf
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:15:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daDjC-0003BI-IO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 00:15:18 -0400
Received: by mail-pf0-x243.google.com with SMTP id y25so7067261pfk.4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:15:18 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100554612.27487.13537614128295672408.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4781b663-9c9d-f012-f46c-1b986fc71f82@ozlabs.ru>
Date: Wed, 26 Jul 2017 14:15:11 +1000
MIME-Version: 1.0
In-Reply-To: <150100554612.27487.13537614128295672408.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 05/26] spapr_iommu:
 convert TCE table object to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

On 26/07/17 03:59, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  hw/ppc/spapr_iommu.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 740d42608b61..d4eca2a77225 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -248,7 +248,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
>      }
>  };
>  
> -static int spapr_tce_table_realize(DeviceState *dev)
> +static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
>  {
>      sPAPRTCETable *tcet = SPAPR_TCE_TABLE(dev);
>      Object *tcetobj = OBJECT(tcet);
> @@ -270,8 +270,6 @@ static int spapr_tce_table_realize(DeviceState *dev)
>  
>      vmstate_register(DEVICE(tcet), tcet->liobn, &vmstate_spapr_tce_table,
>                       tcet);
> -
> -    return 0;
>  }
>  
>  void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
> @@ -618,7 +616,7 @@ int spapr_tcet_dma_dt(void *fdt, int node_off, const char *propname,
>  static void spapr_tce_table_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    dc->init = spapr_tce_table_realize;
> +    dc->realize = spapr_tce_table_realize;
>      dc->reset = spapr_tce_reset;
>      dc->unrealize = spapr_tce_table_unrealize;
>  
> 
> 


-- 
Alexey
