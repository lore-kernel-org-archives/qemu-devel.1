Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fiS8b-0007lK-Lb
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 18:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fiS8Y-0004na-LS
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 18:20:05 -0400
References: <20180725142758.9980-1-lbloch@janustech.com>
	<20180725142758.9980-2-lbloch@janustech.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8dde2638-0e6e-107c-146a-6186c198ede3@redhat.com>
Date: Wed, 25 Jul 2018 18:19:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180725142758.9980-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 1/4 for-3.0] qcow2: A
 grammar fix in conflicting cache sizing error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/25/2018 10:27 AM, Leonid Bloch wrote:
> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>  block/qcow2.c              | 2 +-
>  tests/qemu-iotests/103.out | 4 ++--
>  tests/qemu-iotests/137.out | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6162ed8be2..ec9e6238a0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -797,7 +797,7 @@ static void read_cache_sizes(BlockDriverState *bs, QemuOpts *opts,
>          if (l2_cache_size_set && refcount_cache_size_set) {
>              error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
>                         " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
> -                       "the same time");
> +                       "at the same time");
>              return;
>          } else if (*l2_cache_size > combined_cache_size) {
>              error_setg(errp, QCOW2_OPT_L2_CACHE_SIZE " may not exceed "
> diff --git a/tests/qemu-iotests/103.out b/tests/qemu-iotests/103.out
> index bd45d3875a..bd9eec3250 100644
> --- a/tests/qemu-iotests/103.out
> +++ b/tests/qemu-iotests/103.out
> @@ -5,10 +5,10 @@ wrote 65536/65536 bytes at offset 0
>  
>  === Testing invalid option combinations ===
>  
> -can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
> +can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
>  can't open device TEST_DIR/t.IMGFMT: l2-cache-size may not exceed cache-size
>  can't open device TEST_DIR/t.IMGFMT: refcount-cache-size may not exceed cache-size
> -can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set the same time
> +can't open device TEST_DIR/t.IMGFMT: cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
>  can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
>  can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
>  can't open device TEST_DIR/t.IMGFMT: L2 cache entry size must be a power of two between 512 and the cluster size (65536)
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 96724a6c33..6a2ffc71fd 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -16,7 +16,7 @@ read 33554432/33554432 bytes at offset 0
>  === Try setting some invalid values ===
>  
>  Parameter 'lazy-refcounts' expects 'on' or 'off'
> -cache-size, l2-cache-size and refcount-cache-size may not be set the same time
> +cache-size, l2-cache-size and refcount-cache-size may not be set at the same time
>  l2-cache-size may not exceed cache-size
>  refcount-cache-size may not exceed cache-size
>  L2 cache size too big
> 

Reviewed-by: John Snow <jsnow@redhat.com>
