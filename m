Received: from eggs.gnu.org ([2001:4830:134:3::10]:43171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUwot-0000ku-Ug
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUwot-0003bu-43
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:15:55 -0400
Date: Mon, 18 Jun 2018 18:15:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180618161546.GE4667@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<4a1c8fb9816de2115d08284c36d7a718b5e48de6.1528991017.git.berto@igalia.com>
	<20180618141507.GB4667@localhost.localdomain>
	<w51fu1kp10f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51fu1kp10f.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC PATCH 05/10] block: Add 'keep_old_opts'
 parameter to bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 18.06.2018 um 17:28 hat Alberto Garcia geschrieben:
> On Mon 18 Jun 2018 04:15:07 PM CEST, Kevin Wolf wrote:
> 
> >> @@ -2850,7 +2850,8 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
> >>                                                   int flags,
> >>                                                   const BdrvChildRole *role,
> >>                                                   QDict *parent_options,
> >> -                                                 int parent_flags)
> >> +                                                 int parent_flags,
> >> +                                                 bool keep_old_opts)
> >
> > Can we change the semantics of keep_old_opts so that flags is completely
> > ignored for keep_old_opts=false?
> >
> > Flags are one of the reasons why the behaviour of bdrv_reopen() is
> > rather complex and I'd prefer not having that complexity in a public
> > interface. To be honest, I wouldn't be sure that I could write a
> > correct documentation with it.
> 
> I think so. In this series if keep_old_opts is false the only possible
> flags are either 0 or BDRV_O_RDWR | BDRV_O_ALLOW_RDWR, depending on the
> value of "read-only" option.

I assume the default options that you have to set in
qmp_x_blockdev_reopen() are only because update_options_from_flags()
would break things otherwise. So if we get rid of the latter, maybe we
can simplify qmp_x_blockdev_reopen(), too.

Well, or maybe my assumption is just wrong, of course.

KEvin
