Received: from eggs.gnu.org ([209.51.188.92]:39225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go7bf-0005v0-WF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go7bf-0004cv-Co
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:09:47 -0500
Date: Mon, 28 Jan 2019 15:09:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128150927.2b2fee28.cohuck@redhat.com>
In-Reply-To: <20190123195527.29575-6-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 5/9] virtio-pci: Allow to specify
 additional interfaces for the base type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, 23 Jan 2019 20:55:23 +0100
David Hildenbrand <david@redhat.com> wrote:

> Let's allow to specify additional interfaces for the base type (e.g.
> later TYPE_MEMORY_DEVICE), something that was possible before the
> rework of virtio PCI device instantiation.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 1 +
>  hw/virtio/virtio-pci.h | 1 +
>  2 files changed, 2 insertions(+)

Sounds reasonable.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
