Received: from eggs.gnu.org ([2001:4830:134:3::10]:51303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD4V-000543-Bg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1daD4R-0000Ff-Em
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:33:15 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1daD4R-0000Ep-8g
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 23:33:11 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so16121368pgy.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 20:33:11 -0700 (PDT)
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100550805.27487.16069660631488548584.stgit@bahia>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a33ca4ee-9f73-c1d0-1348-970e628dae3b@ozlabs.ru>
Date: Wed, 26 Jul 2017 13:33:04 +1000
MIME-Version: 1.0
In-Reply-To: <150100550805.27487.16069660631488548584.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 02/26] spapr_pci: use
 memory_region_add_subregion() with DMA windows
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

On 26/07/17 03:58, Greg Kurz wrote:
> Passing a null priority to memory_region_add_subregion_overlap() is
> strictly equivalent to calling memory_region_add_subregion().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  hw/ppc/spapr_pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 70a99a032267..3fe7f3145467 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1752,8 +1752,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>                         i, sphb->dtbusname);
>              return;
>          }
> -        memory_region_add_subregion_overlap(&sphb->iommu_root, 0,
> -                                            spapr_tce_get_iommu(tcet), 0);
> +        memory_region_add_subregion(&sphb->iommu_root, 0,
> +                                    spapr_tce_get_iommu(tcet));
>      }
>  
>      sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
> 
> 


-- 
Alexey
