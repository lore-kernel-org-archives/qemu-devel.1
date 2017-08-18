Received: from eggs.gnu.org ([2001:4830:134:3::10]:37991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimot-0005Rd-98
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimoo-0004J0-Ik
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dimoo-0004If-C3
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:20:30 -0400
Date: Fri, 18 Aug 2017 16:20:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818192023.GH3108@localhost.localdomain>
References: <1502847935-20483-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170818213432-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818213432-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3] hw/acpi-build: Fix SRAT memory building
 when there is no memory in node0
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

On Fri, Aug 18, 2017 at 09:35:00PM +0300, Michael S. Tsirkin wrote:
> On Wed, Aug 16, 2017 at 09:45:35AM +0800, Dou Liyang wrote:
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
> This isn't a regression, is it? If it isn't, it's not a 2.10 candidate
> IMHO.

As noted in another reply to v2, I agree and I'm treating it as a
2.11 candidate.

-- 
Eduardo
