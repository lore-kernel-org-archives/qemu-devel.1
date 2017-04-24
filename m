Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2nGV-0007Xg-GI
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d2nGS-0004o3-BU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:19:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d2nGS-0004nk-4x
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:19:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4FA781138
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 23:19:26 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-2-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c05d36c8-28a1-aa2e-1540-e799e1aa9e74@redhat.com>
Date: Mon, 24 Apr 2017 19:19:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170419144219.20371-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Worth a resend to CC qemu-block, include a cover letter, and all the
usual amenities?

On 04/19/2017 10:42 AM, Paolo Bonzini wrote:
> !job is always checked prior to the call, drop it from here.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 6e48932..23022b3 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
>  
>  bool block_job_user_paused(BlockJob *job)
>  {
> -    return job ? job->user_paused : 0;
> +    return job->user_paused;
>  }
>  
>  void coroutine_fn block_job_pause_point(BlockJob *job)
> 

Reviewed-by: John Snow <jsnow@redhat.com>
