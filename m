Received: from eggs.gnu.org ([2001:4830:134:3::10]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dc4mg-00017k-W8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dc4md-00054z-Pq
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dc4md-00054q-Jy
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:06:31 -0400
Date: Mon, 31 Jul 2017 15:05:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170731070552.GD29971@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-17-git-send-email-peterx@redhat.com>
	<9cd34bf7-b744-f04d-a91b-26442a648b2d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cd34bf7-b744-f04d-a91b-26442a648b2d@redhat.com>
Subject: Re: [Qemu-devel] [RFC 16/29] qmp: hmp: add migrate "resume" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jul 28, 2017 at 10:57:12AM -0500, Eric Blake wrote:
> On 07/28/2017 03:06 AM, Peter Xu wrote:
> > It will be used when we want to resume one paused migration.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hmp-commands.hx       | 7 ++++---
> >  hmp.c                 | 4 +++-
> >  migration/migration.c | 2 +-
> >  qapi-schema.json      | 5 ++++-
> >  4 files changed, 12 insertions(+), 6 deletions(-)
> > 
> 
> > +++ b/qapi-schema.json
> > @@ -3208,6 +3208,8 @@
> >  # @detach: this argument exists only for compatibility reasons and
> >  #          is ignored by QEMU
> >  #
> > +# @resume: resume one paused migration
> 
> Mention default false, and that it is since 2.11.

Will fix.  Thanks,

-- 
Peter Xu
