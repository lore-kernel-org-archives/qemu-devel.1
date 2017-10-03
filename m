Received: from eggs.gnu.org ([2001:4830:134:3::10]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTz4-0001un-Ea
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzTz1-0004q1-4L
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:40:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzTz0-0004on-UJ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 16:40:03 -0400
Date: Tue, 3 Oct 2017 17:39:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003203956.GE4760@localhost.localdomain>
References: <cover.1507059418.git.alistair.francis@xilinx.com>
	<a418ab36b8beecb9df9886b283c6bbedaf94bb68.1507059418.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a418ab36b8beecb9df9886b283c6bbedaf94bb68.1507059418.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/5] raspi: : Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

On Tue, Oct 03, 2017 at 01:05:18PM -0700, Alistair Francis wrote:
> List all possible valid CPU options.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/arm/raspi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 5941c9f751..555db0f258 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -158,6 +158,10 @@ static void raspi2_init(MachineState *machine)
>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>  }
>  
> +const char *raspi2_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-a7"),
> +                                    NULL
> +                                  };
> +
>  static void raspi2_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Raspberry Pi 2";
> @@ -169,5 +173,7 @@ static void raspi2_machine_init(MachineClass *mc)
>      mc->max_cpus = BCM2836_NCPUS;
>      mc->default_ram_size = 1024 * 1024 * 1024;
>      mc->ignore_memory_transaction_failures = true;
> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
> +    mc->valid_cpu_types = raspi2_valid_cpus;

I'm confused: bcm2836_init() is hardcoded to cortex-a15, not
cortex-a7.

>  };
>  DEFINE_MACHINE("raspi2", raspi2_machine_init)
> -- 
> 2.11.0
> 

-- 
Eduardo
