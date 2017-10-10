Received: from eggs.gnu.org ([2001:4830:134:3::10]:44540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1vHM-0007Wp-Fi
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1vHH-0001Ot-9f
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:13:04 -0400
Date: Tue, 10 Oct 2017 16:12:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171010161244.056fef78@nial.brq.redhat.com>
In-Reply-To: <20171010133241.11330-1-lvivier@redhat.com>
References: <20171010133241.11330-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: remove useless hot_add_cpu
 initialisation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>

On Tue, 10 Oct 2017 15:32:41 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Since 4458fb3a79 (pc: Eliminate pc_default_machine_options()),
> hot_add_cpu is set in pc_machine_class_init(), so we don't
> need to set it in pc_q35_machine_options(), pc_i440fx_machine_options()
> and xenfv_machine_options(), except to clear it in
> pc_i440fx_1_4_machine_opt().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 2 --
>  hw/i386/pc_q35.c  | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9ff79b1fd9..caf166aede 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -428,7 +428,6 @@ static void pc_i440fx_machine_options(MachineClass *m)
>  {
>      m->family = "pc_piix";
>      m->desc = "Standard PC (i440FX + PIIX, 1996)";
> -    m->hot_add_cpu = pc_hot_add_cpu;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
>  }
> @@ -1123,7 +1122,6 @@ static void xenfv_machine_options(MachineClass *m)
>      m->desc = "Xen Fully-virtualized PC";
>      m->max_cpus = HVM_MAX_VCPUS;
>      m->default_machine_opts = "accel=xen";
> -    m->hot_add_cpu = pc_hot_add_cpu;
>  }
>  
>  DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6c4ec4be4e..da3ea602e1 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -295,7 +295,6 @@ static void pc_q35_machine_options(MachineClass *m)
>  {
>      m->family = "pc_q35";
>      m->desc = "Standard PC (Q35 + ICH9, 2009)";
> -    m->hot_add_cpu = pc_hot_add_cpu;
>      m->units_per_default_bus = 1;
>      m->default_machine_opts = "firmware=bios-256k.bin";
>      m->default_display = "std";
