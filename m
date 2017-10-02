Received: from eggs.gnu.org ([2001:4830:134:3::10]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Am-0000aI-3G
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Aj-0000KE-EB
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:40 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:37670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7Aj-0000JP-9K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:18:37 -0400
Received: by mail-qk0-x243.google.com with SMTP id a12so1925329qka.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:18:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-27-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d0a2fc29-5ade-d86d-edf5-dd92da95605e@amsat.org>
Date: Mon, 2 Oct 2017 17:18:33 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-27-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/38] unicore32: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
>   hw/unicore32/puv3.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 504ea46..1b39cc0 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -112,7 +112,6 @@ static void puv3_load_kernel(const char *kernel_filename)
>   static void puv3_init(MachineState *machine)
>   {
>       ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>       const char *kernel_filename = machine->kernel_filename;
>       const char *initrd_filename = machine->initrd_filename;
>       CPUUniCore32State *env;
> @@ -123,11 +122,7 @@ static void puv3_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    if (!cpu_model) {
> -        cpu_model = "UniCore-II";
> -    }
> -
> -    cpu = UNICORE32_CPU(cpu_generic_init(TYPE_UNICORE32_CPU, cpu_model));
> +    cpu = UNICORE32_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>   
>       puv3_soc_init(env);
> @@ -140,6 +135,7 @@ static void puv3_machine_init(MachineClass *mc)
>       mc->desc = "PKUnity Version-3 based on UniCore32";
>       mc->init = puv3_init;
>       mc->is_default = 1;
> +    mc->default_cpu_type = UNICORE32_CPU_TYPE_NAME("UniCore-II");
>   }
>   
>   DEFINE_MACHINE("puv3", puv3_machine_init)
> 
