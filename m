Received: from eggs.gnu.org ([2001:4830:134:3::10]:55612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTqQF-0002qS-4g
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86815d540=anthony.perard@citrix.com>)
	id 1gTqQB-0008Ef-5M
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:46:11 -0500
Date: Mon, 3 Dec 2018 15:45:56 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181203154556.GL14786@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-7-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181121151211.15997-7-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 06/18] xen: add grant table interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>

On Wed, Nov 21, 2018 at 03:11:59PM +0000, Paul Durrant wrote:
> The legacy PV backend infrastructure provides functions to map, unmap and
> copy pages granted by frontends. Similar functionality will be required
> by XenDevice implementations so this patch adds the necessary support.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> +typedef struct XenDeviceGrantCopySegment {
> +    union {
> +        void *virt;
> +        struct {
> +            uint32_t ref;
> +            off_t offset;
> +        } foreign;
> +    } source, dest;

Why is there a union between `source` and `dest`, I don't see any way
(another field) to distinguish which is which. Can't we have a
segment without `source`/`dest`? It mimic the
xengnttab_grant_copy_segment_t but that doesn't seems very useful as it
doesn't really prevent mistake.

> +    size_t len;
> +} XenDeviceGrantCopySegment;

Anyway, it's not very important:

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
