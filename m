Received: from eggs.gnu.org ([2001:4830:134:3::10]:43469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1SD-0005NL-71
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1S7-0002vY-AN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:17 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz1S7-0002vJ-70
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:12:11 -0400
Received: by mail-qk0-x243.google.com with SMTP id z14so3928707qkg.3
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:12:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-38-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <000b3e38-e0d0-ce14-562e-b07d37d1e013@amsat.org>
Date: Mon, 2 Oct 2017 11:12:07 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-38-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 37/38] mips: mipssim: replace cpu_model
 with cpu_type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: yongbok.kim@imgtec.com, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: yongbok.kim@imgtec.com
> CC: aurelien@aurel32.net
> ---
>   hw/mips/mips_mipssim.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index a092072..e5d3654 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -141,7 +141,6 @@ static void
>   mips_mipssim_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *kernel_cmdline = machine->kernel_cmdline;
>       const char *initrd_filename = machine->initrd_filename;
> @@ -156,14 +155,7 @@ mips_mipssim_init(MachineState *machine)
>       int bios_size;
>   
>       /* Init CPUs. */
> -    if (cpu_model == NULL) {
> -#ifdef TARGET_MIPS64
> -        cpu_model = "5Kf";
> -#else
> -        cpu_model = "24Kf";
> -#endif
> -    }
> -    cpu = MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
> +    cpu = MIPS_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       reset_info = g_malloc0(sizeof(ResetData));
> @@ -235,6 +227,11 @@ static void mips_mipssim_machine_init(MachineClass *mc)
>   {
>       mc->desc = "MIPS MIPSsim platform";
>       mc->init = mips_mipssim_init;
> +#ifdef TARGET_MIPS64
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("5Kf");
> +#else
> +    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
> +#endif
>   }
>   
>   DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
> 
