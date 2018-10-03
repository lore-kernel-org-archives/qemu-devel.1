Received: from eggs.gnu.org ([2001:4830:134:3::10]:39611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l1H-0000QF-68
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7l1G-0003Af-BU
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:33:07 -0400
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bccd1e94-431f-c7cf-4a0c-599dcf345e73@redhat.com>
Date: Wed, 3 Oct 2018 12:32:54 -0500
MIME-Version: 1.0
In-Reply-To: <20181003170228.95973-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] nbd server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

On 10/3/18 12:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> It's unexpected behavior that without -x option qemu-nbd do old-style
> negotiation. Let's use "" as a default name instead (as it is already
> done if tls is used) and therefore, drop old-style negotiation from
> Qemu NBD server.

Oddly enough, I wrote a similar patch in parallel, and am only now just 
seeing your mail. Yours is a bit stronger than mine (I added 'qemu-nbd 
-O' to allow explicit fallback to oldstyle, while you ripped it out 
altogether).  The client can negotiate either style, so we don't need an 
option on the client side; rather, this is all about what the server 
should do by default.

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00568.html

Does anyone have a preference between the two? Here's the last time it 
was discussed:

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03252.html

> 
> Vladimir Sementsov-Ogievskiy (2):
>    qemu-nbd: drop old-style negotiation
>    nbd/server: drop old-style negotiation
> 
>   include/block/nbd.h |  3 +--
>   blockdev-nbd.c      |  2 +-
>   nbd/server.c        | 53 +++++++++++++--------------------------------
>   qemu-nbd.c          | 25 +++++----------------
>   4 files changed, 23 insertions(+), 60 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
