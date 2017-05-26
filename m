Received: from eggs.gnu.org ([2001:4830:134:3::10]:55839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECAn-0003Hg-M3
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dECAm-0003JA-Lk
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:08:45 -0400
Date: Fri, 26 May 2017 12:08:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170526100834.GD7211@noname.str.redhat.com>
References: <cover.1495536228.git.berto@igalia.com>
	<b3659d971731e5ef832399400a0f14daa580fce4.1495536228.git.berto@igalia.com>
	<20170526081129.GA7211@noname.str.redhat.com>
	<w51efvckmpq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51efvckmpq.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: Make perform_cow() call
 do_perform_cow() twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

Am 26.05.2017 um 11:10 hat Alberto Garcia geschrieben:
> On Fri 26 May 2017 10:11:29 AM CEST, Kevin Wolf <kwolf@redhat.com> wrote:
> >> --- a/block/qcow2-cluster.c
> >> +++ b/block/qcow2-cluster.c
> >> @@ -414,6 +414,10 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
> >>      struct iovec iov;
> >>      int ret;
> >>  
> >> +    if (bytes == 0) {
> >> +        return 0;
> >> +    }
> >> +
> 
>    [...]
> 
> >> +static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
> >>  {
> >>      BDRVQcow2State *s = bs->opaque;
> >> +    Qcow2COWRegion *start = &m->cow_start;
> >> +    Qcow2COWRegion *end = &m->cow_end;
> >>      int ret;
> >>  
> >> -    if (r->nb_bytes == 0) {
> >> +    if (start->nb_bytes == 0 && end->nb_bytes == 0) {
> >>          return 0;
> >>      }
> >
> > With this change, it can now happen that we call do_perform_cow() with
> > bytes == 0.
> 
> Yes, but see the change I made to do_perform_cow() in the same patch
> (quoted above).

Wait... How did you manage to hack my email account and insert this
retroactively? :-)

Sorry for the noise then, I must have been looking at the source code of
the wrong commit.

Kevin
