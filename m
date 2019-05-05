Received: from eggs.gnu.org ([209.51.188.92]:34245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKVZ-0006cy-Hk
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKVX-0003XI-BY
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:01:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKVV-0003SG-HS
	for qemu-devel@nongnu.org; Sun, 05 May 2019 13:00:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id z16so5224567pgv.11
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 10:00:54 -0700 (PDT)
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-5-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c5f2f531-34ce-d7b2-a6d7-1a2399466cf5@linaro.org>
Date: Sun, 5 May 2019 10:00:50 -0700
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] coroutine: add host specific coroutine
 backend for 64-bit ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com

On 5/4/19 5:05 AM, Paolo Bonzini wrote:
> The speedup is similar to x86, 120 ns vs 180 ns on an APM Mustang.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                        |  2 +-
>  scripts/qemugdb/coroutine_asm.py |  6 ++++-
>  util/Makefile.objs               |  2 ++
>  util/coroutine-asm.c             | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 53 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +        "ldr x30, [x1, %[SCRATCH]]\n"    /* load destination PC */   \
> +        "ldr x1, [x1, %[SP]]\n"          /* load destination SP */   \
> +        "mov sp, x1\n"                                               \
> +        "br x30\n"                                                   \
> +        "2: \n"                                                      \

For future reference, "bti j" (aka hint #36) goes here,
for the aarch64 branch target identification extension.


r~
