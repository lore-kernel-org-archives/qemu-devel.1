Received: from eggs.gnu.org ([2001:4830:134:3::10]:54617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7MM-0005oV-GE
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7MI-0007z0-CY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:30:38 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dz7MI-0007yK-8F
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 16:30:34 -0400
Received: by mail-qk0-x243.google.com with SMTP id z12so1469893qkb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 13:30:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-29-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <89e4ce2c-56f7-5b93-bbcc-0e8083de6bc7@amsat.org>
Date: Mon, 2 Oct 2017 17:30:30 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-29-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 28/38] tricore: use generic cpu_model
 parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 06:08 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   hw/tricore/tricore_testboard.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
> index 0486f8a..ac75eb2 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -71,10 +71,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
>       MemoryRegion *pcp_data = g_new(MemoryRegion, 1);
>       MemoryRegion *pcp_text = g_new(MemoryRegion, 1);
>   
> -    if (!machine->cpu_model) {
> -        machine->cpu_model = "tc1796";
> -    }
> -    cpu = TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, machine->cpu_model));
> +    cpu = TRICORE_CPU(cpu_create(machine->cpu_type));
>       env = &cpu->env;
>       memory_region_init_ram(ext_cram, NULL, "powerlink_ext_c.ram",
>                              2 * 1024 * 1024, &error_fatal);
> @@ -114,6 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
>       mc->desc = "a minimal TriCore board";
>       mc->init = tricoreboard_init;
>       mc->is_default = 0;
> +    mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
>   }
>   
>   DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
> 
