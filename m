Received: from eggs.gnu.org ([2001:4830:134:3::10]:43813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVIrf-0003Gv-JD
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVIrc-0000J0-Cs
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:20:31 -0500
Date: Fri, 7 Dec 2018 16:20:19 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207162019.GA29831@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-10-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-10-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 09/18] xen: remove
 unnecessary code from dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Dec 06, 2018 at 03:08:35PM +0000, Paul Durrant wrote:
> v2:
>  - Leave existing boilerplate alone, other than removing the now-incorrect
>    description
> ---
>  hw/block/dataplane/xen-block.c | 409 ++---------------------------------------
>  1 file changed, 16 insertions(+), 393 deletions(-)
> 
> diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
> index 9fae505..98f987d 100644
> --- a/hw/block/dataplane/xen-block.c
> +++ b/hw/block/dataplane/xen-block.c
> @@ -1,6 +1,4 @@
>  /*
> - *  xen paravirt block device backend
> - *
>   *  (c) Gerd Hoffmann <kraxel@redhat.com>
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -19,26 +17,12 @@
>   *  GNU GPL, version 2 or (at your option) any later version.
>   */
>  
> +/*
> + * Copyright (c) 2018  Citrix Systems Inc.

You can add this copyright line just after Gerd's one abrove.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

And I'm pretty sure this should not be added. The boilerplate at the top
of the file already state that your contributions is going to be GPLv2+.

-- 
Anthony PERARD
