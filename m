Received: from eggs.gnu.org ([2001:4830:134:3::10]:34418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkv6k-0007cy-KE
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 13:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkv6j-0004Ka-G1
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 13:40:22 -0400
Date: Wed, 1 Aug 2018 18:40:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180801174005.GD2691@work-vm>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-5-vsementsov@virtuozzo.com>
	<700dffe4-f3a8-8f70-052c-9f6f8ffbe3d3@redhat.com>
	<20180801102031.GC2691@work-vm>
	<64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64aad02b-3d5c-70d6-0f5a-93dd5b88e4bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] dirty-bitmaps: clean-up bitmaps
 loading and migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>

* John Snow (jsnow@redhat.com) wrote:
> 
> 
> On 08/01/2018 06:20 AM, Dr. David Alan Gilbert wrote:
> > * John Snow (jsnow@redhat.com) wrote:
> > 
> > <snip>
> > 
> >> I'd rather do something like this:
> >> - Always flush bitmaps to disk on inactivate.
> > 
> > Does that increase the time taken by the inactivate measurably?
> > If it's small relative to everything else that's fine; it's just I
> > always worry a little since I think this happens after we've stopped the
> > CPU on the source, so is part of the 'downtime'.
> > 
> > Dave
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> I'm worried that if we don't, we're leaving behind unusable, partially
> complete files behind us. That's a bad design and we shouldn't push for
> it just because it's theoretically faster.

Oh I don't care about theoretical speed; but if it's actually unusably
slow in practice then it needs fixing.

Dave

> --js
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
