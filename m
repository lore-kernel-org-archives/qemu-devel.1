Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7Ln1-0005Ht-NL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7LcW-0004GB-7A
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:25:52 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <767ac69d-781f-6d43-5183-19c2975715f8@redhat.com>
Date: Tue, 2 Oct 2018 09:25:32 -0500
MIME-Version: 1.0
In-Reply-To: <20181002113325.12911-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: drop x- from
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, jsnow@redhat.com

On 10/2/18 6:33 AM, Vladimir Sementsov-Ogievskiy wrote:
> Libvirt part is ready, let's drop x- prefix.

A link to the libvirt list archives would be useful.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json | 4 ++--
>   blockdev.c           | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 

> @@ -548,7 +548,7 @@
>   #      "arguments": { "device": "drive0" } }
>   # <- { "return": {} }

As part of renaming this, you need to change the 'Since: 2.12' tag to 
now read 3.1.  That is, we are introducing a brand new command (at the 
same time we delete an experimental one), and that is particularly true 
if you take my advice on the previous commit about getting rid of the 
'device' parameter at the same time.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
