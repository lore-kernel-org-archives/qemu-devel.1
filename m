Received: from eggs.gnu.org ([2001:4830:134:3::10]:35220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIJ1B-0006iW-Cu
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIJ17-0003tw-HG
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:52:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIJ13-0003rn-0S
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 15:52:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id a8-v6so86130wmf.1
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 12:52:26 -0700 (PDT)
References: <20181101173852.27257-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f135878-e5ca-f1cb-2d76-de2ca8cb1625@linaro.org>
Date: Thu, 1 Nov 2018 19:52:22 +0000
MIME-Version: 1.0
In-Reply-To: <20181101173852.27257-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 11/1/18 5:38 PM, Laurent Vivier wrote:
> commit 27ae5109a2 has introduced an assembly instruction only supported
> by ISA 3.0B and it fails to execute on previous versions of the POWER
> CPU (like PowerPC G5).
> 
> This patch fixes that by checking the ISA level, and falls back to
> the default C function if the instruction is not supported.
> 
> Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
>        (softfloat: Specialize udiv_qrnnd for ppc64)
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 16 deletions(-)

Blah.  The divdeu insn was added into v2.06.

I knew I had tested this with a power7 host, which I think of as old.
But I guess not old enough.  I'll work something up.


r~
