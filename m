Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfJQ-0007cY-JF
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyfJP-0003gH-Nf
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 11:06:00 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3976794-7cb4-912d-d457-762dca65a2f8@redhat.com>
Date: Wed, 21 Mar 2018 10:05:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180321121940.39426-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] nbd/server: add nbd_meta_single_query
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> The helper will be reused for bitmaps namespace.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 41 ++++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
> 

> +/* Read len bytes and check matching to the pattern.
> + * @match is set to true on empty query for _LIST_ and for query matching the
> + * @pattern. @match is never set to false.

How about:

Read @len bytes, and set @match to true if they match @pattern, or if 
@len is 0 and the client is performing _LIST_.  @match is never set to 
false.

At any rate, the refactoring is sane; and comment touchups are trivial, so

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
