Received: from eggs.gnu.org ([209.51.188.92]:37521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gmygA-0005Us-Oc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gmyg9-0005d4-IC
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:25:42 -0500
Date: Fri, 25 Jan 2019 11:25:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190125112522.0510ab64@redhat.com>
In-Reply-To: <20190125094047.22276-1-dgilbert@redhat.com>
References: <20190125094047.22276-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] typo: apci->acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, 25 Jan 2019 09:40:46 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> apci_1_compatible should be acpi_1_compatible.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/cpu.c         | 2 +-
>  hw/i386/acpi-build.c  | 2 +-
>  include/hw/acpi/cpu.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index f10b190019..a0a43fe6b5 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -508,7 +508,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>              GArray *madt_buf = g_array_new(0, 1, 1);
>              int arch_id = arch_ids->cpus[i].arch_id;
>  
> -            if (opts.apci_1_compatible && arch_id < 255) {
> +            if (opts.acpi_1_compatible && arch_id < 255) {
>                  dev = aml_processor(i, 0, 0, CPU_NAME_FMT, i);
>              } else {
>                  dev = aml_device(CPU_NAME_FMT, i);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2e21a31f82..d60603abd7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1847,7 +1847,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
>          CPUHotplugFeatures opts = {
> -            .apci_1_compatible = true, .has_legacy_cphp = true
> +            .acpi_1_compatible = true, .has_legacy_cphp = true
>          };
>          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
>                         "\\_SB.PCI0", "\\_GPE._E02");
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 89ce172941..62f0278ba2 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -48,7 +48,7 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>                           CPUHotplugState *state, hwaddr base_addr);
>  
>  typedef struct CPUHotplugFeatures {
> -    bool apci_1_compatible;
> +    bool acpi_1_compatible;
>      bool has_legacy_cphp;
>  } CPUHotplugFeatures;
>  
