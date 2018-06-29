Received: from eggs.gnu.org ([2001:4830:134:3::10]:33105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYwJG-0006cZ-Rc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYwJF-0007v7-U1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 12:31:46 -0400
Date: Fri, 29 Jun 2018 18:31:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180629163136.GJ15588@localhost.localdomain>
References: <1529415820-7750-1-git-send-email-ari@tuxera.com>
	<1529415820-7750-9-git-send-email-ari@tuxera.com>
	<20180629120551.GF15588@localhost.localdomain>
	<a7f5ceaa-41ed-d732-67e9-dfd25abe6abd@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f5ceaa-41ed-d732-67e9-dfd25abe6abd@tuxera.com>
Subject: Re: [Qemu-devel] [PATCH v5 8/8] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Aapo Vienamo <aapo@tuxera.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Am 29.06.2018 um 18:02 hat Ari Sundholm geschrieben:
> On 06/29/2018 03:05 PM, Kevin Wolf wrote:
> > Am 19.06.2018 um 15:43 hat Ari Sundholm geschrieben:
> > > +    s->cur_log_sector = 1;
> > > +    s->nr_entries = 0;
> > 
> > Would it be useful to implement a mode that appends to the log?
> > 
> > In that case, you'd obviously use the sector size from the existing
> > superblock instead of allowing the user to specify something else.
> > 
> 
> Such a mode may indeed be useful. Thank you for the idea. Would it be OK to
> introduce this feature as a separate patch a bit later?

Yes, of course.

> > > +static BlockDriver bdrv_blk_log_writes = {
> > > +    .format_name            = "blklogwrites",
> > > +    .protocol_name          = "blklogwrites",
> > 
> > This is for the blklogwrites:X:Y syntax, which is not supported, so it
> > should be removed.
> > 
> 
> Just protocol_name, I assume? Will remove, thanks.

Right, just protocol_name. format_name is always required.

Kevin
