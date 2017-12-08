Received: from eggs.gnu.org ([2001:4830:134:3::10]:54955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNNlq-0004Sr-T9
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNNlp-0006VO-SK
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 13:53:14 -0500
References: <20171130164750.47320-1-vsementsov@virtuozzo.com>
	<20171130164750.47320-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e9d782a3-ecb2-950e-6e5a-526afb13c965@redhat.com>
Date: Fri, 8 Dec 2017 13:53:06 -0500
MIME-Version: 1.0
In-Reply-To: <20171130164750.47320-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] qcow2: fix indentation
 after previous patch
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



On 11/30/2017 11:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h | 34 +++++++++++++++++-----------------
>  block/qcow2.c | 16 ++++++++--------
>  2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 8f226a3609..896ad08e5b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -399,29 +399,29 @@ typedef enum QCow2ClusterType {
>  } QCow2ClusterType;
>  
>  typedef enum QCow2MetadataOverlap {
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
> +    QCOW2_OL_ACTIVE_L2_BITNR        = 2,
> +    QCOW2_OL_REFCOUNT_TABLE_BITNR   = 3,
> +    QCOW2_OL_REFCOUNT_BLOCK_BITNR   = 4,
> +    QCOW2_OL_SNAPSHOT_TABLE_BITNR   = 5,
> +    QCOW2_OL_INACTIVE_L1_BITNR      = 6,
> +    QCOW2_OL_INACTIVE_L2_BITNR      = 7,
>      QCOW2_OL_BITMAP_DIRECTORY_BITNR = 8,
>  
>      QCOW2_OL_MAX_BITNR              = 9,
>  
> -    QCOW2_OL_NONE           = 0,
> -    QCOW2_OL_MAIN_HEADER    = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
> -    QCOW2_OL_ACTIVE_L1      = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
> -    QCOW2_OL_ACTIVE_L2      = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
> -    QCOW2_OL_REFCOUNT_TABLE = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
> -    QCOW2_OL_REFCOUNT_BLOCK = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
> -    QCOW2_OL_SNAPSHOT_TABLE = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
> -    QCOW2_OL_INACTIVE_L1    = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
> +    QCOW2_OL_NONE             = 0,
> +    QCOW2_OL_MAIN_HEADER      = (1 << QCOW2_OL_MAIN_HEADER_BITNR),
> +    QCOW2_OL_ACTIVE_L1        = (1 << QCOW2_OL_ACTIVE_L1_BITNR),
> +    QCOW2_OL_ACTIVE_L2        = (1 << QCOW2_OL_ACTIVE_L2_BITNR),
> +    QCOW2_OL_REFCOUNT_TABLE   = (1 << QCOW2_OL_REFCOUNT_TABLE_BITNR),
> +    QCOW2_OL_REFCOUNT_BLOCK   = (1 << QCOW2_OL_REFCOUNT_BLOCK_BITNR),
> +    QCOW2_OL_SNAPSHOT_TABLE   = (1 << QCOW2_OL_SNAPSHOT_TABLE_BITNR),
> +    QCOW2_OL_INACTIVE_L1      = (1 << QCOW2_OL_INACTIVE_L1_BITNR),
>      /* NOTE: Checking overlaps with inactive L2 tables will result in bdrv
>       * reads. */
> -    QCOW2_OL_INACTIVE_L2    = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
> +    QCOW2_OL_INACTIVE_L2      = (1 << QCOW2_OL_INACTIVE_L2_BITNR),
>      QCOW2_OL_BITMAP_DIRECTORY = (1 << QCOW2_OL_BITMAP_DIRECTORY_BITNR),
>  } QCow2MetadataOverlap;
>  
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8278c0e124..23f36a67c7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -687,14 +687,14 @@ static QemuOptsList qcow2_runtime_opts = {
>  };
>  
>  static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
> -    [QCOW2_OL_MAIN_HEADER_BITNR]    = QCOW2_OPT_OVERLAP_MAIN_HEADER,
> -    [QCOW2_OL_ACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L1,
> -    [QCOW2_OL_ACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_ACTIVE_L2,
> -    [QCOW2_OL_REFCOUNT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
> -    [QCOW2_OL_REFCOUNT_BLOCK_BITNR] = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
> -    [QCOW2_OL_SNAPSHOT_TABLE_BITNR] = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
> -    [QCOW2_OL_INACTIVE_L1_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L1,
> -    [QCOW2_OL_INACTIVE_L2_BITNR]    = QCOW2_OPT_OVERLAP_INACTIVE_L2,
> +    [QCOW2_OL_MAIN_HEADER_BITNR]      = QCOW2_OPT_OVERLAP_MAIN_HEADER,
> +    [QCOW2_OL_ACTIVE_L1_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L1,
> +    [QCOW2_OL_ACTIVE_L2_BITNR]        = QCOW2_OPT_OVERLAP_ACTIVE_L2,
> +    [QCOW2_OL_REFCOUNT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_TABLE,
> +    [QCOW2_OL_REFCOUNT_BLOCK_BITNR]   = QCOW2_OPT_OVERLAP_REFCOUNT_BLOCK,
> +    [QCOW2_OL_SNAPSHOT_TABLE_BITNR]   = QCOW2_OPT_OVERLAP_SNAPSHOT_TABLE,
> +    [QCOW2_OL_INACTIVE_L1_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L1,
> +    [QCOW2_OL_INACTIVE_L2_BITNR]      = QCOW2_OPT_OVERLAP_INACTIVE_L2,
>      [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
>  };
>  
> 

Squash it in, or don't, either way:

Reviewed-by: John Snow <jsnow@redhat.com>
