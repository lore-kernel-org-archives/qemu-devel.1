Received: from eggs.gnu.org ([209.51.188.92]:38491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx8G1-0006RH-CE
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx8Fv-0004FO-NL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:40:37 -0500
Date: Fri, 22 Feb 2019 11:40:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222114013.5ee11757@redhat.com>
In-Reply-To: <20190220224003.4420-7-eric.auger@redhat.com>
References: <20190220224003.4420-1-eric.auger@redhat.com>
	<20190220224003.4420-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 06/17] vl: Set machine ram_size,
 maxram_size and ram_slots earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

On Wed, 20 Feb 2019 23:39:52 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> The machine RAM attributes will need to be analyzed during the
> configure_accelerator() process. especially kvm_type() arm64
> machine callback will use them to know how many IPA/GPA bits are
> needed to model the whole RAM range. So let's assign those machine
> state fields before calling configure_accelerator.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> v6 -> v7:
> - add Peter's R-b
> 
> v4: new
> ---
>  vl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 502857a176..fd0d51320d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4239,6 +4239,9 @@ int main(int argc, char **argv, char **envp)
>      machine_opts = qemu_get_machine_opts();
>      qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
>                       &error_fatal);
> +    current_machine->ram_size = ram_size;
> +    current_machine->maxram_size = maxram_size;
> +    current_machine->ram_slots = ram_slots;
>  
>      configure_accelerator(current_machine, argv[0]);
>  
> @@ -4434,9 +4437,6 @@ int main(int argc, char **argv, char **envp)
>      replay_checkpoint(CHECKPOINT_INIT);
>      qdev_machine_init();
>  
> -    current_machine->ram_size = ram_size;
> -    current_machine->maxram_size = maxram_size;
> -    current_machine->ram_slots = ram_slots;
>      current_machine->boot_order = boot_order;
>  
>      /* parse features once if machine provides default cpu_type */
