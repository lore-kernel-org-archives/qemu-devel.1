Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chGne-0000sO-8N
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1chGna-000303-I8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1chGna-0002zo-Bx
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:24:42 -0500
References: <20170222163734.13104-1-stefanha@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3455495c-2375-0327-a46d-3eeaa1e1aad6@redhat.com>
Date: Fri, 24 Feb 2017 15:24:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170222163734.13104-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] virtio: migration fixes for memory
 region cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Stephan,

On 22/02/2017 17:37, Stefan Hajnoczi wrote:
> v2:
>  * Avoid early region cache initialization in virtio_load() with wrong ring
>    addresses for VIRTIO-1 in Patch 2 [Cornelia]
> 
> Bug fixes for the recently added memory region cache in virtio.  This series
> fixes live migration, see patches for details.
> 
> Stefan Hajnoczi (2):
>   virtio: invalidate memory in vring_set_avail_event()
>   virtio: add missing region cache init in virtio_load()
> 
>  hw/virtio/virtio.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 

For me this fixes virtio-net migration issue caused by "virtio: use
VRingMemoryRegionCaches for avail and used rings".

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
