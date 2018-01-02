Received: from eggs.gnu.org ([2001:4830:134:3::10]:33182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWTCQ-0003eI-TP
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eWTCQ-0004jX-4Y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:30:14 -0500
Date: Tue, 2 Jan 2018 15:29:58 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180102202958.GA26116@localhost.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-3-jsnow@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

On Wed, Dec 13, 2017 at 07:59:48PM -0500, John Snow wrote:
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
> -- 
> 2.14.3
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
