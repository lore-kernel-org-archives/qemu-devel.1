Received: from eggs.gnu.org ([209.51.188.92]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gom08-0002d7-DN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gom06-0005Ax-Do
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:17:44 -0500
References: <20190125094047.22276-1-dgilbert@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7c6b541c-ed1d-0de2-29fe-76ca56c05640@vivier.eu>
Date: Wed, 30 Jan 2019 10:17:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190125094047.22276-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] typo: apci->acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com
Cc: qemu-trivial@nongnu.org

On 25/01/2019 10:40, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> apci_1_compatible should be acpi_1_compatible.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
