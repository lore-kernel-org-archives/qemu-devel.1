Received: from eggs.gnu.org ([2001:4830:134:3::10]:43654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co7dK-0005N9-M7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1co7dJ-0002s5-OT
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:02:26 -0400
Date: Wed, 15 Mar 2017 13:02:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170315120214.GH4030@noname.str.redhat.com>
References: <20170314023050.32756-1-famz@redhat.com>
	<20170315105248.GF4030@noname.str.redhat.com>
	<20170315110915.GC3088@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315110915.GC3088@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 15.03.2017 um 12:09 hat Fam Zheng geschrieben:
> On Wed, 03/15 11:52, Kevin Wolf wrote:
> > Am 14.03.2017 um 03:30 hat Fam Zheng geschrieben:
> > > bdrv_child_set_perm alone is not very usable because the caller must
> > > call bdrv_child_check_perm first.
> > 
> > Well, you can imagine use cases where you want to check multiple
> > children first and then set or abort all of them, but apparently we
> > haven't found such a case yet, so I'm fine with making the functions
> > private for now.  If we ever need it, making them public again is
> > trivial.
> 
> Yes, no problem with that use case but by then I suppose we should also add an
> assertion about the calling sequence: e.g. in image locking, raw_set_perm goes
> nut if not preceded by `raw_check_perm.

Yes, that makes sense.

Kevin
