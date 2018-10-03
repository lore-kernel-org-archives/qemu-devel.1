Received: from eggs.gnu.org ([2001:4830:134:3::10]:44529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7iao-0006w8-7d
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7ian-0006eD-Ej
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:57:38 -0400
References: <20181003144738.70670-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <121a81ed-7932-b96c-cc84-60b82725d8e1@redhat.com>
Date: Wed, 3 Oct 2018 09:57:30 -0500
MIME-Version: 1.0
In-Reply-To: <20181003144738.70670-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org, qemu-stable <qemu-stable@nongnu.org>

On 10/3/18 9:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> We should not go to structured-read branch on CACHE command, fix that.
> 
> Bug intoroduced in bc37b06a5cde24 "nbd/server: introduce NBD_CMD_CACHE"

s/intoroduced/introduced/

> with the whole feature and affects 3.0.0 release.

Ouch. It's because I don't have an NBD client that can issue the 
command, so the server side got released without sufficient testing. Is 
there some way we could enhance qemu-io as NBD client to issue such a 
command?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

CC: qemu-stable@nongnu.org

Reviewed-by: Eric Blake <eblake@redhat.com>

Will queue through my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
