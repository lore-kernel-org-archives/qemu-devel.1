Received: from eggs.gnu.org ([2001:4830:134:3::10]:58274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpCJi-0006TR-4b
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpCJd-00028z-MI
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:46:54 -0400
Date: Tue, 5 Sep 2017 13:46:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905114624.GI4633@localhost.localdomain>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 22.08.2017 um 21:07 hat John Snow geschrieben:
> Well, we knew we'd want this sooner or later. I've got some pings
> downstream over whether or not we support persistent bitmaps for
> non-qcow2 formats.
> 
> Currently: no, we don't.

I was going to write some things about r/w backing file, and I might
still do that later, but for now, let me take a step back:

What is the use case here?

Using a specific image format is not a value in and of itself; it should
be chosen depending on which features you need. What prevents those
downstream users from simply choosing qcow2 for their data, too?

Kevin
