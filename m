Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUXhU-0008T9-6F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUXhO-0004Fk-IE
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:58:50 -0500
Date: Wed, 5 Dec 2018 13:58:39 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181205135839.GB1259@perard.uk.xensource.com>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-5-paul.durrant@citrix.com>
	<20181129184841.GJ14786@perard.uk.xensource.com>
	<589a4488f1ba4e4496775cc06bda291d@AMSPEX02CL03.citrite.net>
	<d5bf17f689a34e69b9e3b7b92bcfe4fd@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5bf17f689a34e69b9e3b7b92bcfe4fd@AMSPEX02CL03.citrite.net>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Wed, Dec 05, 2018 at 12:43:57PM +0000, Paul Durrant wrote:
> > > > +    value = g_strdup_vprintf(fmt, ap);
> > >
> > > Looks like g_vasprintf() would be better, since it returns the lenght as
> > > well.
> > >
> > 
> > Yes.
> 
> I tried this and it appears not to exist in the version of glib in my environment so I guess I'll stick with g_strdup_printf().

It's probably because you need to include "glib/gprintf.h", I've
suggested it because I've seen the function use elsewhere in QEMU. But
g_strdup_printf is fine too.

https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-vasprintf

-- 
Anthony PERARD
