Received: from eggs.gnu.org ([2001:4830:134:3::10]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dzJJD-0004yu-Qi
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dzJJ4-0001Ot-6U
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:16:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dzJJ4-0001Iy-0V
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:16:02 -0400
Received: by mail-wr0-f194.google.com with SMTP id y44so417209wry.2
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 02:16:01 -0700 (PDT)
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-11-git-send-email-imammedo@redhat.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <3c74a15e-d7a7-6553-c1e3-b9afa306260f@tuxfamily.org>
Date: Tue, 3 Oct 2017 11:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-11-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, laurent@vivier.eu

On 02.10.2017 11:07, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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

Acked-by: Thomas Huth <huth@tuxfamily.org>
