Received: from eggs.gnu.org ([2001:4830:134:3::10]:35740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNIo-0003Sr-1B
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNIk-0000bp-KA
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:32:02 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzNIk-0000b8-Fp
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:31:58 -0400
Received: by mail-qt0-x244.google.com with SMTP id k1so1952868qti.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:31:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-11-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d10925c9-b988-157d-5132-c68d0f04f745@amsat.org>
Date: Tue, 3 Oct 2017 10:31:54 -0300
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/38] m68k: an5206: use generic cpu_model
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
> CC: huth@tuxfamily.org
> CC: laurent@vivier.eu
> ---
>  hw/m68k/an5206.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 9002c46..0cedc54 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -28,7 +28,6 @@
>  static void an5206_init(MachineState *machine)
>  {
>      ram_addr_t ram_size = machine->ram_size;
> -    const char *cpu_model = machine->cpu_model;
>      const char *kernel_filename = machine->kernel_filename;
>      M68kCPU *cpu;
>      CPUM68KState *env;
> @@ -39,10 +38,7 @@ static void an5206_init(MachineState *machine)
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>  
> -    if (!cpu_model) {
> -        cpu_model = "m5206";
> -    }
> -    cpu = M68K_CPU(cpu_generic_init(TYPE_M68K_CPU, cpu_model));
> +    cpu = M68K_CPU(cpu_create(machine->cpu_type));
>      env = &cpu->env;
>  
>      /* Initialize CPU registers.  */
> @@ -94,6 +90,7 @@ static void an5206_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Arnewsh 5206";
>      mc->init = an5206_init;
> +    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
>  }
>  
>  DEFINE_MACHINE("an5206", an5206_machine_init)
> 
