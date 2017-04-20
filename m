Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10MK-00042r-L7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d10MK-0003Ve-1U
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:54:08 -0400
Date: Thu, 20 Apr 2017 08:53:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420005357.GD25568@lemon.lan>
References: <20170419091757.15507-1-famz@redhat.com>
	<20170419171335.GH5826@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419171335.GH5826@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] iotests: 109: Filter out "len" of
 failed jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/19 19:13, Kevin Wolf wrote:
> Am 19.04.2017 um 11:17 hat Fam Zheng geschrieben:
> > Mirror calculates job len from current I/O progress:
> > 
> >     s->common.len = s->common.offset +
> >                     (cnt + s->sectors_in_flight) * BDRV_SECTOR_SIZE;
> > 
> > The final "len" of a failed mirror job in iotests 109 depends on the
> > subtle timing of the completion of read and write issued in the first
> > mirror iteration.  The second iteration may or may not have run when the
> > I/O error happens, resulting in non-deterministic output of the
> > BLOCK_JOB_COMPLETED event text.
> > 
> > Similar to what was done in a752e4786, filter out the field to make the
> > test robust.
> > 
> > Tested-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> This improves things a bit, but the test case is still failing for me.
> It's not deterministic, so the following is just an example.

OK, I'll revise the patch and send v3.

Fam
