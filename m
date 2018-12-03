Received: from eggs.gnu.org ([2001:4830:134:3::10]:54300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTrZ1-0001X9-Nd
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTrYz-0000Sj-KA
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:59:19 -0500
Date: Mon, 3 Dec 2018 16:58:58 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203165858.GP14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-10-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-10-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 09/18] xen: remove unnecessary code from
 dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Nov 21, 2018 at 03:12:02PM +0000, Paul Durrant wrote:
> Not all of the code duplicated from xen_disk.c is required as the basis for
> the new dataplane implementation so this patch removes extraneous code,
> along with the legacy #includes and calls to the legacy xen_pv_printf()
> function. Error messages are changed to be reported using error_report().
> 
> NOTE: The code is still not yet built. Further transformations will be
>       required to make it correctly interface to the new XenBus/XenDevice
>       framework. They will be delivered in a subsequent patch.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/hw/block/dataplane/xen-qdisk.c b/hw/block/dataplane/xen-qdisk.c
> index 9fae50534e..8e4368e7af 100644
> --- a/hw/block/dataplane/xen-qdisk.c
> +++ b/hw/block/dataplane/xen-qdisk.c
> @@ -1,45 +1,10 @@
>  /*
> - *  xen paravirt block device backend
> + * Copyright (c) Citrix Systems Inc.
> + * All rights reserved.
>   *
> - *  (c) Gerd Hoffmann <kraxel@redhat.com>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; under version 2 of the License.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License along
> - *  with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - *  Contributions after 2012-01-13 are licensed under the terms of the
> - *  GNU GPL, version 2 or (at your option) any later version.
> + * Based on original code (c) Gerd Hoffmann <kraxel@redhat.com>
>   */

Once this license boilerplate is kept unchange, beside the extra
Copyright line, then:

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
