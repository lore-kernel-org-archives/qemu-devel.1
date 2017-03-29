Received: from eggs.gnu.org ([2001:4830:134:3::10]:54680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ctIY2-00087y-IE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1ctIXz-0003U4-FC
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:42:22 -0400
Received: from mail.kernel.org ([198.145.29.136]:54406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1ctIXz-0003TI-95
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:42:19 -0400
Date: Wed, 29 Mar 2017 11:42:13 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <25280fb4-5ffd-a523-b5c1-4725fa55e44b@redhat.com>
Message-ID: <alpine.DEB.2.10.1703291141190.27589@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<1490033952-26735-1-git-send-email-sstabellini@kernel.org>
	<20170323140005.6b0853b3@bahia.lan>
	<15207674-c5cd-3874-7ac9-5b23cdac8888@suse.com>
	<28db5816-2ed9-0d92-a15d-af47b58a9da1@redhat.com>
	<alpine.DEB.2.10.1703230953120.8001@sstabellini-ThinkPad-X260>
	<3d94c0aa-6b18-5574-4034-110cc2cf4b90@suse.com>
	<alpine.DEB.2.10.1703241030391.8001@sstabellini-ThinkPad-X260>
	<d02897ba-88c6-f92e-ccf5-afab3c584f75@suse.com>
	<alpine.DEB.2.10.1703271537330.8001@sstabellini-ThinkPad-X260>
	<b0ef8967-302f-e308-4d2c-207299c250ef@suse.com>
	<alpine.DEB.2.10.1703281653340.27589@sstabellini-ThinkPad-X260>
	<25280fb4-5ffd-a523-b5c1-4725fa55e44b@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 1/8] xen: import ring.h from xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Stefano Stabellini <stefano@aporeto.com>, anthony.perard@citrix.com, xen-devel <xen-devel@lists.xenproject.org>

On Wed, 29 Mar 2017, Paolo Bonzini wrote:
> On 29/03/2017 01:54, Stefano Stabellini wrote:
> >>> I understand your point of view, and honestly it wouldn't be a problem
> >>> doing it the way you suggested either. However, I think that going
> >>> forward it will be less of a maintenance pain to keep ring.h in sync,
> >>> compared to maintaining a versioned build dependency between Xen and
> >>> QEMU for the compilation of one PV backend. We do have version checks
> >>> in QEMU for Xen compatibility, but not for PV backends or the xenpv
> >>> machine yet.
> >> For the pvUSB backend I just used a mandatory macro from the header for
> >> the #ifdef. The backend will signal support when it was defined during
> >> build and will refuse initialization otherwise. Xen tools are able to
> >> recoginze qemu support of the backend by looking into Xenstore.
> > 
> > What do you think of the following:
> 
> Let's just copy the header...

It's settled.

Thanks,

Stefano
