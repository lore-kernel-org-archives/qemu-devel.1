Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT2FY-00039h-Ok
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT2FX-0005Oh-Tu
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:39:32 -0400
Date: Wed, 13 Jun 2018 11:39:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613113928.6d51bb45@redhat.com>
In-Reply-To: <20180611121655.19616-3-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/11] nvdimm: no need to overwrite
 get_vmstate_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Jun 2018 14:16:46 +0200
David Hildenbrand <david@redhat.com> wrote:

> Our parent class (PC_DIMM) provides exactly the same function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/nvdimm.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 4087aca25e..f974accbdd 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -166,11 +166,6 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
>      memory_region_set_dirty(mr, backend_offset, size);
>  }
>  
> -static MemoryRegion *nvdimm_get_vmstate_memory_region(PCDIMMDevice *dimm)
> -{
> -    return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
> -}
> -
>  static void nvdimm_class_init(ObjectClass *oc, void *data)
>  {
>      PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
> @@ -178,7 +173,6 @@ static void nvdimm_class_init(ObjectClass *oc, void *data)
>  
>      ddc->realize = nvdimm_realize;
>      ddc->get_memory_region = nvdimm_get_memory_region;
> -    ddc->get_vmstate_memory_region = nvdimm_get_vmstate_memory_region;
>  
>      nvc->read_label_data = nvdimm_read_label_data;
>      nvc->write_label_data = nvdimm_write_label_data;
