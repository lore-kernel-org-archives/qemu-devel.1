Received: from eggs.gnu.org ([209.51.188.92]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1SlT-0005Ao-2g
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1SlR-0005n0-59
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:23:03 -0500
References: <20190214084939.20640-1-richardw.yang@linux.intel.com>
	<20190214084939.20640-3-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <058cabac-89cb-c414-4e63-ff3264cf88dc@vivier.eu>
Date: Wed, 6 Mar 2019 10:22:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190214084939.20640-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [Patch v4 2/3] hw/acpi: remove
 unused function acpi_table_add_builtin()
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
> Function acpi_table_add_builtin() is not used anymore.
> 
> Remove the definition and declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/core.c         | 6 ------
>  include/hw/acpi/acpi.h | 1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index d6f0709691..e9b1a85e54 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -305,12 +305,6 @@ out:
>  
>  static bool acpi_table_builtin = false;
>  
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp)
> -{
> -    acpi_table_builtin = true;
> -    acpi_table_add(opts, errp);
> -}
> -
>  unsigned acpi_table_len(void *current)
>  {
>      struct acpi_table_header *hdr = current - sizeof(hdr->_length);
> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
> index c20ace0d0b..4a8bbaf1b5 100644
> --- a/include/hw/acpi/acpi.h
> +++ b/include/hw/acpi/acpi.h
> @@ -190,7 +190,6 @@ uint8_t *acpi_table_first(void);
>  uint8_t *acpi_table_next(uint8_t *current);
>  unsigned acpi_table_len(void *current);
>  void acpi_table_add(const QemuOpts *opts, Error **errp);
> -void acpi_table_add_builtin(const QemuOpts *opts, Error **errp);
>  
>  typedef struct AcpiSlicOem AcpiSlicOem;
>  struct AcpiSlicOem {
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
