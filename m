Received: from eggs.gnu.org ([209.51.188.92]:37770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=945ef7921=anthony.perard@citrix.com>)
	id 1gvjtl-0002og-PA
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=945ef7921=anthony.perard@citrix.com>)
	id 1gvjtc-0000qi-6j
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:27:52 -0500
Date: Mon, 18 Feb 2019 14:27:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190218142731.GA1349@perard.uk.xensource.com>
References: <20190215162533.19475-1-paul.durrant@citrix.com>
	<20190215162533.19475-2-paul.durrant@citrix.com>
	<9c6c6f2e-cac0-9e75-d5e2-baf613aad6b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c6c6f2e-cac0-9e75-d5e2-baf613aad6b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] dataplane/xen-block: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Paul Durrant <paul.durrant@citrix.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Feb 15, 2019 at 09:38:59PM +0100, Philippe Mathieu-Daudé wrote:
> On 2/15/19 5:25 PM, Paul Durrant wrote:
> > The if() statement is clearly bogus (dead code which should have been
> > cleaned up when grant mapping was removed).
> 
> "... was removed in 06454c24ad)."

Actually, it looks like c6025bd197 should have remove the if statement.

> > 
> > Spotted by Coverity: CID 1398635
> > 
> > While in the neighbourhood, add a missing 'fall through' annotation.
> > 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
