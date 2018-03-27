Received: from eggs.gnu.org ([2001:4830:134:3::10]:51204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0plh-0006os-FM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0plb-0000Sf-U8
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:40:09 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f0plb-0000Sa-QW
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:40:03 -0400
Received: by mail-qt0-x244.google.com with SMTP id g5so13611396qth.7
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 07:40:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180327034757.3432-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7d460f16-2032-1278-1a49-c7f7cbf74d3f@amsat.org>
Date: Tue, 27 Mar 2018 11:39:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180327034757.3432-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg: Mark muluh_i64 and mulsh_i64
 as 64-bit ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, mjc@sifive.com

On 03/27/2018 12:47 AM, Richard Henderson wrote:
> Failure to do so results in the tcg optimizer sign-extending
> any constant fold from 32-bits.  This turns out to be visible
> in the RISC-V testsuite using a host that emits these opcodes
> (e.g. any non-x86_64).
> 
> Reported-by: Michael Clark <mjc@sifive.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg-opc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
> index d81a6c4535..e3a43aabb6 100644
> --- a/tcg/tcg-opc.h
> +++ b/tcg/tcg-opc.h
> @@ -182,8 +182,8 @@ DEF(add2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_add2_i64))
>  DEF(sub2_i64, 2, 4, 0, IMPL64 | IMPL(TCG_TARGET_HAS_sub2_i64))
>  DEF(mulu2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulu2_i64))
>  DEF(muls2_i64, 2, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muls2_i64))
> -DEF(muluh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_muluh_i64))
> -DEF(mulsh_i64, 1, 2, 0, IMPL(TCG_TARGET_HAS_mulsh_i64))
> +DEF(muluh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_muluh_i64))
> +DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
>  
>  #define TLADDR_ARGS  (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? 1 : 2)
>  #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
> 
