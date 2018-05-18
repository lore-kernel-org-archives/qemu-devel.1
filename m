Received: from eggs.gnu.org ([2001:4830:134:3::10]:54490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJclE-0004NY-RM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6693598a1=anthony.perard@citrix.com>)
	id 1fJclA-0006PH-12
	for qemu-devel@nongnu.org; Fri, 18 May 2018 06:37:20 -0400
Date: Fri, 18 May 2018 11:37:12 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180518103712.GS2057@perard.uk.xensource.com>
References: <1526571358-26685-1-git-send-email-paul.durrant@citrix.com>
	<1526571358-26685-2-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526571358-26685-2-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] xen: add a meaningful declaration
 of grant_copy_segment into xen_common.h
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

On Thu, May 17, 2018 at 04:35:50PM +0100, Paul Durrant wrote:
> Currently the xen_disk source has to carry #ifdef exclusions to compile
> against Xen older then 4.8. This is a bit messy so this patch lifts the
> definition of struct xengnttab_grant_copy_segment and adds it into the
> pre-4.8 compat area in xen_common.h, which allows xen_disk to be cleaned
> up.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
