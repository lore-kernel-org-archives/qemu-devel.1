Received: from eggs.gnu.org ([2001:4830:134:3::10]:41070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1co8kQ-00079v-44
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:13:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1co8kP-0001up-0c
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:13:50 -0400
Date: Wed, 15 Mar 2017 21:13:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170315131343.GF3088@lemon.lan>
References: <20170314171120.80741-1-vsementsov@virtuozzo.com>
	<20170315110351.GG4030@noname.str.redhat.com>
	<20170315111445.GE3088@lemon.lan>
	<20170315120656.GI4030@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315120656.GI4030@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Wed, 03/15 13:06, Kevin Wolf wrote:
> > > 
> > > Stefan, Paolo, do you remember the details why we didn't even do a
> > > simple fix like the one below? I think there were some patches on the
> > > list, no?
> > 
> > ISTM the concern was mostly "what about other BB in the graph?"
> > 
> > Should the new op blocker API be used in this one (a new type of perm)?
> 
> If we know what operation to block, that's an option. Would "change the
> node's AioContext" work for it?
> 
> I think it would effectively mean that you need to attach the device
> first and then jobs etc. respect the AioContext, whereas the opposite
> order breaks because they don't have callbacks to adjust the AioContext
> after the fact.
> 
> This seems to match what's actually safe, so it might really be as easy
> as this.

Yes, this sounds good to me.

Vladimir, would you like to implement this? It would be good to have this fixed
in 2.9.

Fam
