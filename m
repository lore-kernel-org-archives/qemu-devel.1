Received: from eggs.gnu.org ([209.51.188.92]:51503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYH3-0007Fh-Un
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hEYH2-0007b9-UJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 07:53:45 -0400
Date: Thu, 11 Apr 2019 13:53:38 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190411135338.535472e2@redhat.com>
In-Reply-To: <a832ae5e252c58c1ac4dd99d7d164fdb0de70f10.1554937288.git.alistair.francis@wdc.com>
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<a832ae5e252c58c1ac4dd99d7d164fdb0de70f10.1554937288.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 4/6] riscv: virt: Allow
 specifying a CPU via commandline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

On Wed, 10 Apr 2019 23:10:42 +0000
Alistair Francis <Alistair.Francis@wdc.com> wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/riscv/virt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fc4c6b306e..5b25f028ad 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -400,7 +400,7 @@ static void riscv_virt_board_init(MachineState *machine)
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
>                              TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->soc), VIRT_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
>                              &error_abort);
> @@ -526,6 +526,7 @@ static void riscv_virt_board_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
>      mc->init = riscv_virt_board_init;
>      mc->max_cpus = 8; /* hardcoded limit in BBL */
> +    mc->default_cpu_type = VIRT_CPU;
>  }
>  
>  DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
