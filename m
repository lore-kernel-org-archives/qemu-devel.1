Received: from eggs.gnu.org ([2001:4830:134:3::10]:50716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEszH-00029g-CJ
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:19:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEszG-00070T-Jk
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:19:27 -0500
Date: Thu, 8 Dec 2016 15:19:18 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161208071918.GB2045@lemon>
References: <1477928314-11184-1-git-send-email-famz@redhat.com>
	<1477928314-11184-5-git-send-email-famz@redhat.com>
	<ee094d41-0493-0b78-f5b9-448a65f68cf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee094d41-0493-0b78-f5b9-448a65f68cf5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] qemu-img: Set "share-rw" flag in
 read-only commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

On Fri, 12/02 01:52, Max Reitz wrote:
> > diff --git a/qemu-img.c b/qemu-img.c
> > index afcd51f..b2f4077 100644
> > --- a/qemu-img.c
> > +++ b/qemu-img.c
> > @@ -679,6 +679,10 @@ static int img_check(int argc, char **argv)
> >              break;
> >          }
> >      }
> > +
> > +    if (!(flags & BDRV_O_RDWR)) {
> > +        flags |= BDRV_O_SHARE_RW;
> > +    }
> 
> If you want to keep this for img_check() (and I'm not going to stop you
> if you do), I think it would be better to put this right in front of
> img_open() to make it really clear that both are not set at the same
> time (without having to look into bdrv_parse_cache_mode()).

Sounds good, will move it.

Fam
