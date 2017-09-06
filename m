Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpZno-0003tT-Tl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpZnh-0005HZ-GB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:51:32 -0400
Date: Wed, 6 Sep 2017 13:51:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170906125116.GA15535@stefanha-x1.localdomain>
References: <20170906110359.13854-1-stefanha@redhat.com>
	<20170906114953.GF3753@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906114953.GF3753@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, el13635@mail.ntua.gr

On Wed, Sep 06, 2017 at 01:49:53PM +0200, Kevin Wolf wrote:
> Am 06.09.2017 um 13:03 hat Stefan Hajnoczi geschrieben:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> > 
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v5:
> >  * Dropped .html, .info, and .txt due to cross-platform texi toolchain
> >    issues (qemu-img.texi also supports man output only) after Kevin
> >    reported warnings
> 
> Now it doesn't build at all any more. :-(
> 
>   GEN     docs/qemu-block-drivers.7
> No filename or title
> make: *** [rules.mak:387: docs/qemu-block-drivers.7] Fehler 21

What a nightmare, sorry.  I can reproduce it after running make
distclean.

Stefan
