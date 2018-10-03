Received: from eggs.gnu.org ([2001:4830:134:3::10]:34400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7kqg-0001Po-Vr
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7kqc-0002tL-WF
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:22:10 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7kqc-0002sj-IH
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:22:06 -0400
Received: by mail-oi1-x242.google.com with SMTP id k64-v6so5165768oia.13
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 10:22:06 -0700 (PDT)
References: <1538118095-7003-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <567fd724-ee48-41f5-b36b-c879b55fe160@linaro.org>
Date: Wed, 3 Oct 2018 12:22:02 -0500
MIME-Version: 1.0
In-Reply-To: <1538118095-7003-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: Replace
 countLeadingZeros32/64 with clz32/64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 9/28/18 2:01 AM, Thomas Huth wrote:
> Our minimum required compiler for compiling QEMU is GCC 4.1 these days,
> so we can drop the support for compilers which do not provide the
> __builtin_clz*() functions yet. Since the countLeadingZeros32/64 are
> then identical to the clz32/64 functions, and we do not have to sync
> the softloat 2 codebase with upstream anymore (softloat 3 is a complete
> rewrite) we can simply replace the functions with our QEMU versions.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  fpu/softfloat.c                | 26 ++++++-------
>  include/fpu/softfloat-macros.h | 87 ------------------------------------------
>  2 files changed, 13 insertions(+), 100 deletions(-)

Queued, thanks.


r~
