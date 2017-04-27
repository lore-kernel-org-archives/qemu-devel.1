Received: from eggs.gnu.org ([2001:4830:134:3::10]:36970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Ymp-0002ym-7S
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Ymo-0002HF-B6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:04:03 -0400
Date: Thu, 27 Apr 2017 10:03:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427020352.GH9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-3-famz@redhat.com>
	<20170426093622.GB4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426093622.GB4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 02/21] block: Define BLK_PERM_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 11:36, Kevin Wolf wrote:
> Am 26.04.2017 um 05:33 hat Fam Zheng geschrieben:
> > This is the order of the largest possible permission.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  include/block/block.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/block/block.h b/include/block/block.h
> > index eb0565d..a798f10 100644
> > --- a/include/block/block.h
> > +++ b/include/block/block.h
> > @@ -224,6 +224,8 @@ enum {
> >      BLK_PERM_ALL                = 0x1f,
> >  };
> >  
> > +#define BLK_PERM_MAX (64 - clz64((uint64_t)BLK_PERM_ALL))
> 
> Contrary to the commit message, this is the number of permission bits in
> use (i.e. one more than the largest possible permission). You're using
> it correctly, though, because your loop condition is i < BLK_PERM_MAX.
> 
> This could use an updated commit message and a comment at the #define at
> least. Ideally a less ambiguous name instead of the commit (because _MAX
> seems to imply what the commit message currently says, not what it
> really is), but I can't think of one.

Good point.

Given it another thought, using BLK_PERM_ALL in the loop condition is as easy.
I'll drop this patch.

Fam
