Received: from eggs.gnu.org ([2001:4830:134:3::10]:40249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fbTXj-0000cP-6b
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fbTXi-0001gf-EQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:25:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fbTXi-0001eq-3q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:25:10 -0400
Date: Fri, 6 Jul 2018 19:25:04 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180706192326-mutt-send-email-mst@kernel.org>
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705133044.634ede43@t450s.home>
	<b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
	<20180706015113.GC23001@xz-mi>
	<9ae66133-86a6-72d8-cd66-f27592caffe9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae66133-86a6-72d8-cd66-f27592caffe9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Fri, Jul 06, 2018 at 05:55:23PM +0200, Paolo Bonzini wrote:
> On 06/07/2018 03:51, Peter Xu wrote:
> > 
> > A question about memory region auto destruction (which might not
> > related to this patch): I see that we have object_property_add_child()
> > in memory_region_do_init() to achieve the auto destruction but only if
> > the "name" of memory region is specified.  Could we just do that
> > unconditionally (though we might of course need to generate some of
> > the names), or is there a reason not to do so?
> 
> I'm not sure actually if there are still regions without a name...
> 
> Paolo

Answer to Peter's question would be a yes then?

With all the autodestruct I'm unsure when is calling vmstate_unregister_ram appropriate.
Is it necessary to invoke that from pci any longer?

-- 
MST
