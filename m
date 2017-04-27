Received: from eggs.gnu.org ([2001:4830:134:3::10]:47055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3fnk-0002gE-Ti
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3fng-0003b7-V1
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:33:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3fng-0003az-ON
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:33:24 -0400
Date: Thu, 27 Apr 2017 10:33:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170427093315.GI5346@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
	<20170427092715.s2tsewyxlpoumeyn@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427092715.s2tsewyxlpoumeyn@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: He Chen <he.chen@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Apr 27, 2017 at 11:27:15AM +0200, Andrew Jones wrote:
> On Thu, Apr 27, 2017 at 10:35:58AM +0800, He Chen wrote:
> > This patch is going to add SLIT table support in QEMU, and provides
> > additional option `dist` for command `-numa` to allow user set vNUMA
> > distance by QEMU command.
> > 
> > With this patch, when a user wants to create a guest that contains
> > several vNUMA nodes and also wants to set distance among those nodes,
> > the QEMU command would like:
> > 


> >  #define MAX_NODES 128
> >  #define NUMA_NODE_UNASSIGNED MAX_NODES
> > +#define NUMA_DISTANCE_MIN         10
> > +#define NUMA_DISTANCE_DEFAULT     20
> > +#define NUMA_DISTANCE_MAX         254
> > +#define NUMA_DISTANCE_UNREACHABLE 255


> > +# @NumaDistOptions:
> > +#
> > +# Set the distance between 2 NUMA nodes.
> > +#
> > +# @src: source NUMA node.
> > +#
> > +# @dst: destination NUMA node.
> > +#
> > +# @val: NUMA distance from source node to destination node.
> > +#       When a node is unreachable from another node, set the distance
> > +#       between them to 255.

We should probably also document that @val must be greater than 10,
unless src == dst, in which case it must be equal to 10.

> > +#
> > +# Since: 2.10
> > +##
> > +{ 'struct': 'NumaDistOptions',
> > +  'data': {
> > +   'src': 'uint16',
> > +   'dst': 'uint16',
> > +   'val': 'uint8' }}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
