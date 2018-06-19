Received: from eggs.gnu.org ([2001:4830:134:3::10]:56433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLhw-0001F4-MJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLhv-0002SO-So
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:50:24 -0400
References: <20180619183457.371081-1-vsementsov@virtuozzo.com>
	<20180619183457.371081-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <22f38c8e-8fbb-352e-ab15-b5e5f20ac03e@redhat.com>
Date: Tue, 19 Jun 2018 13:50:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180619183457.371081-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] block/qcow2-refcount:
 check_refcounts_l2: refactor compressed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

On 06/19/2018 01:34 PM, Vladimir Sementsov-Ogievskiy wrote:
> Separate offset and size of compressed cluster.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2-refcount.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

Hmm, I wonder if this duplicates my pending patch:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04542.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
