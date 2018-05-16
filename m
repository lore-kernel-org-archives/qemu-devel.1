Received: from eggs.gnu.org ([2001:4830:134:3::10]:44858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIvqf-0001o2-Gc
	for qemu-devel@nongnu.org; Wed, 16 May 2018 08:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIvqe-0002AC-Ob
	for qemu-devel@nongnu.org; Wed, 16 May 2018 08:48:05 -0400
Date: Wed, 16 May 2018 14:47:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180516124755.GB4435@localhost.localdomain>
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
	<20180514064139.GB16389@lemon.usersys.redhat.com>
	<9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
Subject: Re: [Qemu-devel] Restoring bitmaps after failed/cancelled migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

Am 14.05.2018 um 12:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 14.05.2018 09:41, Fam Zheng wrote:
> > On Wed, 04/18 17:00, Vladimir Sementsov-Ogievskiy wrote:
> > > Is it possible, that target will change the disk, and then we return control
> > > to the source? In this case bitmaps will be invalid. So, should not we drop
> > > all the bitmaps on inactivate?
> > Yes, dropping all live bitmaps upon inactivate sounds reasonable. If the dst
> > fails to start, and we want to resume VM at src, we could (optionally?) reload
> > the persistent bitmaps, I guess.
> 
> Reload from where? We didn't store them.

Maybe this just means that it turns out that not storing them was a bad
idea?

What was the motivation for not storing the bitmap? The additional
downtime? Is it really that bad, though? Bitmaps should be fairly small
for the usual image sizes and writing them out should be quick.

Kevin
