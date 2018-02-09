Received: from eggs.gnu.org ([2001:4830:134:3::10]:34470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFCe-0005aC-Fk
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFCb-0005uA-An
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:23:24 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:55618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFCb-0005tq-4w
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:23:21 -0500
Received: by mail-it0-x244.google.com with SMTP id b66so12449086itd.5
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 12:23:21 -0800 (PST)
References: <20180209104546.29401-1-pbonzini@redhat.com>
	<20180209104546.29401-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0205fd0a-75f2-84ec-2316-e8e8c0aae5c5@linaro.org>
Date: Fri, 9 Feb 2018 12:23:17 -0800
MIME-Version: 1.0
In-Reply-To: <20180209104546.29401-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] memory: unify loops to sync dirty log
 bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

On 02/09/2018 02:45 AM, Paolo Bonzini wrote:
> Now that memory_region_sync_dirty_bitmap is NULL, we can unify its
> loop with memory_global_dirty_log_sync's.  The only difference is
> that memory_region_sync_dirty_bitmap will no longer call log_sync on
> FlatRanges that do have a zero dirty_log_mask, but this is okay because
> video memory is always registered with the dirty page logging mechanism.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  memory.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
