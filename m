Received: from eggs.gnu.org ([2001:4830:134:3::10]:53697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07sk-0007fr-43
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07sg-0003xp-Rd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:14 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:53330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e07sg-0003xa-Lw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:10 -0400
Received: by mail-qt0-x241.google.com with SMTP id 47so25960888qts.10
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:16:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1507211474-188400-1-git-send-email-imammedo@redhat.com>
	<1507211474-188400-21-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <560eadf8-1930-d0a5-5d25-debcf2415e8a@amsat.org>
Date: Thu, 5 Oct 2017 12:15:56 -0300
MIME-Version: 1.0
In-Reply-To: <1507211474-188400-21-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/40] sh4: shix: use generic cpu_model
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

On 10/05/2017 10:50 AM, Igor Mammedov wrote:
> default cpu model 'any' resolves to type TYPE_SH7750R_CPU
> in superh_cpu_class_by_name(), so use it directly.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>   - Explain in commit message why default cpu model 'any' is
>     replaced by TYPE_SH7750R_CPU (Philippe Mathieu-Daudé)
> 
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
>  }
>  
>  DEFINE_MACHINE("shix", shix_machine_init)
> 
