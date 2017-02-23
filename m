Received: from eggs.gnu.org ([2001:4830:134:3::10]:34373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgq1T-0001aW-1B
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cgq1S-0006R4-Dv
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:49:15 -0500
References: <20170223091845.18523-1-famz@redhat.com>
	<20170223091845.18523-3-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b59e8052-971c-d6ff-de1d-7758adc01d91@redhat.com>
Date: Thu, 23 Feb 2017 10:49:06 +0100
MIME-Version: 1.0
In-Reply-To: <20170223091845.18523-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] stubs: Add stubs for ram block
 notifier API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Karl Rister <krister@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org



On 23/02/2017 10:18, Fam Zheng wrote:
> These two functions will be wanted by block-obj-y but the actual
> definition is in obj-y which is correctly placed, so stub them to keep
> the linker happy.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  stubs/Makefile.objs        |  1 +
>  stubs/ram-block-notifier.c | 10 ++++++++++
>  2 files changed, 11 insertions(+)
>  create mode 100644 stubs/ram-block-notifier.c
> 
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index aa6050f..38e3bdc 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -36,3 +36,4 @@ stub-obj-y += qmp_pc_dimm_device_list.o
>  stub-obj-y += target-monitor-defs.o
>  stub-obj-y += target-get-monitor-def.o
>  stub-obj-y += pc_madt_cpu_entry.o
> +stub-obj-y += ram-block-notifier.o
> diff --git a/stubs/ram-block-notifier.c b/stubs/ram-block-notifier.c
> new file mode 100644
> index 0000000..ea5d528
> --- /dev/null
> +++ b/stubs/ram-block-notifier.c
> @@ -0,0 +1,10 @@
> +#include "qemu/osdep.h"
> +#include "exec/ramlist.h"
> +
> +void ram_block_notifier_add(RAMBlockNotifier *n)
> +{
> +}
> +
> +void ram_block_notifier_remove(RAMBlockNotifier *n)
> +{
> +}
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
