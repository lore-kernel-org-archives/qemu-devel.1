Received: from eggs.gnu.org ([2001:4830:134:3::10]:48177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO2wK-0000Zw-IM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fO2wJ-0004n0-ME
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:23:04 -0400
References: <20180530112424.204835-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3b0f6f9-9a12-51ee-1566-f387f9c30239@redhat.com>
Date: Wed, 30 May 2018 10:22:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180530112424.204835-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix
 dirty_bitmap_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-stable@nongnu.org

On 05/30/2018 06:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> dirty_bitmap_load_header return code is obtained but not handled. Fix
> this.
> 
> Bug was introduced in b35ebdf076d697bc
> "migration: add postcopy migration of dirty bitmaps" with the whole
> function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   migration/block-dirty-bitmap.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
