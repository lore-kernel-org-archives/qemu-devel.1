Received: from eggs.gnu.org ([2001:4830:134:3::10]:49157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCYWZ-0003Of-EQ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:08:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCYWW-0005YE-6i
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:08:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1eCYWW-0005Y2-06
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 17:08:40 -0500
Date: Wed, 8 Nov 2017 17:08:38 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171108220838.GC5399@localhost.localdomain>
References: <CAJSP0QUOCzWfM614zRKme+GecU+NVNOFcoGz1wdBcdgKzrq-LQ@mail.gmail.com>
	<1a47a48e-0917-23ba-6b83-e22e35289f86@weilnetz.de>
	<20171108171120.GA8403@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108171120.GA8403@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Moving release tarballs to a CDN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Weil <stefan.weil@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Nov 08, 2017 at 05:11:20PM +0000, Stefan Hajnoczi wrote:
> On Wed, Nov 08, 2017 at 05:19:25PM +0100, Stefan Weil wrote:
> > Am 08.11.2017 um 16:33 schrieb Stefan Hajnoczi:
> > > Hi Mike and Jeff,
> > > qemu.org's bandwidth usage is dominated by release tarball downloads.
> > > This puts qemu.org bandwidth usage in the 2+ TB/month range.
> > 
> > Hi Stefan,
> > 
> > how much of this traffic is caused by web spiders?
> > 
> > From my own binaries I know that the bots of the
> > different search engines cause most of the traffic,
> > if they are allowed to do so.
> > 
> > Usually they respect robots.txt. There is no
> > https://www.qemu.org/robots.txt currently.
> > Nor is there a https://download.qemu.org/robots.txt.
> > Adding both would reduce the downloads, maybe
> > enough to fix the problem.
> > 
> > Or do you see an advantage from bots which download
> > QEMU tarballs? robots.txt can also block only
> > selected bots.
> > 
> > Regards
> > Stefan
> > 
> > PS. There is a https://git.qemu.org/robots.txt.
> 
> Great idea!  It's an easy to try adding a robots.txt and check how
> bandwidth uses changes over the next month.
> 
> Jeff: Want to try this?
> 
> Stefan

Yes, sure - I added a robots.txt to exclude .bz2 and .xz files, and we can
see how that affects bandwidth.  Right now, with our current hosting provider,
we are not near any bandwidth limit, but it makes sense to conserve
resources (unless there is any benefit we see to allowing bots to index
download.qemu.org binaries).


Thanks,

Jeff
