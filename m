Received: from eggs.gnu.org ([2001:4830:134:3::10]:54859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkYs-0008OV-Dh
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkYr-0005v9-Hq
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:08:34 -0400
References: <20180507154458.73945-1-vsementsov@virtuozzo.com>
	<20180507154458.73945-6-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d061f619-d1f7-57be-d8f0-0792ca64504a@redhat.com>
Date: Mon, 7 May 2018 13:08:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180507154458.73945-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] block/nbd-client: don't check ioc
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

On 05/07/2018 10:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> We have several paranoiac checks for ioc != NULL. But ioc may become
> NULL only on close, which should not happen during requests handling.
> Also, we check ioc only sometimes, not after each yield, which is
> inconsistent. Let's drop these checks.

Can (or even should) any of these be replaced by asserts that ioc is not 
NULL?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/nbd-client.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
