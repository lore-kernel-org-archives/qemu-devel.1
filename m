Received: from eggs.gnu.org ([2001:4830:134:3::10]:33471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eureE-0007dq-Ju
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eureD-0001Ii-No
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 22:27:46 -0500
References: <20180309165212.97144-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed037788-dca9-a34e-bf4b-373d399cd7c0@redhat.com>
Date: Sat, 10 Mar 2018 21:27:22 -0600
MIME-Version: 1.0
In-Reply-To: <20180309165212.97144-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

On 03/09/2018 10:52 AM, Vladimir Sementsov-Ogievskiy wrote:
> v6:
> 
> Use correct header qapi/qapi-builtin-types.h, to fix build again.
> Sorry for spam =(
> 
> 

> Vladimir Sementsov-Ogievskiy (2):
>    block/accounting: introduce latency histogram
>    qapi: add block latency histogram interface

This touches both block and QAPI, but I've gone ahead and queued it on 
the QAPI tree.  Not much time left if you want to drop the x- prefix and 
make this interface officially supported for 2.12.  Queued:

git://repo.or.cz/qemu/ericb.git qapi
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi

I'll send a PULL request for my QAPI tree as my first act on Monday.

> 
>   qapi/block-core.json       | 111 ++++++++++++++++++++++++++++++++++++++++++++-
>   include/block/accounting.h |  35 ++++++++++++++
>   block/accounting.c         |  91 +++++++++++++++++++++++++++++++++++++
>   block/qapi.c               |  41 +++++++++++++++++
>   blockdev.c                 |  43 ++++++++++++++++++
>   5 files changed, 320 insertions(+), 1 deletion(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
