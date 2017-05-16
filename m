Received: from eggs.gnu.org ([2001:4830:134:3::10]:52457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAXSL-00075e-Fz
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dAXSK-0007lJ-QI
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:03:45 -0400
Date: Tue, 16 May 2017 16:03:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170516080332.GA27669@lemon.lan>
References: <20170516074256.24731-1-kraxel@redhat.com>
	<2c224267-32ec-ccf7-ae80-113ebfdce1e2@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c224267-32ec-ccf7-ae80-113ebfdce1e2@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] block/win32: fix 'ret not initialized'
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Tue, 05/16 09:52, Stefan Weil wrote:
> Am 16.05.2017 um 09:42 schrieb Gerd Hoffmann:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  block/file-win32.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/block/file-win32.c b/block/file-win32.c
> > index 1a35dbabf2..8f14f0bdcd 100644
> > --- a/block/file-win32.c
> > +++ b/block/file-win32.c
> > @@ -346,6 +346,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
> > 
> >      if (qdict_get_try_bool(options, "locking", false)) {
> >          error_setg(errp, "locking=on is not supported on Windows");
> > +        ret = -EINVAL;
> >          goto fail;
> >      }
> 
> 
> This is a bug fix for commit 1c3a555c.
> 
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> 
> 

Thank you!

Reviewed-by: Fam Zheng <famz@redhat.com>
