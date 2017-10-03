Received: from eggs.gnu.org ([2001:4830:134:3::10]:34176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOYV-0000Xo-DH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOYR-0002zT-3o
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:52:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dzOYQ-0002yG-QV
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:52:15 -0400
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-12-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3702e414-aec6-853c-d90c-9e920dfb72a0@vivier.eu>
Date: Tue, 3 Oct 2017 16:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/38] m68k: mcf5208: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, huth@tuxfamily.org

Le 02/10/2017 à 11:07, Igor Mammedov a écrit :
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: laurent@vivier.eu
> CC: huth@tuxfamily.org
> ---
>  hw/m68k/mcf5208.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index b9dde75..cfac845 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -217,7 +217,6 @@ static void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd, hwaddr base,
>  static void mcf5208evb_init(MachineState *machine)
>  {
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      M68kCPU *cpu;
>      CPUM68KState *env;
> @@ -229,10 +228,7 @@ static void mcf5208evb_init(MachineState *machine)
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
> -    if (!cpu_model) {
> -        cpu_model = "m5208";
> -    }
> -    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>      env = &cpu->env;
>  
>      /* Initialize CPU registers.  */
> @@ -321,6 +317,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
>      mc->desc = "MCF5206EVB";
>      mc->init = mcf5208evb_init;
>      mc->is_default = 1;
> +    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
>  }
>  
>  DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
