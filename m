Received: from eggs.gnu.org ([209.51.188.92]:52323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gqapd-0007IY-9y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gqapc-0002XU-Eu
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:46:25 -0500
Date: Mon, 4 Feb 2019 10:36:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190204093627.GA5855@linux.fritz.box>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190201171445.GB31750@localhost.localdomain>
	<ab88488a-a715-5109-7f82-9de0919777f8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab88488a-a715-5109-7f82-9de0919777f8@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v11 3/3] qemu-img info: bitmaps extension
 new test 239
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 04.02.2019 um 08:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 01.02.2019 20:14, Kevin Wolf wrote:
> > Am 31.01.2019 um 14:46 hat Andrey Shinkevich geschrieben:
> >> A new test file 239 added to the qemu-iotests set. It checks
> >> the output format of 'qemu-img info' for bitmaps extension of
> >> qcow2 specific information.
> >>
> >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> > 
> > 239 is already taken, so please rename this one. I usually search the
> > mailing list for "239.out" etc. until I find a number that nobody has
> > used even in a patch series yet.
> > 
> > Kevin
> > 
> 
> Interesting, wasn't it considered to give meaningful names to iotest files?
> like migrate.bitmaps or qemu-img.qcow2-bitmaps, namespace.test? And then
> we'll be able to ./check -qcow2 qemu-img.*. And all these conflicts in list
> will be resolved

You're not the first one to suggest this, and I don't think people ever
fundamentally objected to the idea. But noone implemented it either -
the current system is ugly, but it does kind of work in practice and
renaming files in the repo always comes with some cost like 'git blame'
and 'git log' stopping at the rename by default.

Kevin
