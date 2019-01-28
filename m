Received: from eggs.gnu.org ([209.51.188.92]:57849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go71q-0000xI-Ge
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go71l-0001EP-Uq
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 08:32:44 -0500
Date: Mon, 28 Jan 2019 14:32:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190128143230.3bda74a0@redhat.com>
In-Reply-To: <20190125060157.29935-1-richardw.yang@linux.intel.com>
References: <20190125060157.29935-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/i386/pc.c: remove unused function
 pc_acpi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, laurent@vivier.eu, mst@redhat.com

On Fri, 25 Jan 2019 14:01:55 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> Function pc_acpi_init() is now used in no place.
s/is now used in no place./in not used anymore,/

fixup the same phrase in other patches.

otherwise series looks good, so fix commit messages and resubmit series.

Also when sending  multi-patch series, pls use cover letter
(see help for git format-patch --cover-letter)

 
> Remove the definition and declaration.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
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
