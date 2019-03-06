Received: from eggs.gnu.org ([209.51.188.92]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1SlL-00051f-BS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1SlK-0005hA-Hy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:22:55 -0500
References: <20190214084939.20640-1-richardw.yang@linux.intel.com>
	<20190214084939.20640-2-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e57b08c7-72d2-17d7-565c-4f8cbf5dd1bf@vivier.eu>
Date: Wed, 6 Mar 2019 10:22:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190214084939.20640-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [Patch v4 1/3] hw/i386/pc.c: remove
 unused function pc_acpi_init()
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
> Function pc_acpi_init() is not used anymore.
> 
> Remove the definition and declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/i386/pc.c         | 27 ---------------------------
>  include/hw/i386/pc.h |  1 -
>  2 files changed, 28 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5317e08f60..734d3268fa 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1280,33 +1280,6 @@ void pc_pci_as_mapping_init(Object *owner, MemoryRegion *system_memory,
>                                          pci_address_space, -1);
>  }
>  
> -void pc_acpi_init(const char *default_dsdt)
> -{
> -    char *filename;
> -
> -    if (acpi_tables != NULL) {
> -        /* manually set via -acpitable, leave it alone */
> -        return;
> -    }
> -
> -    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, default_dsdt);
> -    if (filename == NULL) {
> -        warn_report("failed to find %s", default_dsdt);
> -    } else {
> -        QemuOpts *opts = qemu_opts_create(qemu_find_opts("acpi"), NULL, 0,
> -                                          &error_abort);
> -        Error *err = NULL;
> -
> -        qemu_opt_set(opts, "file", filename, &error_abort);
> -
> -        acpi_table_add_builtin(opts, &err);
> -        if (err) {
> -            warn_reportf_err(err, "failed to load %s: ", filename);
> -        }
> -        g_free(filename);
> -    }
> -}
> -
>  void xen_load_linux(PCMachineState *pcms)
>  {
>      int i;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9d29c4b1df..541124ba6d 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -187,7 +187,6 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>  
>  void pc_cpus_init(PCMachineState *pcms);
>  void pc_hot_add_cpu(const int64_t id, Error **errp);
> -void pc_acpi_init(const char *default_dsdt);
>  
>  void pc_guest_info_init(PCMachineState *pcms);
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
