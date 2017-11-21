Received: from eggs.gnu.org ([2001:4830:134:3::10]:52622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAuz-00060O-IF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAuw-0001dC-Gb
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:57:01 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAuw-0001d4-Bb
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:56:58 -0500
Received: by mail-qk0-x243.google.com with SMTP id b85so12672494qkc.13
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 07:56:58 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4cf3ddce-b83f-3891-524e-5c3b1440f1cd@amsat.org>
Date: Tue, 21 Nov 2017 12:56:11 -0300
MIME-Version: 1.0
In-Reply-To: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

Hi Peter,

On 11/21/2017 12:08 PM, Peter Maydell wrote:
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

Until your NotDirtyInfo addition, the only prototype used was
memory_region_access_valid() (in s390-pci-inst.c).

Since "none of the prototypes added in commit 67d95c153bef55f6 are still
in the header" we could restrict it out of include/exec/ (kinda 'revert'
022c62cbbc) and only keep memory_region_access_valid() + NotDirtyInfo
exposed in include/exec/.

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
