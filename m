Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGHT-0005DA-Hl
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGHN-00066q-7r
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:33:46 -0500
Received: from smtp.citrix.com ([66.165.176.89]:20086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euGHN-000668-1u
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:33:41 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.28943.344150.512881@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 11:33:35 +0000
In-Reply-To: <20180308200345.GD3417@localhost.localdomain>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520530757-4477-4-git-send-email-ian.jackson@eu.citrix.com>
	<20180308200345.GD3417@localhost.localdomain>
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
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

Eduardo Habkost writes ("Re: [PATCH 03/11] xen: defer call to xen_restrict until just before os_setup_post"):
> On Thu, Mar 08, 2018 at 05:39:09PM +0000, Ian Jackson wrote:
> [...]
> > diff --git a/vl.c b/vl.c
> > +    xen_setup_post();
> 
> I don't think we should have accelerator-specific code in main(),
> if we already have accelerator classes that can abstract that
> out.  I suggest adding a AccelClass;:setup_post() method that can
> be called here.

I think I can do that.

Although, it is a bit disappointing to be given this feedback in v6 of
this series.  Did the right people not get CC'd on v5 in October ?

Ian.
