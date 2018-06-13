Received: from eggs.gnu.org ([2001:4830:134:3::10]:35437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT20b-0004vk-At
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT20W-0005xq-Dy
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:24:05 -0400
Date: Wed, 13 Jun 2018 11:23:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613112357.26dfcea5@redhat.com>
In-Reply-To: <20180611121655.19616-2-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/11] pc-dimm: remove leftover "struct
 pc_dimms_capacity"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Jun 2018 14:16:45 +0200
David Hildenbrand <david@redhat.com> wrote:

> Not needed anymore, let's drop it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/pc-dimm.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 12da89d562..62b34a992e 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,11 +27,6 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
>  
> -typedef struct pc_dimms_capacity {
> -     uint64_t size;
> -     Error    **errp;
> -} pc_dimms_capacity;
> -
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp)
>  {
