Received: from eggs.gnu.org ([209.51.188.92]:50875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hArdx-0007zj-Eg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hArdw-0006LO-Ho
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hArdw-0006K6-9v
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:46:08 -0400
References: <20190327170518.GA16887@erokenlabserver>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c2862412-0ce0-f291-a902-d599382f5608@redhat.com>
Date: Mon, 1 Apr 2019 09:45:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190327170518.GA16887@erokenlabserver>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] Categorize devices: iommu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ernest Esene <eroken1@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Ernest,

On 3/27/19 6:05 PM, Ernest Esene wrote:
> Set category and description for iommu devices
> Signed-off-by: Ernest Esene <eroken1@gmail.com>
> 
> ---
> v2:
>   * split into separate patches
> ---
>  hw/i386/amd_iommu.c   | 2 ++
>  hw/i386/intel_iommu.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
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
> index b90de6c664..4d0e60423c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3702,6 +3702,8 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      x86_class->int_remap = vtd_int_remap;
>      /* Supported by the pc-q35-* machine types */
>      dc->user_creatable = true;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
>  }

The same can be done as well for ARM IOMMU, aka SMMUv3 (hw/arm/smmuv3.c,
smmuv3_class_init).

Thanks

Eric
>  
>  static const TypeInfo vtd_info = {
> 
