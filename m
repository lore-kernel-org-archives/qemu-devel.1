Received: from eggs.gnu.org ([2001:4830:134:3::10]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05ZY-0008Kg-70
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05ZT-0004bW-Ic
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:48:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e05ZT-0004b9-Da
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 08:48:11 -0400
Received: by mail-qk0-x242.google.com with SMTP id w63so8339786qkd.2
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 05:48:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-19-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9c01e78-0fed-bae8-20ca-c6e359b02291@amsat.org>
Date: Thu, 5 Oct 2017 09:48:06 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-19-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/38] sh4: shix: use generic cpu_model
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

Hi Igor,

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Magnus Damm <magnus.damm@gmail.com>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  hw/sh4/shix.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
> index 50ee36a..4add230 100644
> --- a/hw/sh4/shix.c
> +++ b/hw/sh4/shix.c
> @@ -45,7 +45,6 @@
>  
>  static void shix_init(MachineState *machine)
>  {
> -    const char *cpu_model = machine->cpu_model;
>      int ret;
>      SuperHCPU *cpu;
>      struct SH7750State *s;
> @@ -53,10 +52,7 @@ static void shix_init(MachineState *machine)
>      MemoryRegion *rom = g_new(MemoryRegion, 1);
>      MemoryRegion *sdram = g_new(MemoryRegion, 2);
>      
> -    if (!cpu_model)
> -        cpu_model = "any";
> -
> -    cpu = SUPERH_CPU(cpu_generic_init(TYPE_SUPERH_CPU, cpu_model));
> +    cpu = SUPERH_CPU(cpu_create(machine->cpu_type));
>  
>      /* Allocate memory space */
>      memory_region_init_ram(rom, NULL, "shix.rom", 0x4000, &error_fatal);
> @@ -89,6 +85,7 @@ static void shix_machine_init(MachineClass *mc)
>      mc->desc = "shix card";
>      mc->init = shix_init;
>      mc->is_default = 1;
> +    mc->default_cpu_type = TYPE_SH7750R_CPU;

Maybe worth a comment explaining this.

After checking superh_cpu_class_by_name():
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  }
>  
>  DEFINE_MACHINE("shix", shix_machine_init)
> 
