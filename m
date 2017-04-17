Received: from eggs.gnu.org ([2001:4830:134:3::10]:43366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1czzJu-0006zq-Ai
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 01:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <he.chen@linux.intel.com>) id 1czzJr-0004eq-6t
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 01:35:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:17031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <he.chen@linux.intel.com>)
	id 1czzJq-0004eM-TY
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 01:35:23 -0400
Date: Mon, 17 Apr 2017 13:36:07 +0800
From: He Chen <he.chen@linux.intel.com>
Message-ID: <20170417053607.GA29789@he>
References: <1491900566-32222-1-git-send-email-he.chen@linux.intel.com>
	<173a855f-1ca7-e680-a39c-c5e6bce310be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173a855f-1ca7-e680-a39c-c5e6bce310be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Apr 11, 2017 at 08:18:49AM -0500, Eric Blake wrote:
> On 04/11/2017 03:49 AM, He Chen wrote:
> > This patch is going to add SLIT table support in QEMU, and provides
> > additional option `dist` for command `-numa` to allow user set vNUMA
> > distance by QEMU command.
> > 
> > With this patch, when a user wants to create a guest that contains
> > several vNUMA nodes and also wants to set distance among those nodes,
> > the QEMU command would like:
> > 
> > ```
> > -numa node,nodeid=0,cpus=0 \
> > -numa node,nodeid=1,cpus=1 \
> > -numa node,nodeid=2,cpus=2 \
> > -numa node,nodeid=3,cpus=3 \
> > -numa dist,src=0,dst=1,val=21 \
> > -numa dist,src=0,dst=2,val=31 \
> > -numa dist,src=0,dst=3,val=41 \
> > -numa dist,src=1,dst=2,val=21 \
> > -numa dist,src=1,dst=3,val=31 \
> > -numa dist,src=2,dst=3,val=21 \
> > ```
> > 
> > Signed-off-by: He Chen <he.chen@linux.intel.com>
> > ---
> 
> Here is where you should mention what changed since v5, to help focus
> the attention of reviewers that have read earlier versions.
> 

Oh, sorry.
Changes since v5:
* Made the generation of the SLIT dependent on `have_numa_distance`.
* Doc refinement.
> > +++ b/qapi-schema.json
> 
> >  ##
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
> 
> Still no mention that distances less than 10 are invalid, or that a node
> to itself defaults to 10 and can't be changed, or that other distances
> default to 20.  But that starts to get complex enough, and you cover it
> elsewhere, so I'm okay with what you have here.
> 
> Interface looks sane, but I'll leave others to do the code review.
> 
Is there anything I need to do to improve this patch? Still need another
version patch or just wait for the code review?

Thanks,
-He
