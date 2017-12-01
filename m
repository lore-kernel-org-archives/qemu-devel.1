Received: from eggs.gnu.org ([2001:4830:134:3::10]:58631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKpYX-0003Zu-Qd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKpYU-0004U6-Hq
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:56:57 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02b78b18-1a78-3144-12cf-0831821c930b@redhat.com>
Date: Fri, 1 Dec 2017 11:56:46 -0600
MIME-Version: 1.0
In-Reply-To: <20171130164750.47320-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qcow2: fix indentation after previous
 patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

On 11/30/2017 10:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/qcow2.h | 34 +++++++++++++++++-----------------
>   block/qcow2.c | 16 ++++++++--------
>   2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 8f226a3609..896ad08e5b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -399,29 +399,29 @@ typedef enum QCow2ClusterType {
>   } QCow2ClusterType;
>   
>   typedef enum QCow2MetadataOverlap {
> -    QCOW2_OL_MAIN_HEADER_BITNR    = 0,
> -    QCOW2_OL_ACTIVE_L1_BITNR      = 1,
> -    QCOW2_OL_ACTIVE_L2_BITNR      = 2,
> -    QCOW2_OL_REFCOUNT_TABLE_BITNR = 3,
> -    QCOW2_OL_REFCOUNT_BLOCK_BITNR = 4,
> -    QCOW2_OL_SNAPSHOT_TABLE_BITNR = 5,
> -    QCOW2_OL_INACTIVE_L1_BITNR    = 6,
> -    QCOW2_OL_INACTIVE_L2_BITNR    = 7,
> +    QCOW2_OL_MAIN_HEADER_BITNR      = 0,
> +    QCOW2_OL_ACTIVE_L1_BITNR        = 1,

This demonstrates why I'm a fan of single space before =:
     foo = 1,
     blah = 2,
because it is needless churn to realign everything if you add a new 
longer line that doesn't fit with the earlier alignment of =.  But we 
don't have a clear preference for either code style, and I'm also okay 
if you just squash this in with the previous patch or omit it altogether.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
