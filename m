Received: from eggs.gnu.org ([2001:4830:134:3::10]:51336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU8xy-0004bM-1e
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=869086d29=anthony.perard@citrix.com>)
	id 1gU8xx-0008T6-9Z
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 06:34:14 -0500
Date: Tue, 4 Dec 2018 11:34:02 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181204113402.GS14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-13-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-13-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 12/18] xen: remove 'ioreq'
 struct/varable/field names from dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:05PM +0000, Paul Durrant wrote:
> This is a purely cosmetic patch that purges the name 'ioreq' from struct,
> variable and field names. (This name has been problematic for a long time
> as 'ioreq' is the name used for generic I/O requests coming from Xen).
> The patch replaces 'struct ioreq' with a new 'XenQdiskRequest' type and
> 'ioreq' field/variable names with 'request', and then does necessary
> fix-up to adhere to coding style.
> 
> Function names are not modified by this patch. Yhey will be dealt with in

s/Yhey/They/

> a subsequent patch.
> 
> No functional change.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
