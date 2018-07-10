Received: from eggs.gnu.org ([2001:4830:134:3::10]:55800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcrQ6-00049v-A2
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcrQ1-0005nM-Mk
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 08:07:02 -0400
Date: Tue, 10 Jul 2018 14:06:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180710140655.00742582@redhat.com>
In-Reply-To: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
References: <20180710105129.23296-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration() follow-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, ehabkost@redhat.com

On Tue, 10 Jul 2018 18:51:29 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> This Commit 7747abf11487 misses the curly brackets. Follow Igor's and Eduardo's suggestion,
> 
> Add a follow-up patch for it.
> 
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  hw/core/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a9aeb22f03..6b68e1218f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -793,8 +793,9 @@ void machine_run_board_init(MachineState *machine)
>      MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>  
>      numa_complete_configuration(machine);
> -    if (nb_numa_nodes)
> +    if (nb_numa_nodes) {
>          machine_numa_finish_cpu_init(machine);
> +    }
>  
>      /* If the machine supports the valid_cpu_types check and the user
>       * specified a CPU with -cpu check here that the user CPU is supported.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
