Received: from eggs.gnu.org ([2001:4830:134:3::10]:47139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0R7e-0002eq-KB
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0R7d-0002H6-QZ
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0R7d-0002Gp-K4
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 08:53:25 -0400
Date: Thu, 13 Sep 2018 14:53:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180913145314.2b4fa0aa@redhat.com>
In-Reply-To: <20180829153624.12299-7-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/20] memory-device: document
 MemoryDeviceClass
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

On Wed, 29 Aug 2018 17:36:10 +0200
David Hildenbrand <david@redhat.com> wrote:

> Document the functions and when to not expect errors.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/hw/mem/memory-device.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> index 852fd8f98a..d353564faf 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -29,9 +29,22 @@ typedef struct MemoryDeviceState {
>      Object parent_obj;
>  } MemoryDeviceState;
>  
> +/**
> + * MemoryDeviceClass:
> + * @get_addr: The address of the @md in guest physical memory. "0" means that
> + * no address has been specified by the user and that no address has been
> + * assigned yet.
> + * @get_plugged_size: The amount of memory provided by this @md currently
> + * usable ("plugged") by the guest. Will not fail after the device was realized.
I'd drop 'Will not fail after the device was realized'

> + * @get_memory_region: The memory region of the @md to mapped in guest
s/to mapped/that's mapped/

> + * physical memory at @get_addr. Will not fail after the device was realized.
the same

> + * @fill_device_info: Fill out #MemoryDeviceInfo with @md specific information.
maybe:
translate current @md state into #MemoryDeviceInfo


> + */
>  typedef struct MemoryDeviceClass {
> +    /* private */
>      InterfaceClass parent_class;
>  
> +    /* public */
>      uint64_t (*get_addr)(const MemoryDeviceState *md);
>      uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
>      MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
