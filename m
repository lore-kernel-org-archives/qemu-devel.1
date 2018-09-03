Received: from eggs.gnu.org ([2001:4830:134:3::10]:49605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwowu-0007IK-5S
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwowr-0004K0-Df
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:31:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fwowr-0004FY-3v
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:31:21 -0400
Date: Mon, 3 Sep 2018 15:31:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180903153106.6a957948@redhat.com>
In-Reply-To: <20180829153624.12299-3-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/20] memory-device: use memory device
 terminology in error messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

On Wed, 29 Aug 2018 17:36:06 +0200
David Hildenbrand <david@redhat.com> wrote:

> While we rephrased most error messages, we missed these.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/memory-device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index efacbc2a7d..0d9892b715 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -87,7 +87,7 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
>      memory_device_used_region_size(OBJECT(ms), &used_region_size);
>      if (used_region_size + size > ms->maxram_size - ms->ram_size) {
>          error_setg(errp, "not enough space, currently 0x%" PRIx64
> -                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
> +                   " in use of total space for memory devices 0x" RAM_ADDR_FMT,
>                     used_region_size, ms->maxram_size - ms->ram_size);
>          return;
>      }
> @@ -145,12 +145,12 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>      if (hint) {
>          new_addr = *hint;
>          if (new_addr < address_space_start) {
> -            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
> +            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
>                         "] before 0x%" PRIx64, new_addr, size,
>                         address_space_start);
>              return 0;
>          } else if ((new_addr + size) > address_space_end) {
> -            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
> +            error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64
>                         "] beyond 0x%" PRIx64, new_addr, size,
>                         address_space_end);
>              return 0;
