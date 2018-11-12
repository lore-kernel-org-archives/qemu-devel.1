Received: from eggs.gnu.org ([2001:4830:134:3::10]:34047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMFo5-0001t1-0A
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gMFny-0000uD-Lx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:15:24 -0500
Date: Mon, 12 Nov 2018 18:14:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181112181454.13efd2af.cohuck@redhat.com>
In-Reply-To: <20181105110313.29312-1-david@redhat.com>
References: <20181105110313.29312-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/4] s390x/zpci: some hotplug handler
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

On Mon,  5 Nov 2018 12:03:09 +0100
David Hildenbrand <david@redhat.com> wrote:

> The hotplug code needs more love, but let's do some obvious cleanups
> first. In the future, we want to propery make use of unplug_request() +
> unplug(), instead of routing everything (especially two separate but
> linked) devices via a single unplug call. Also, we want to move all
> errors in plug() into the pre_plug() handler, but this will require
> general PCI refactorings (moving stuff from realize() to the pre_plug/plug
> handler).
> 
> This series is based on "[PATCH v2 00/10] pci: hotplug handler reworks",
> which contains one cleanup for s390x.
> 
> David Hildenbrand (4):
>   s390x/zpci: drop msix.available

queued to s390-next

>   s390x/zpci: use hotplug_dev instead of looking up the host bridge

Do we have consensus on that one yet? I can take it or leave it :)

>   s390x/zpci: move some hotplug checks to the pre_plug handler

depends on the handler rework

>   s390x/zpci: properly fail if the zPCI device cannot be created

Waiting for a fixed patch... can queue to s390-fixes if it arrives
soon(tm).

> 
>  hw/s390x/s390-pci-bus.c | 74 ++++++++++++++++++++++++++---------------
>  hw/s390x/s390-pci-bus.h |  1 -
>  2 files changed, 47 insertions(+), 28 deletions(-)
> 
