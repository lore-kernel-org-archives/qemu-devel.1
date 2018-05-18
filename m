Received: from eggs.gnu.org ([2001:4830:134:3::10]:56088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcsS-0008VG-Qe
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJcsO-00022i-T5
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:44:48 -0400
Date: Fri, 18 May 2018 11:44:41 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180518104441.GU2057@perard.uk.xensource.com>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
	<1526571358-26685-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526571358-26685-6-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/9] xen_backend: add an emulation of
 grant copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Thu, May 17, 2018 at 04:35:54PM +0100, Paul Durrant wrote:
> Not all Xen environments support the xengnttab_grant_copy() operation.
> E.g. where the OS is FreeBSD or Xen is older than 4.8.0.
> 
> This patch introduces an emulation of that operation using
> xengnttab_map_domain_grant_refs() and memcpy() for those environments.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
