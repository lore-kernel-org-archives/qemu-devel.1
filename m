Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJxKS-0007cB-0W
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cJxKQ-0005Ja-WA
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:58:16 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <001501d2196b$496b4e90$dc41ebb0$@ru>
	<20160928094313.GI5236@noname.redhat.com>
	<000001d21986$b68cd280$23a67780$@ru>
	<001d01d23fee$b962ec40$2c28c4c0$@ru>
	<20161116122001.GA5407@noname.str.redhat.com>
	<001b01d243f1$e2313260$a6939720$@ru>
	<20161121155458.GD5876@noname.redhat.com>
	<001201d24ecb$36f94880$a4ebd980$@ru>
	<20161205103416.GA4870@noname.redhat.com>
	<002201d24eed$acc39440$064abcc0$@ru>
	<20161205124457.GB4870@noname.redhat.com>
In-Reply-To: <20161205124457.GB4870@noname.redhat.com>
Date: Thu, 22 Dec 2016 09:58:11 +0300
Message-ID: <000401d25c20$c23be620$46b3b260$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v5 7/9] block: don't make snapshots for
 filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: pbonzini@redhat.com, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com

Kevin,

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 05.12.2016 um 12:49 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> >
> > It's not a requirement. But to make replay deterministic we have to
> > start with the same image every time. As I know, this may be achieved by:
> > 1. Restoring original disk image manually
> > 2. Using vm snapshot to start execution from
> > 3. Using -snapshot option
> > 4. Not using disks at all
> >
> > > Because if it has to be
> > > there, the next step could be that blkreplay creates temporary-overlay
> > > internally in its .bdrv_open().
> >
> > Here is your answer about such an approach :)
> > https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg04687.html
> 
> Right, and unfortunately these are still good points.
> 
> Especially the part where you allowed to give the overlay filename
> really needs to work the way it does now with the 'image' option. We
> might not need to be that strict with temporary overlays, restricting to
> qcow2 with default options could be acceptable there - but whatever I
> think of to support both cases results in something that isn't really
> easier than the manual way that we figured out above.

What about the new version?

Pavel Dovgalyuk
