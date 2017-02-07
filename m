Received: from eggs.gnu.org ([2001:4830:134:3::10]:34465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7bC-0006WB-NP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb7b9-0002pC-LE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:22:30 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cb7b9-0002om-FY
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:22:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so28836965wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:22:27 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dab84ac0-cb75-c026-2644-babc87d88acc@redhat.com>
Date: Tue, 7 Feb 2017 16:22:24 +0100
MIME-Version: 1.0
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] virtio: use MemoryRegionCache for
 descriptors and rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com



On 27/01/2017 16:40, Paolo Bonzini wrote:
> A few fixes caught by "make check" (yes, brown paper bag).
> 
> Paolo
> 
> v2->v3: patch 1 committed already (replaced by new patch 1)
> 	fix error handling in patch 3
> 	fix freeing uninitialized VRingMemoryRegionCache (patch 7)
> 	new patch 8
> 
> Paolo Bonzini (9):
>   memory: make memory_listener_unregister idempotent
>   virtio: add virtio_*_phys_cached
>   virtio: use address_space_map/unmap to access descriptors
>   exec: make address_space_cache_destroy idempotent
>   virtio: use MemoryRegionCache to access descriptors
>   virtio: add MemoryListener to cache ring translations
>   virtio: use VRingMemoryRegionCaches for descriptor ring
>   virtio: check for ring setup in virtio_queue_update_used_idx
>   virtio: use VRingMemoryRegionCaches for avail and used rings
> 
>  exec.c                            |   1 +
>  hw/net/virtio-net.c               |  14 +-
>  hw/virtio/virtio.c                | 338 ++++++++++++++++++++++++++++++--------
>  include/exec/memory.h             |   2 +
>  include/hw/virtio/virtio-access.h |  52 ++++++
>  include/hw/virtio/virtio.h        |   1 +
>  memory.c                          |   5 +
>  7 files changed, 345 insertions(+), 68 deletions(-)
> 

Ping?

Paolo
