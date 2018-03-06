Received: from eggs.gnu.org ([2001:4830:134:3::10]:38123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et9ZT-0004ob-T9
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1et9ZM-000562-97
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 05:11:47 -0500
Date: Tue, 6 Mar 2018 11:11:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180306111127.2a363304.cohuck@redhat.com>
In-Reply-To: <20180227110255.20999-1-david@redhat.com>
References: <20180227110255.20999-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] numa: we don't implement NUMA for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 27 Feb 2018 12:02:55 +0100
David Hildenbrand <david@redhat.com> wrote:

> Right now it is possible to crash QEMU for s390x by providing e.g.
>     -numa node,nodeid=0,cpus=0-1
> 
> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> indicator whether NUMA is supported by a machine type. We don't
> implement NUMA for s390x ("topology") yet. However we need
> mc->cpu_index_to_instance_props for query-cpus.
> 
> So let's fix this case by also checking for mc->get_default_cpu_node_id,
> which will be needed by machine_set_cpu_numa_node().
> 
> qemu-system-s390x: -numa node,nodeid=0,cpus=0-1: NUMA is not supported by
>                    this machine-type
> 
> While at it, make s390_cpu_index_to_props() look like on other
> architectures.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 8 +++++---
>  numa.c                     | 2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)

Thanks, applied.
