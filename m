Received: from eggs.gnu.org ([209.51.188.92]:36490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Sm8-0005gv-PH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:23:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1Sm7-0006Dz-UE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:23:44 -0500
References: <20190214084939.20640-1-richardw.yang@linux.intel.com>
	<20190214084939.20640-4-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <8a961366-89d2-bdde-9fa2-8ae95bc4275b@vivier.eu>
Date: Wed, 6 Mar 2019 10:23:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190214084939.20640-4-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [Patch v4 3/3] hw/acpi: remove
 unnecessary variable acpi_table_builtin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, mst@redhat.com, imammedo@redhat.com, philmd@redhat.com

On 14/02/2019 09:49, Wei Yang wrote:
> acpi_table_builtin is now always false, it is not necessary to check it
> again.
> 
> This patch just removes it.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index e9b1a85e54..f9c96535d1 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -303,8 +303,6 @@ out:
>      error_propagate(errp, err);
>  }
>  
> -static bool acpi_table_builtin = false;
> -
>  unsigned acpi_table_len(void *current)
>  {
>      struct acpi_table_header *hdr = current - sizeof(hdr->_length);
> @@ -320,7 +318,7 @@ void *acpi_table_hdr(void *h)
>  
>  uint8_t *acpi_table_first(void)
>  {
> -    if (acpi_table_builtin || !acpi_tables) {
> +    if (!acpi_tables) {
>          return NULL;
>      }
>      return acpi_table_hdr(acpi_tables + ACPI_TABLE_PFX_SIZE);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
