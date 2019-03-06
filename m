Received: from eggs.gnu.org ([209.51.188.92]:36059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Yyl-0000tP-73
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h1Yyc-0005DS-US
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:01:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1h1YyP-00051K-05
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:00:49 -0500
Date: Wed, 6 Mar 2019 17:00:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190306170041.051a2104@Igors-MacBook-Pro.local>
In-Reply-To: <20190227075101.6263-2-richardw.yang@linux.intel.com>
References: <20190227075101.6263-1-richardw.yang@linux.intel.com>
	<20190227075101.6263-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] nvdimm: fix typo in
 nvdimm_build_nvdimm_devices argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com

On Wed, 27 Feb 2019 15:50:58 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> From dsm_dma_arrea to dsm_dma_area.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/nvdimm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index e53b2cb681..39af8cdba8 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -1260,7 +1260,7 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
>  }
>  
>  static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
> -                              BIOSLinker *linker, GArray *dsm_dma_arrea,
> +                              BIOSLinker *linker, GArray *dsm_dma_area,
>                                uint32_t ram_slots)
>  {
>      Aml *ssdt, *sb_scope, *dev;
> @@ -1307,7 +1307,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>                                                 NVDIMM_ACPI_MEM_ADDR);
>  
>      bios_linker_loader_alloc(linker,
> -                             NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
> +                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
>                               sizeof(NvdimmDsmIn), false /* high memory */);
>      bios_linker_loader_add_pointer(linker,
>          ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
