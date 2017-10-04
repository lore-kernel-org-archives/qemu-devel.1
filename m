Received: from eggs.gnu.org ([2001:4830:134:3::10]:56340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzlJf-0000lt-Aq
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dzlJZ-0002cY-Fm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:10:31 -0400
Date: Wed, 4 Oct 2017 17:10:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171004151009.GC9801@localhost.localdomain>
References: <1507024644-14853-1-git-send-email-thuth@redhat.com>
	<56ac2027-6aa5-6dc9-f2e3-3de54fe8f230@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ac2027-6aa5-6dc9-f2e3-3de54fe8f230@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/block/onenand: Remove
 dead code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 03.10.2017 um 12:25 hat Laurent Vivier geschrieben:
> On 03/10/2017 11:57, Thomas Huth wrote:
> > The condition of the for-loop makes sure that b is always smaller
> > than s->blocks, so the "if (b >= s->blocks)" statement is completely
> > superfluous here.
> > 
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1715007
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/block/onenand.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> > index 30e40f3..de65c9e 100644
> > --- a/hw/block/onenand.c
> > +++ b/hw/block/onenand.c
> > @@ -520,10 +520,6 @@ static void onenand_command(OneNANDState *s)
> >          s->intstatus |= ONEN_INT;
> >  
> >          for (b = 0; b < s->blocks; b ++) {
> > -            if (b >= s->blocks) {
> > -                s->status |= ONEN_ERR_CMD;
> > -                break;
> > -            }
> >              if (s->blockwp[b] == ONEN_LOCK_LOCKTIGHTEN)
> >                  break;
> >  
> > 
> 
> Looks like a bad cut'n'paste from case 0x23.
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks, applied to the block branch.

Kevin
