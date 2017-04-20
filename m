Received: from eggs.gnu.org ([2001:4830:134:3::10]:47720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1IsA-0002DM-AY
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d1Is9-0001rq-BX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:40:14 -0400
Date: Thu, 20 Apr 2017 16:40:05 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170420204005.GL15762@localhost.localdomain>
References: <20170420040003.31074-1-famz@redhat.com>
	<20170420153016.GI3227@redhat.com>
	<20170420203250.GI4747@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420203250.GI4747@noname.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On Thu, Apr 20, 2017 at 10:32:50PM +0200, Kevin Wolf wrote:
> Am 20.04.2017 um 17:30 hat Daniel P. Berrange geschrieben:
> > On Thu, Apr 20, 2017 at 12:00:03PM +0800, Fam Zheng wrote:
> > > Signed-off-by: Fam Zheng <famz@redhat.com>
> > > ---
> > >  block/sheepdog.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/block/sheepdog.c b/block/sheepdog.c
> > > index fb9203e..7e889ee 100644
> > > --- a/block/sheepdog.c
> > > +++ b/block/sheepdog.c
> > > @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
> > >          qemu_set_nonblock(fd);
> > >      } else {
> > >          fd = -EIO;
> > > +        error_setg(errp, "Failed to connect to sheepdog server");
> > >      }
> > 
> > This doesn't make much sense to me. The lines just above the
> > diff context have this:
> > 
> >     fd = socket_connect(s->addr, errp, NULL, NULL);
> > 
> > socket_connect should have already reported an error on "errp"
> > in the scenario that 'fd == -1'.
> 
> By the way, am I the only one who thinks that having errp anywhere else
> than as the last argument is bad style? I can easily see myself missing
> that this functions sets it because the last argument is NULL.
>

No, you are not - that is precisely why I missed it in my review.


-Jeff
