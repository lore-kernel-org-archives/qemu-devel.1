Received: from eggs.gnu.org ([2001:4830:134:3::10]:43579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Sg-0005v3-Ma
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Sc-00037v-L2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:46 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:48323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1Sc-00037k-GL
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:42 -0400
Received: by mail-qt0-x244.google.com with SMTP id d13so6704993qta.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:12:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-39-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2d275ed-b904-d178-b243-cab697d2c633@amsat.org>
Date: Mon, 2 Oct 2017 11:12:39 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-39-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 38/38] mips: r4k: replace cpu_model with
 cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net, yongbok.kim@imgtec.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: aurelien@aurel32.net
> CC: yongbok.kim@imgtec.com
> ---
>   hw/mips/mips_r4k.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 1272d4e..3bbb182 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -163,7 +163,6 @@ static
>   void mips_r4k_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -186,14 +185,7 @@ void mips_r4k_init(MachineState *machine)
>       int be;
>   
>       /* init CPUs */
> -    if (cpu_model == NULL) {
> -#ifdef TARGET_MIPS64
> -        cpu_model = "R4000";
> -#else
> -        cpu_model = "24Kf";
> -#endif
> -    }
> -    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
> +    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       reset_info = g_malloc0(sizeof(ResetData));
> @@ -303,6 +295,12 @@ static void mips_machine_init(MachineClass *mc)
>       mc->desc = "mips r4k platform";
>       mc->init = mips_r4k_init;
>       mc->block_default_type = IF_IDE;
> +#ifdef TARGET_MIPS64
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
> +#else
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
> +#endif
> +
>   }
>   
>   DEFINE_MACHINE("mips", mips_machine_init)
> 
