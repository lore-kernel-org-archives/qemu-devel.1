Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPEg-00088q-8X
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPEf-0005aa-1b
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:51:22 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-3-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55308115-db8c-ed71-d61c-4f8a3a1d4e70@redhat.com>
Date: Thu, 14 Dec 2017 09:51:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171214005953.8898-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] blockjob: consolidate SLICE_TIME
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 14/12/2017 01:59, John Snow wrote:
> They're all the same. If it actually becomes important to configure it,
> it can become a job or driver property.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c               | 1 -
>  block/commit.c               | 2 --
>  block/mirror.c               | 1 -
>  block/stream.c               | 2 --
>  include/block/blockjob_int.h | 2 ++
>  5 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/block/backup.c b/block/backup.c
> index 99e6bcc748..d71b25c017 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -27,7 +27,6 @@
>  #include "qemu/error-report.h"
>  
>  #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
> -#define SLICE_TIME 100000000ULL /* ns */
>  
>  typedef struct BackupBlockJob {
>      BlockJob common;
> diff --git a/block/commit.c b/block/commit.c
> index c5327551ce..873e749d50 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -31,8 +31,6 @@ enum {
>      COMMIT_BUFFER_SIZE = 512 * 1024, /* in bytes */
>  };
>  
> -#define SLICE_TIME 100000000ULL /* ns */
> -
>  typedef struct CommitBlockJob {
>      BlockJob common;
>      RateLimit limit;
> diff --git a/block/mirror.c b/block/mirror.c
> index d35c688faa..eef5b598f5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -22,7 +22,6 @@
>  #include "qemu/ratelimit.h"
>  #include "qemu/bitmap.h"
>  
> -#define SLICE_TIME    100000000ULL /* ns */
>  #define MAX_IN_FLIGHT 16
>  #define MAX_IO_BYTES (1 << 20) /* 1 Mb */
>  #define DEFAULT_MIRROR_BUF_SIZE (MAX_IN_FLIGHT * MAX_IO_BYTES)
> diff --git a/block/stream.c b/block/stream.c
> index 499cdacdb0..e85af18c54 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -29,8 +29,6 @@ enum {
>      STREAM_BUFFER_SIZE = 512 * 1024, /* in bytes */
>  };
>  
> -#define SLICE_TIME 100000000ULL /* ns */
> -
>  typedef struct StreamBlockJob {
>      BlockJob common;
>      RateLimit limit;
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index c9b23b0cc9..209fa1bb3e 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -29,6 +29,8 @@
>  #include "block/blockjob.h"
>  #include "block/block.h"
>  
> +#define SLICE_TIME 100000000ULL /* ns */
> +
>  /**
>   * BlockJobDriver:
>   *
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
