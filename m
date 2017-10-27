Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e88JK-0004QI-EW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1e88JH-0004Vu-BI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1e88JH-0004VY-4X
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 13:20:43 -0400
Date: Fri, 27 Oct 2017 10:20:41 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <23027.2766.724136.342560@mariner.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1710271015310.3086@sstabellini-ThinkPad-X260>
References: <23017.64539.31230.43449@mariner.uk.xensource.com>
	<1508506702-17704-1-git-send-email-ian.jackson@eu.citrix.com>
	<1508506702-17704-2-git-send-email-ian.jackson@eu.citrix.com>
	<alpine.DEB.2.10.1710261433490.3086@sstabellini-ThinkPad-X260>
	<23027.2766.724136.342560@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5.1 2/8] xen: restrict: use
 xentoolcore_restrict_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org

On Fri, 27 Oct 2017, Ian Jackson wrote:
> Stefano Stabellini writes ("Re: [PATCH v5.1 2/8] xen: restrict: use xentoolcore_restrict_all"):
> > On Fri, 20 Oct 2017, Ian Jackson wrote:
> ...
> > > Drop individual use of xendevicemodel_restrict and
> > > xenforeignmemory_restrict.  These are not actually effective in this
> > > version of qemu, because qemu has a large number of fds open onto
> > > various Xen control devices.
> ...
> > Wait, if the compat stub returns error, and this patch removed the code
> > to check for ENOTTY, doesn't it prevent any QEMU compiled against older
> > Xen from working?
> > 
> > Or am I missing something?
> 
> You are right, but this is intended.  The paragraph I quote in the
> commit message above is intended to explain.
> 
> That is: without xentoolcore_restrict_all, -xen-domid-restrict is a
> booby-trap.  It does not actually prevent a compromised qemu from
> doing anything.  So there is no reason to pass it in such a
> configuration.  If you do pass it it is better for the domain startup
> to fail, than for it to carry on without the restriction.
> 
> The only reason I am not saying someone should be issuing an advisory
> is that this feature was never supported by any of the Xen toolstacks.

Ah, right. And libxl has never passed -xen-domid-restrict in previous
releases, so we are OK.

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
