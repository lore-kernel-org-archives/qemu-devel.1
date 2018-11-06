Received: from eggs.gnu.org ([2001:4830:134:3::10]:44010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK53E-0001po-T0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gK53A-0005mY-Us
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:22:04 -0500
Date: Tue, 6 Nov 2018 18:21:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181106172115.GG4758@linux.fritz.box>
References: <20181015160633.63130-1-vsementsov@virtuozzo.com>
	<6e80686e-00a1-64d9-dba5-49e2709ca8f2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e80686e-00a1-64d9-dba5-49e2709ca8f2@virtuozzo.com>
Subject: Re: [Qemu-devel] ping Re: [PATCH v4 00/11] backup-top filter driver
 for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>

Am 02.11.2018 um 17:41 hat Vladimir Sementsov-Ogievskiy geschrieben:
> ping
> 
> 15.10.2018 19:06, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> >
> > These series introduce backup-top driver. It's a filter-node, which
> > do copy-before-write operation. Mirror uses filter-node for handling
> > guest writes, let's move to filter-node (from write-notifiers) for
> > backup too (patch 16)
> >
> > v4:
> > fixes, rewrite driver to be implicit, drop new interfaces and
> > don't move to BdrvDirtyBitmap for now, as it's not obvious will
> > it be really needed and don't relate to these series more.
> >
> > v3 was "[PATCH v3 00/18] fleecing-hook driver for backup"
> >
> > v2 was "[RFC v2] new, node-graph-based fleecing and backup"
> >
> > These series are based on
> >   [PATCH v4 0/8] dirty-bitmap: rewrite bdrv_dirty_iter_next_area
> > and
> >   [PATCH 0/2] replication: drop extra sync

Before we can move forward here, we need to deal with the dependencies.
I merged the second one now (because there wasn't any feedback from the
replication maintainers), but the first one looks like it was going
through John's or Eric's tree?

Kevin
