Received: from eggs.gnu.org ([2001:4830:134:3::10]:37962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZuqb-0004r3-VR
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gZuqY-00064I-Pt
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:42:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gZuqY-00060b-HY
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 04:42:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id z5so982353wrt.11
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 01:42:26 -0800 (PST)
References: <20181220043315.8848-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <892b1691-e153-1400-c77d-7014a43d3e5a@redhat.com>
Date: Thu, 20 Dec 2018 10:42:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181220043315.8848-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] disas/microblaze: Remove unused REG_SP
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, Michael Clark <mjc@sifive.com>

On 12/20/18 5:33 AM, Richard Henderson wrote:
> This causes a build error with debian sid, riscv64 host:
> 
> disas/microblaze.c:179: error: "REG_SP" redefined [-Werror]
>  #define REG_SP  1 /* stack pointer */
> 
> In file included from /usr/include/signal.h:306,
>                  from include/qemu/osdep.h:101,
>                  from disas/microblaze.c:36:
> /usr/include/riscv64-linux-gnu/sys/ucontext.h:36: note: this is the location of the previous definition
>  # define REG_SP 2
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  disas/microblaze.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 598ecbc89d..c23605043a 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -176,7 +176,6 @@ enum microblaze_instr_type {
>  #define REG_TLBSX 36869 /* MMU: TLB Search Index reg */
>  
>  /* alternate names for gen purpose regs */
> -#define REG_SP  1 /* stack pointer */

This is clever than my previous suggestion:
https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00171.html

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  #define REG_ROSDP 2 /* read-only small data pointer */
>  #define REG_RWSDP 13 /* read-write small data pointer */
>  
> 
