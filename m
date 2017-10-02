Received: from eggs.gnu.org ([2001:4830:134:3::10]:47901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz33K-0000JA-O7
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:54:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz33H-0004kJ-04
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:54:42 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:48200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz33G-0004k1-S8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:54:38 -0400
Received: by mail-qt0-x242.google.com with SMTP id d13so7146641qta.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 08:54:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-33-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c1298714-d538-0c5d-b653-5f42a5c1fe2d@amsat.org>
Date: Mon, 2 Oct 2017 12:54:29 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-33-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 32/38] sparc: leon3: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, mark.cave-ayland@ilande.co.uk
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com, chouteau@adacore.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

not easy to boot this one, I wonder who still uses it...

building u-boot with:
http://git.denx.de/?p=u-boot.git;a=commit;h=9eed48c8bec98425dbd995dd72c40e9ad7a8c26b

I can't get further than:
https://lists.gnu.org/archive/html/qemu-discuss/2016-05/msg00025.html

Anyway:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: mark.cave-ayland@ilande.co.uk
> CC: atar4qemu@gmail.com
> CC: chouteau@adacore.com
> ---
>   hw/sparc/leon3.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index ec2816b..8c66d5a 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -107,7 +107,6 @@ static void leon3_set_pil_in(void *opaque, uint32_t pil_in)
>   static void leon3_generic_hw_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       SPARCCPU *cpu;
>       CPUSPARCState   *env;
> @@ -122,11 +121,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>       ResetData  *reset_info;
>   
>       /* Init CPU */
> -    if (!cpu_model) {
> -        cpu_model = "LEON3";
> -    }
> -
> -    cpu = SPARC_CPU(cpu_generic_init(TYPE_SPARC_CPU, cpu_model));
> +    cpu = SPARC_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       cpu_sparc_set_id(env, 0);
> @@ -222,6 +217,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
>   {
>       mc->desc = "Leon-3 generic";
>       mc->init = leon3_generic_hw_init;
> +    mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
>   }
>   
>   DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
> 
