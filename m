Received: from eggs.gnu.org ([2001:4830:134:3::10]:45386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dzJVR-0003h5-A5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dzJVO-0002Bh-39
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:28:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dzJVN-00028C-TD
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:28:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id y44so436241wry.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 02:28:45 -0700 (PDT)
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-12-git-send-email-imammedo@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <af59c662-73fb-8f03-e61c-7e9e89c10e8d@tuxfamily.org>
Date: Tue, 3 Oct 2017 11:28:42 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-12-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, laurent@vivier.eu

On 02.10.2017 11:07, Igor Mammedov wrote:
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

Acked-by: Thomas Huth <huth@tuxfamily.org>
