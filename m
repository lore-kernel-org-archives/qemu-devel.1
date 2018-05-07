Received: from eggs.gnu.org ([2001:4830:134:3::10]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fFglr-0003IE-9v
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fFgln-0006BZ-Bc
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:05:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1fFgln-0006Ao-8L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 10:05:39 -0400
Date: Mon, 7 May 2018 16:05:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180507140527.GA4716@localhost.localdomain>
References: <ac216b06-9469-addd-b5a1-3a3a89fd0782@redhat.com>
	<20180502074403.yh5weukbjgqsvp7n@sirius.home.kraxel.org>
	<20180502080200.GG3308@redhat.com>
	<20180503072100.GA5301@stefanha-x1.localdomain>
	<20180503090727.GC11382@redhat.com>
	<CAFEAcA8=mZf8RbQX2-swbUBkoT=RYSVx-oRA2UpzJCqvgGF+KQ@mail.gmail.com>
	<20180503134321.pp736ou25pdwvslm@sirius.home.kraxel.org>
	<20180504132023.GA5098@localhost.localdomain>
	<c2207b0b-889a-e39f-2f55-640118e2d755@linaro.org>
	<69fd5755-d1f0-b69a-fabb-3134fccaa4a5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69fd5755-d1f0-b69a-fabb-3134fccaa4a5@redhat.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 07.05.2018 um 07:33 hat Thomas Huth geschrieben:
> On 04.05.2018 19:30, Richard Henderson wrote:
> > On 05/04/2018 06:20 AM, Kevin Wolf wrote:
> >> I'm not sure what the exact systemd model is, but as we came to the
> >> conclusion that there is no semantic difference between major and minor
> >> version number for QEMU, I'd just merge them.
> >>
> >> This would result in 3.0 for the next release, 3.1 etc. would be stable
> >> releases, and the December release would be 4.0.
> >>
> >> It feels like the minimal change to fix our existing versioning scheme.
> > 
> > This is very similar to what GCC started to use at version 5.
> > 
> >     https://gcc.gnu.org/develop.html#num_scheme
> > 
> > I do think it makes sense to drop minor versions, leaving only major +
> > patchlevel (which then appears to be minor version).
> 
> We're currently also using the patch level for marking developing
> version (x.y.50) and release candidates (x.y.9r) ... we should also
> think of a way how we want to map that to a new numbering scheme. If we
> do it the GCC way, I guess the x.0 release will be the development
> "versions"? But the release candidates? Do we still need a third number
> for doing those (3.0.1 = rc1, 3.0.2 = rc2, ...)?

Nothing stops you from using 3.50, 3.91, etc. like we always did.

Kevin
