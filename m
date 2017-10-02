Received: from eggs.gnu.org ([2001:4830:134:3::10]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Rv-000548-ES
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Rs-0002nJ-NB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:11:59 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Rs-0002mR-Iz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:11:56 -0400
Received: by mail-qk0-x243.google.com with SMTP id w63so2361012qkd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:11:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-37-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83dcef5e-e253-d012-c08a-1660d004f5ba@amsat.org>
Date: Mon, 2 Oct 2017 11:11:49 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-37-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 36/38] mips: Magnum/Acer Pica 61: replace
 cpu_model with cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, hpoussin@reactos.org, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: hpoussin@reactos.org
> CC: aurelien@aurel32.net
> CC: yongbok.kim@imgtec.com
> ---
>   hw/mips/mips_jazz.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 7e6626d..fe4f173 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -122,7 +122,6 @@ static void mips_jazz_init(MachineState *machine,
>                              enum jazz_model_e jazz_model)
>   {
>       MemoryRegion *address_space = get_system_memory();
> -    const char *cpu_model = machine->cpu_model;
>       char *filename;
>       int bios_size, n;
>       MIPSCPU *cpu;
> @@ -148,10 +147,7 @@ static void mips_jazz_init(MachineState *machine,
>       MemoryRegion *bios2 = g_new(MemoryRegion, 1);
>   
>       /* init CPUs */
> -    if (cpu_model == NULL) {
> -        cpu_model = "R4000";
> -    }
> -    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
> +    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>       qemu_register_reset(main_cpu_reset, cpu);
>   
> @@ -349,6 +345,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
>       mc->desc = "MIPS Magnum";
>       mc->init = mips_magnum_init;
>       mc->block_default_type = IF_SCSI;
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
>   }
>   
>   static const TypeInfo mips_magnum_type = {
> @@ -364,6 +361,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
>       mc->desc = "Acer Pica 61";
>       mc->init = mips_pica61_init;
>       mc->block_default_type = IF_SCSI;
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
>   }
>   
>   static const TypeInfo mips_pica61_type = {
> 
