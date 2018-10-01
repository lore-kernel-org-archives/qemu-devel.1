Received: from eggs.gnu.org ([2001:4830:134:3::10]:38608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g6ynZ-0002LH-Dv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g6ynT-0001p7-OW
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:03:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g6ynT-0001o0-Bb
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:03:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id e21-v6so13130601otk.10
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 07:03:38 -0700 (PDT)
References: <1538118095-7003-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee55802f-fb09-fb6d-5650-33c94cf9a0ef@linaro.org>
Date: Mon, 1 Oct 2018 09:03:34 -0500
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
