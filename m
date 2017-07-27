Received: from eggs.gnu.org ([2001:4830:134:3::10]:33921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1daoEi-0004yK-AL
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1daoEf-0006Bq-NB
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1daoEf-00068X-HH
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:14:13 -0400
Date: Thu, 27 Jul 2017 12:14:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170727060241.GA9327@aepfle.de>
Message-ID: <alpine.DEB.2.10.1707271204500.22381@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
	<1498601083-11799-1-git-send-email-sstabellini@kernel.org>
	<1498601083-11799-3-git-send-email-sstabellini@kernel.org>
	<20170727060241.GA9327@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [Xen-devel] [PULL 3/3] xen-disk: add support for
 multi-page shared rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On Thu, 27 Jul 2017, Olaf Hering wrote:
> On Tue, Jun 27, Stefano Stabellini wrote:
> 
> > From: Paul Durrant <paul.durrant@citrix.com>
> > The blkif protocol has had provision for negotiation of multi-page shared
> > rings for some time now and many guest OS have support in their frontend
> > drivers.
> 
> > +++ b/hw/block/xen_disk.c
> 
> > +    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> 
> According to [1] g_malloc0_n requires at least glib-2.24. As a result
> compilation of qemu-2.10 fails in SLE11, which has just glib-2.22.
> 
> Olaf
> 
> [1] https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html

It looks like QEMU supports glib 2.22, so this ought to work. In fact
the only user of g_malloc0_n is xen_disk.c. I would be happy to take a
patch that replaces g_malloc0_n with g_malloc0.
