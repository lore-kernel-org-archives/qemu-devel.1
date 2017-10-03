Received: from eggs.gnu.org ([2001:4830:134:3::10]:35903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNJ2-0003Ye-JI
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNJ1-0001V5-Ke
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:32:16 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNJ1-0001UJ-Fd
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:32:15 -0400
Received: by mail-qt0-x241.google.com with SMTP id v28so4101191qtv.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:32:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-12-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46827b79-577e-0cc7-d988-871d89fc4c7b@amsat.org>
Date: Tue, 3 Oct 2017 10:32:11 -0300
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
To: Igor Mammedov <imammedo@redhat.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org, huth@tuxfamily.org

On 10/02/2017 06:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
