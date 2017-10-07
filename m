Received: from eggs.gnu.org ([2001:4830:134:3::10]:50082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0ckU-0001at-83
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e0ckR-0003sk-3t
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:46 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:38869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e0ckQ-0003sL-Tq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 20:13:43 -0400
Received: by mail-pg0-x241.google.com with SMTP id j3so4006923pga.5
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 17:13:42 -0700 (PDT)
Date: Sat, 7 Oct 2017 09:13:40 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171007001340.GD2630@lianli.shorne-pla.net>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-19-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1507211474-188400-19-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/40] openrisc: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, Oct 05, 2017 at 03:50:52PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Less lines of code, thanks.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
> CC: shorne@gmail.com
> ---
>  hw/openrisc/openrisc_sim.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 86bf284..f61b63d 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -98,18 +98,13 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
>  static void openrisc_sim_init(MachineState *machine)
>  {
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      OpenRISCCPU *cpu = NULL;
>      MemoryRegion *ram;
>      int n;
>  
> -    if (!cpu_model) {
> -        cpu_model = "or1200";
> -    }
> -
>      for (n = 0; n < smp_cpus; n++) {
> -        cpu = OPENRISC_CPU(cpu_generic_init(TYPE_OPENRISC_CPU, cpu_model));
> +        cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
>          qemu_register_reset(main_cpu_reset, cpu);
>          main_cpu_reset(cpu);
>      }
> @@ -138,6 +133,7 @@ static void openrisc_sim_machine_init(MachineClass *mc)
>      mc->init = openrisc_sim_init;
>      mc->max_cpus = 1;
>      mc->is_default = 1;
> +    mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
>  }
>  
>  DEFINE_MACHINE("or1k-sim", openrisc_sim_machine_init)
> -- 
> 2.7.4
> 
