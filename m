Received: from eggs.gnu.org ([2001:4830:134:3::10]:60772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Pf-0002R0-Sp
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:38:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Pc-0003LI-Ph
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:38:03 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05Pc-0003KV-LO
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:38:00 -0400
Received: by mail-qk0-x243.google.com with SMTP id w63so8324011qkd.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:38:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-18-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6eba30bc-9e24-48f2-4e03-b11bbd95c973@amsat.org>
Date: Thu, 5 Oct 2017 09:37:55 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-18-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/38] sh4: r2d: use generic cpu_model
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Magnus Damm <magnus.damm@gmail.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  hw/sh4/r2d.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index 16b9ed2..458ed83 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -225,7 +225,6 @@ static struct QEMU_PACKED
>  
>  static void r2d_init(MachineState *machine)
>  {
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      const char *initrd_filename = machine->initrd_filename;
> @@ -242,11 +241,7 @@ static void r2d_init(MachineState *machine)
>      MemoryRegion *address_space_mem = get_system_memory();
>      PCIBus *pci_bus;
>  
> -    if (cpu_model == NULL) {
> -        cpu_model = "SH7751R";
> -    }
> -
> -    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
> +    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
>      env = &cpu->env;
>  
>      reset_info = g_malloc0(sizeof(ResetData));
> @@ -365,6 +360,7 @@ static void r2d_machine_init(MachineClass *mc)
>      mc->desc = "r2d-plus board";
>      mc->init = r2d_init;
>      mc->block_default_type = IF_IDE;
> +    mc->default_cpu_type = TYPE_SH7751R_CPU;
>  }
>  
>  DEFINE_MACHINE("r2d", r2d_machine_init)
> 
