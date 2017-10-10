Received: from eggs.gnu.org ([2001:4830:134:3::10]:49205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1yFa-0000ZR-UE
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1yFV-0004U3-DZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:23:26 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:15684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1yFV-0004TA-08
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:23:21 -0400
Date: Tue, 10 Oct 2017 12:40:01 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010114001.GF1771@perard.uk.xensource.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-4-git-send-email-ian.jackson@eu.citrix.com>
	<20171009155044.GC1771@perard.uk.xensource.com>
	<23003.43689.447516.6588@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23003.43689.447516.6588@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] xen: defer call to xen_restrict until
 after os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Oct 09, 2017 at 05:58:17PM +0100, Ian Jackson wrote:
> (My resend has crossed with your review.  Sorry about that.)
> 
> Anthony PERARD writes ("Re: [PATCH 3/8] xen: defer call to xen_restrict until after os_setup_post"):
> > On Wed, Oct 04, 2017 at 05:18:06PM +0100, Ian Jackson wrote:
> 
> > > +void xen_setup_post(void)
> > > +{
> > > +    int rc;
> > 
> > We probably want to check here if Xen is enable (via xen_enabled()).
> > xen_domid_restrict could be true when Xen is not used, even if it does
> > not make sense to use -xen-domid-restrict in that case.
> 
> Should -xen-domid-restrict without xen_enabled() not fail ?  IMO it is
> normally better for an option which requests enhanced security to fail
> when it can't do its job, rather than just hoping that its
> inapplicability is intentional.

I'm tring to find out what does calling xen_restrict_all(0), when
running an non-Xen guest. I think it would just lock(), then unlock()
then there should not be any handle to restrict, and return 0; is that
right?

So I think the code is fine like this. I'll put my Reviewed-by to the
last version.

Thanks.

> OTOH I suppose there is an argument that without xen_enabled() the
> function of -xen-domid-restrict is achieved, in that without
> xen_enabled() qemu is unable (after dropping privileges) to act on
> Xen domains at all...
> 
> Thanks,
> Ian.

-- 
Anthony PERARD
