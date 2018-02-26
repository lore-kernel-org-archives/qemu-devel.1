Received: from eggs.gnu.org ([2001:4830:134:3::10]:41250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqG7y-00037k-C8
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqG7v-0006k3-7w
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:35:26 -0500
Date: Mon, 26 Feb 2018 11:35:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180226113503.6ecfa712.cohuck@redhat.com>
In-Reply-To: <f8266a54-7b02-020b-b742-f7b81ed987ab@redhat.com>
References: <20180223173657.29125-1-david@redhat.com>
	<20180226111953.1e9bc50c.cohuck@redhat.com>
	<f8266a54-7b02-020b-b742-f7b81ed987ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] numa: s390x has no NUMA
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

On Mon, 26 Feb 2018 11:28:26 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 26.02.2018 11:19, Cornelia Huck wrote:
> > On Fri, 23 Feb 2018 18:36:57 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Right now it is possible to crash QEMU for s390x by providing e.g.
> >>     -numa node,nodeid=0,cpus=0-1
> >>
> >> Problem is, that numa.c uses mc->cpu_index_to_instance_props as an
> >> indicator whether NUMA is supported by a machine type. We don't
> >> implement NUMA on s390x (and that concept also doesn't really exist).
> >> We need mc->cpu_index_to_instance_props for query-cpus.  
> > 
> > Is existence of cpu_index_to_instance_probs the correct indicator for
> > numa, then?
> > 
> > OTOH, your patch is straightforward...  
> 
> Maybe it is get_default_cpu_node_id as Christian discovered?

Yes, that seems like a better candidate for checking.
