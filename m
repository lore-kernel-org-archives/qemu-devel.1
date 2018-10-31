Received: from eggs.gnu.org ([2001:4830:134:3::10]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHoGu-00010c-Vw
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHoGp-0002Ef-A7
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:02:48 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHoGo-0002BR-LT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:02:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id 189-v6so14680751wmw.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 04:02:38 -0700 (PDT)
References: <20181030165554.5761-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <608f70b3-e262-0077-9604-375ccb89907a@linaro.org>
Date: Wed, 31 Oct 2018 11:02:35 +0000
MIME-Version: 1.0
In-Reply-To: <20181030165554.5761-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: use EXCP_ILLEGAL instead of
 EXCP_UNSUPPORTED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 10/30/18 4:55 PM, Laurent Vivier wrote:
> Coldfire defines an "Unsupported instruction" exception if execution
> of a valid instruction is attempted but the required hardware is not
> present in the processor.
> 
> We use it with instructions that are in fact undefined or illegal,
> and the exception expected in this case by the kernel is the
> illegal exception, so this patch fixes that.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/m68k/cpu_loop.c | 1 -
>  target/m68k/cpu.h          | 1 -
>  target/m68k/translate.c    | 6 +++---
>  3 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
