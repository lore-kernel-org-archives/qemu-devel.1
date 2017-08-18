Received: from eggs.gnu.org ([2001:4830:134:3::10]:37287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimlG-0002Yi-OA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimlC-0001JJ-2j
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dimlB-0001HS-TC
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:16:46 -0400
Date: Fri, 18 Aug 2017 16:16:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818191641.GF3108@localhost.localdomain>
References: <1502846811-32360-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170818212833-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818212833-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2] hw/acpi: Select an node with memory for
 mapping memory hole to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, imammedo@redhat.com

On Fri, Aug 18, 2017 at 09:28:55PM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 16, 2017 at 09:26:51AM +0800, Dou Liyang wrote:
> > Currently, Using the fisrt node without memory on the machine makes
> > QEMU unhappy. With this example command line:
> >   ... \
> >   -m 1024M,slots=4,maxmem=32G \
> >   -numa node,nodeid=0 \
> >   -numa node,mem=1024M,nodeid=1 \
> >   -numa node,nodeid=2 \
> >   -numa node,nodeid=3 \
> > Guest reports "No NUMA configuration found" and the NUMA topology is
> > wrong.
> > 
> > This is because when QEMU builds ACPI SRAT, it regards node0 as the
> > default node to deal with the memory hole(640K-1M). this means the
> > node0 must have some memory(>1M), but, actually it can have no
> > memory.
> > 
> > Fix this problem by replace the node0 with the first node which has
> > memory on it. Add a new function for each node. Also do some cleanup.
> > 
> > Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> 
> This isn't a regression, is it?
> If so I think it's safe to postpone this to 2.11.

Agreed.  I was already treating it as a candidate for 2.11 only.

-- 
Eduardo
