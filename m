Received: from eggs.gnu.org ([2001:4830:134:3::10]:38552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ev8GX-0001tN-62
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 17:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ev8GT-00049t-5J
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 17:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ev8GS-00049D-Um
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 17:12:21 -0400
Date: Sun, 11 Mar 2018 14:12:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20180309125833.GI3417@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1803111409550.23583@sstabellini-ThinkPad-X260>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180308200345.GD3417@localhost.localdomain>
	<23202.28943.344150.512881@mariner.uk.xensource.com>
	<23202.30969.590920.764930@mariner.uk.xensource.com>
	<20180309125833.GI3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 03/11] xen: defer call to xen_restrict
 until just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Ian Jackson <ian.jackson@citrix.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, 9 Mar 2018, Eduardo Habkost wrote:
> On Fri, Mar 09, 2018 at 12:07:21PM +0000, Ian Jackson wrote:
> > Ian Jackson writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> > > Eduardo Habkost writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> > > > I don't think we should have accelerator-specific code in main(),
> > > > if we already have accelerator classes that can abstract that
> > > > out.  I suggest adding a AccelClass;:setup_post() method that can
> > > > be called here.
> > > 
> > > I think I can do that.
> > 
> > How about this ?
> > 
> > From 61f11221afaa29e10021599420238e03836ba413 Mon Sep 17 00:00:00 2001
> > From: Ian Jackson <ian.jackson@eu.citrix.com>
> > Date: Fri, 9 Mar 2018 12:02:50 +0000
> > Subject: [PATCH v6.2 12/11] AccelClass: Introduce accel_setup_post
> > 
> > This is called just before os_setup_post.  Currently none of the
> > accelerators provide this hook, but the Xen one is going to provide
> > one in a moment.
> > 
> > Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> 
> Looks good to me.
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> That said, I don't think this should block the inclusion of the
> previous patch in 2.12, if the Xen maintainers were already going
> to merge it.

Ian,

The Xen side is almost entirely reviewed and should be OK, but you need
reviewed-bys on some non-Xen specific patches: #7 #8 #11.

Cheers,

Stefano
