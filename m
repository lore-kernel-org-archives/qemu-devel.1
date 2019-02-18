Received: from eggs.gnu.org ([209.51.188.92]:56685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=945ef7921=anthony.perard@citrix.com>)
	id 1gvl4y-00059Q-7r
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=945ef7921=anthony.perard@citrix.com>)
	id 1gvl4x-0000sw-Jj
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 10:43:36 -0500
Date: Mon, 18 Feb 2019 15:43:30 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190218154330.GC1349@perard.uk.xensource.com>
References: <20190215162533.19475-1-paul.durrant@citrix.com>
	<20190215162533.19475-4-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190215162533.19475-4-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] xen-block: report error condition from
 vbd_name_to_disk()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Feb 15, 2019 at 04:25:33PM +0000, Paul Durrant wrote:
> The function needs to make sure it is passed a valid disk name. This is
> easily done by making sure that the parsing loop results in a non-zero
> value.
> 
> Spotted by Coverity: CID 1398640
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
