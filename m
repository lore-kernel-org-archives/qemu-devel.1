Received: from eggs.gnu.org ([2001:4830:134:3::10]:46184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccCUC-0004wc-JJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccCU7-0005Dj-IH
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:47:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ccCU7-0005Cr-CJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:47:39 -0500
Date: Fri, 10 Feb 2017 14:47:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170210144733.GG2568@work-vm>
References: <20170210122523.GC3567@work-vm>
	<20170210143651.24046-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170210143651.24046-1-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] migration: madvise error_report fixup!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: den@virtuozzo.com, armbru@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com

* Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I'll merge it in with the others when I queue it.

Dave

> ---
>  migration/qemu-file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 82dbef3c86..195fa94fcf 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -156,13 +156,13 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>              continue;
>          }
>          if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
> -            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
> +            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
>                           iov.iov_base, iov.iov_len, strerror(errno));
>          }
>          iov = f->iov[idx];
>      }
>      if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
> -            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
> +            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
>                           iov.iov_base, iov.iov_len, strerror(errno));
>      }
>      memset(f->may_free, 0, sizeof(f->may_free));
> -- 
> 2.11.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
