Received: from eggs.gnu.org ([2001:4830:134:3::10]:49195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwd3g-0003VJ-GI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:12:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cwd3c-0004Ds-H5
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cwd3c-0004Dn-BA
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 19:12:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E8D861D15
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 23:12:43 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-3-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <db112c85-7ea9-509d-dbf7-cebc19623653@redhat.com>
Date: Fri, 7 Apr 2017 19:12:42 -0400
MIME-Version: 1.0
In-Reply-To: <20170323173928.14439-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] blockjob: remove iostatus_reset
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
> This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus",
> 2016-05-19).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 3 ---
>  include/block/blockjob_int.h | 3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index a9fb624..24d1e12 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
>  void block_job_iostatus_reset(BlockJob *job)
>  {
>      job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
> -    if (job->driver->iostatus_reset) {
> -        job->driver->iostatus_reset(job);
> -    }
>  }
>  
>  static int block_job_finish_sync(BlockJob *job,
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
> index 3f86cc5..bfcc5d1 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -44,9 +44,6 @@ struct BlockJobDriver {
>      /** Optional callback for job types that support setting a speed limit */
>      void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
>  
> -    /** Optional callback for job types that need to forward I/O status reset */
> -    void (*iostatus_reset)(BlockJob *job);
> -
>      /** Mandatory: Entrypoint for the Coroutine. */
>      CoroutineEntry *start;
>  
> 

Good find.

Reviewed-by: John Snow <jsnow@redhat.com>
