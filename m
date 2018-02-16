Received: from eggs.gnu.org ([2001:4830:134:3::10]:45153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjvR-00081y-6Q
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emjvQ-0004MU-AY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:35:57 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-5-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <460473c8-8970-0bc3-0055-b50f60af2445@redhat.com>
Date: Fri, 16 Feb 2018 11:35:41 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-5-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] block/nbd-client: save first fatal
 error in nbd_iter_error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> It is ok, that fatal error hides previous not fatal, but hiding
> first fatal error is a bad feature.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd-client.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Can this trigger in 2.11 clients with structured reads to the point 
where we'd want to add qemu-stable in CC?  Or did you only hit it once 
block_status was added to the mix?

Note that comparing 2.11 server with 2.11 client doesn't help - because 
2.11 as server only sends a single chunk per structured read (as the 
only structured reply); it wasn't until commit 418638d3 that we have a 
qemu server that can send multiple chunks, and it looks like you need 
multiple chunks before multiple errors becomes a possibility.

At any rate,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
