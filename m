Received: from eggs.gnu.org ([2001:4830:134:3::10]:33776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFIpT-0001fA-Lh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFIpT-00006n-0B
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:35 -0500
Date: Thu, 16 Nov 2017 12:59:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171116115927.GB4062@localhost.localdomain>
References: <20171106165500.30278-1-kwolf@redhat.com>
	<CAFEAcA9dJAhVzA6Ez6sBjH1LPsNpJCTvM4ez14gQ+k1aesO7UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9dJAhVzA6Ez6sBjH1LPsNpJCTvM4ez14gQ+k1aesO7UA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 15.11.2017 um 20:41 hat Peter Maydell geschrieben:
> On 6 November 2017 at 16:55, Kevin Wolf <kwolf@redhat.com> wrote:
> > error_setg_errno() takes a positive errno code.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/block.c b/block.c
> > index 684cb018da..f6415547fe 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -998,7 +998,7 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
> >      ret = bdrv_change_backing_file(parent, filename,
> >                                     base->drv ? base->drv->format_name : "");
> >      if (ret < 0) {
> > -        error_setg_errno(errp, ret, "Could not update backing file link");
> > +        error_setg_errno(errp, -ret, "Could not update backing file link");
> >      }
> >
> >      if (!(orig_flags & BDRV_O_RDWR)) {
> > --
> > 2.13.6
> 
> Just noticed going through coverity warnings that this didn't
> make it into rc1 -- could we get it in for rc2, please?

Yes. I was sick at the start of the week and Max didn't include my queue
in his pull request, so all the patches I had queued missed -rc1 and
will be sent for -rc2 instead.

Kevin
