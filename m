Received: from eggs.gnu.org ([2001:4830:134:3::10]:37533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2Wnk-0003YB-RK
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2Wnj-0005Qd-PB
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 01:44:44 -0400
Date: Mon, 24 Apr 2017 13:44:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424054432.GB316@lemon.lan>
References: <20170421035606.448-1-famz@redhat.com>
	<20170421035606.448-6-famz@redhat.com>
	<b4d67c71-ee5b-a698-69e8-c2ed5bb56e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d67c71-ee5b-a698-69e8-c2ed5bb56e3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 05/20] qemu-img: Update documentation
 for --share-rw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 04/21 10:37, Eric Blake wrote:
> On 04/20/2017 10:55 PM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  qemu-img-cmds.hx | 48 ++++++++++++++++++++++++------------------------
> >  1 file changed, 24 insertions(+), 24 deletions(-)
> > 
> > diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> > index 8ac7822..1b00bb8 100644
> > --- a/qemu-img-cmds.hx
> > +++ b/qemu-img-cmds.hx
> > @@ -10,15 +10,15 @@ STEXI
> >  ETEXI
> >  
> >  DEF("bench", img_bench,
> > -    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] filename")
> > +    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [--share-rw] filename")
> 
> General comment - it seems that we favor the short-option spelling where
> one exists; should all of these updates mention -U instead of --share-rw?

OK, I can change it.

> 
> Also, why did you rename it from --unsafe-reads in an earlier revision?
> After all, if I'm understanding this flag correctly, what you are asking
> for is the ability to read the image in spite of other simultaneous
> writers that may make your reads inconsistent.

It was a result of discussion with Kevin on IRC - consistent read as in the new
op blocker API is specifically for the state of the intermediate nodes in commit
job, and is orthogonal to the share-rw semantics as added to qdev. This option
here for qemu-img/qemu-io, is more close to the latter, thus the name is updated
to reflect its use case better.

Fam
