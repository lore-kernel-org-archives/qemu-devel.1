Received: from eggs.gnu.org ([2001:4830:134:3::10]:40791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHAKC-0002Di-HC
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eHAK4-0000xZ-RG
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:19:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eHAK4-0000wB-LM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:18:52 -0500
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2a7e3fa-a660-a1e1-9e34-4585a10ae6ad@redhat.com>
Date: Tue, 21 Nov 2017 16:18:49 +0100
MIME-Version: 1.0
In-Reply-To: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory-internal.h: Remove obsolete claim
 that header is obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 21/11/2017 16:08, Peter Maydell wrote:
> The memory-internal.h header claims that it is for "obsolete
> exec.c functions" which "will be removed soon". This statement
> was added in 2011, six years ago, but the header is still here.
> (Admittedly none of the prototypes added in commit 67d95c153bef55f6
> are still in the header.)
> 
> It's convenient to have a place to put prototypes for functions
> which are used internally to the various .c files of the memory
> system or by the accel/tcg code, which is inevitably fairly
> closely coupled. So keep the header but update the comments to
> reflect what we're actually using it for.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/memory-internal.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
> index 98d8296..4162474 100644
> --- a/include/exec/memory-internal.h
> +++ b/include/exec/memory-internal.h
> @@ -1,5 +1,5 @@
>  /*
> - * Declarations for obsolete exec.c functions
> + * Declarations for functions which are internal to the memory subsystem.
>   *
>   * Copyright 2011 Red Hat, Inc. and/or its affiliates
>   *
> @@ -12,8 +12,9 @@
>   */
>  
>  /*
> - * This header is for use by exec.c and memory.c ONLY.  Do not include it.
> - * The functions declared here will be removed soon.
> + * This header is for use by exec.c, memory.c and accel/tcg/cputlb.c ONLY,
> + * for declarations which are shared between the memory subsystem's
> + * internals and the TCG TLB code. Do not include it from elsewhere.
>   */
>  
>  #ifndef MEMORY_INTERNAL_H
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,

Paolo
