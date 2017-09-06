Received: from eggs.gnu.org ([2001:4830:134:3::10]:34637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpa7K-0003Ng-BP
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpa7E-0007V4-Fo
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:11:42 -0400
Date: Wed, 6 Sep 2017 14:11:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170906131120.GB15535@stefanha-x1.localdomain>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<20170905114624.GI4633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905114624.GI4633@localhost.localdomain>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Sep 05, 2017 at 01:46:24PM +0200, Kevin Wolf wrote:
> Am 22.08.2017 um 21:07 hat John Snow geschrieben:
> > Well, we knew we'd want this sooner or later. I've got some pings
> > downstream over whether or not we support persistent bitmaps for
> > non-qcow2 formats.
> > 
> > Currently: no, we don't.
> 
> I was going to write some things about r/w backing file, and I might
> still do that later, but for now, let me take a step back:
> 
> What is the use case here?

A user has 100s or 1000s of disk images over iSCSI.  They would like to
use the new incremental backup feature.  Converting all existing disk
images to qcow2 is not an option because it would be too invasive.

Stefan
