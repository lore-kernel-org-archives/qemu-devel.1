Received: from eggs.gnu.org ([2001:4830:134:3::10]:52938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKEN-0006pd-0C
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKEJ-0004uc-VJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:46:51 -0500
Received: from smtp.citrix.com ([66.165.176.89]:7468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKEJ-0004qj-IN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:46:47 -0500
Date: Fri, 9 Mar 2018 15:46:43 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180309154643.GK1921@perard.uk.xensource.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-12-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520535787-6223-12-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 11/12] xen: Expect xenstore write to fail
 when restricted
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

On Thu, Mar 08, 2018 at 07:03:06PM +0000, Ian Jackson wrote:
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
> 
> Saving the current state to xenstore may fail when running restricted
> (in particular, after a migration). Therefore, don't report the error or
> exit when running restricted.  Toolstacks that want to allow running
> QEMU restricted should instead make use of QMP events to listen for
> state changes.
> 
> CC: Ian Jackson <ian.jackson@eu.citrix.com>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Reviewed-by: Ian Jackson <ian.jackson@eu.citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
