Received: from eggs.gnu.org ([209.51.188.92]:59739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAo5-0002Rv-2c
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghAo4-0001td-ES
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:09:53 -0500
References: <20181224154922.3338-1-wainersm@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f2dae419-462b-71c3-5918-ebee55397b5f@vivier.eu>
Date: Wed, 9 Jan 2019 11:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181224154922.3338-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/core: fix whitespace in
 a sentence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com

On 24/12/2018 16:49, Wainer dos Santos Moschetta wrote:
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4439ea663f..a0beeeb2a9 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -591,7 +591,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "dump-guest-core",
>          machine_get_dump_guest_core, machine_set_dump_guest_core, &error_abort);
>      object_class_property_set_description(oc, "dump-guest-core",
> -        "Include guest memory in  a core dump", &error_abort);
> +        "Include guest memory in a core dump", &error_abort);
>  
>      object_class_property_add_bool(oc, "mem-merge",
>          machine_get_mem_merge, machine_set_mem_merge, &error_abort);
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
