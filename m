Received: from eggs.gnu.org ([209.51.188.92]:36703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hBFnD-0002da-V8
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hBFnB-0008HC-W7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:33:19 -0400
References: <20190401181621.GA31851@erokenlabserver>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <aaa7bca9-bb25-5df8-4b69-0cf6bfbed9cc@redhat.com>
Date: Tue, 2 Apr 2019 11:23:01 +0200
MIME-Version: 1.0
In-Reply-To: <20190401181621.GA31851@erokenlabserver>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Categorize devices: iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org

Hi Ernest,

On 4/1/19 8:16 PM, Ernest Esene wrote:
> Set category and description for iommu devices.
> 
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> 
> ---
> v3:
>   * set category and describe smmuv3 as suggested by Eric
> v2:
>   * split into separate patches
> ---
>  hw/arm/smmuv3.c       | 2 ++
>  hw/i386/amd_iommu.c   | 2 ++
>  hw/i386/intel_iommu.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 8c4e99fecc..d5a3df047d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1463,6 +1463,8 @@ static void smmuv3_class_init(ObjectClass *klass, void *data)
>      device_class_set_parent_reset(dc, smmu_reset, &c->parent_reset);
>      c->parent_realize = dc->realize;
>      dc->realize = smmu_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "ARM IOMMU (SMMUv3) DMA Remapping device"
>  }
>  
>  static void smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 6eabdf9917..4a4e2c7fd4 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1601,6 +1601,8 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
>      dc_class->int_remap = amdvi_int_remap;
>      /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
>  }
>  
>  static const TypeInfo amdvi = {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 055a1e865d..f9781a5d20 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3727,6 +3727,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      x86_class->int_remap = vtd_int_remap;
>      /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
>  }
>  
>  static const TypeInfo vtd_info = {
> 
