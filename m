Received: from eggs.gnu.org ([209.51.188.92]:32777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKNW-0003om-0a
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNKNV-0007mp-1m
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNKNU-0007kw-Ps
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:52:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so5446103pfa.3
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 09:52:40 -0700 (PDT)
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<20190504120528.6389-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71bb0c2e-5298-16de-0c15-eb6f2b4d2f11@linaro.org>
Date: Sun, 5 May 2019 09:52:36 -0700
MIME-Version: 1.0
In-Reply-To: <20190504120528.6389-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] coroutine: add host specific coroutine
 backend for 64-bit x86
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
> This backend is faster (100ns vs 150ns per switch on my laptop), but
> especially it will be possible to add CET support to it.  Most of the
> code is actually not architecture specific.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                        |  10 ++
>  scripts/qemugdb/coroutine.py     |   5 +-
>  scripts/qemugdb/coroutine_asm.py |  20 +++
>  util/Makefile.objs               |   1 +
>  util/coroutine-asm.c             | 230 +++++++++++++++++++++++++++++++
>  5 files changed, 264 insertions(+), 2 deletions(-)
>  create mode 100644 scripts/qemugdb/coroutine_asm.py
>  create mode 100644 util/coroutine-asm.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
