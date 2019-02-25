Received: from eggs.gnu.org ([209.51.188.92]:34224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=952ce4ebe=anthony.perard@citrix.com>)
	id 1gyJP8-0003LI-Ke
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=952ce4ebe=anthony.perard@citrix.com>)
	id 1gyJP0-0007UM-02
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:46:52 -0500
Date: Mon, 25 Feb 2019 16:46:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190225164631.GE1349@perard.uk.xensource.com>
References: <20190219163440.15702-1-paul.durrant@citrix.com>
	<9510cf48c9064c0fb1e6eb64b414a7ea@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9510cf48c9064c0fb1e6eb64b414a7ea@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH] xen-block: stop leaking memory in
 xen_block_drive_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 04:36:28PM +0000, Paul Durrant wrote:
> > The locally allocated QDict-s need to be freed. ('file_layer' will be
> > freed implicitly since it is added as an object to 'driver_layer').
> > 
> > Spotted by Coverity: CID 1398649
> > 
> > While in the neighbourhood free 'driver' and 'filename' as soon as they
> > are
> > added to the QDicts. Freeing after the 'done' label doesn't make that much
> > sense as, if the error path jumps to that label, the values would be NULL
> > anyway.
> > 
> > This patch also makes that more obvious by taking the error path if
> > 'params' is NULL and then asserting that both driver and filename are
> > non-NULL in the normal path.
> > 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
