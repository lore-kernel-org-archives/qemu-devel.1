Received: from eggs.gnu.org ([2001:4830:134:3::10]:52693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUa2q-0001Up-Kt
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUa2q-0000Ca-09
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:29:04 -0500
Date: Wed, 5 Dec 2018 16:28:55 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181205162855.GA18875@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-5-paul.durrant@citrix.com>
	<20181129184841.GJ14786@perard.uk.xensource.com>
	<589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 04/18] xen: create xenstore areas for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, Dec 05, 2018 at 12:05:23PM +0000, Paul Durrant wrote:
> > > +    value = xs_read(xsh, XBT_NULL, path, NULL);
> > 
> > The xenstore.h isn't clear about failure of this function, it is
> > supposed to return a malloced value. Do we actually need to check if value
> > is NULL?
> 
> The comment above xs_read() in xs.c is:
> 
> /* Get the value of a single file, nul terminated.                          
>  * Returns a malloced value: call free() on it after use.                   
>  * len indicates length in bytes, not including the nul.                    
>  */
> 
> and I think we should check it for NULL before passing it to vsscanf().

I've sent a patch against xenstore.h to document that xs_read, and some
other functions, can return NULL.
<20181205162603.25788-1-anthony.perard@citrix.com>

-- 
Anthony PERARD
