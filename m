Received: from eggs.gnu.org ([2001:4830:134:3::10]:56181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e2052-0005DI-Ru
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e2051-00013b-3E
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:40 -0400
Received: from smtp.citrix.com ([66.165.176.89]:30522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e2050-00012u-IL
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:20:38 -0400
Date: Tue, 10 Oct 2017 12:48:06 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010114806.GG1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1507564902-9000-4-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/8] xen: defer call to xen_restrict until
 just before os_setup_post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Mon, Oct 09, 2017 at 05:01:37PM +0100, Ian Jackson wrote:
> We need to restrict *all* the control fds that qemu opens.  Looking in
> /proc/PID/fd shows there are many; their allocation seems scattered
> throughout Xen support code in qemu.
> 
> We must postpone the restrict call until roughly the same time as qemu
> changes its uid, chroots (if applicable), and so on.
> 
> There doesn't seem to be an appropriate hook already.  The RunState
> change hook fires at different times depending on exactly what mode
> qemu is operating in.
> 
> And it appears that no-one but the Xen code wants a hook at this phase
> of execution.  So, introduce a bare call to a new function
> xen_setup_post, just before os_setup_post.  Also provide the
> appropriate stub for when Xen compilation is disabled.
> 
> We do the restriction before rather than after os_setup_post, because
> xen_restrict may need to open /dev/null, and os_setup_post might have
> called chroot.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
