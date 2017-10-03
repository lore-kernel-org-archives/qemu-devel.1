Received: from eggs.gnu.org ([2001:4830:134:3::10]:33869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOXh-0008J9-V0
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dzOXc-0001s6-CC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:51:30 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:57624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dzOXc-0001qg-1l
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 10:51:24 -0400
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-11-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b36a2523-8f27-3fb5-bc77-f649bd6fa8a2@vivier.eu>
Date: Tue, 3 Oct 2017 16:51:15 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/38] m68k: an5206: use generic cpu_model
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
> CC: huth@tuxfamily.org
> CC: laurent@vivier.eu
> ---
>  hw/m68k/an5206.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 9002c46..0cedc54 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -28,7 +28,6 @@
>  static void an5206_init(MachineState *machine)
>  {
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      M68kCPU *cpu;
>      CPUM68KState *env;
> @@ -39,10 +38,7 @@ static void an5206_init(MachineState *machine)
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
> -    if (!cpu_model) {
> -        cpu_model = "m5206";
> -    }
> -    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>      env = &cpu->env;
>  
>      /* Initialize CPU registers.  */
> @@ -94,6 +90,7 @@ static void an5206_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Arnewsh 5206";
>      mc->init = an5206_init;
> +    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
>  }
>  
>  DEFINE_MACHINE("an5206", an5206_machine_init)
> 
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
