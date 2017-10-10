Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1zEz-0007bo-2a
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1zEv-0000TO-1v
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:26:53 -0400
Received: from smtp.citrix.com ([66.165.176.89]:6036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e1zEu-0000SX-QP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:26:48 -0400
Date: Tue, 10 Oct 2017 12:26:56 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010112656.GE1771@perard.uk.xensource.com>
References: <1507564902-9000-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507564902-9000-3-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1507564902-9000-3-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] xen: restrict: use
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
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Mon, Oct 09, 2017 at 05:01:36PM +0100, Ian Jackson wrote:
> And insist that it works.
> 
> Drop individual use of xendevicemodel_restrict and
> xenforeignmemory_restrict.  These are not actually effective in this
> version of qemu, because qemu has a large number of fds open onto
> various Xen control devices.
> 
> The restriction arrangements are still not right, because the
> restriction needs to be done very late - after qemu has opened all of
> its control fds.
> 
> xentoolcore_restrict_all and xentoolcore.h are available in Xen 4.10
> and later, only.  Provide a compatibility stub.  And drop the
> compatibility stubs for the old functions.
> 
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
