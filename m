Received: from eggs.gnu.org ([2001:4830:134:3::10]:49904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IL-000175-Aj
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f73IK-0002ln-Ay
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:33 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f73IK-0002lb-3n
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:19:32 -0400
Received: by mail-pl0-x244.google.com with SMTP id c7-v6so6525265plr.5
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:19:32 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-17-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <409e500c-dd47-ba32-cc0b-75d472db22d1@linaro.org>
Date: Thu, 12 Apr 2018 18:36:52 -1000
MIME-Version: 1.0
In-Reply-To: <1523038800-2494-17-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/17] target/riscv: convert to
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 04/06/2018 08:19 AM, Emilio G. Cota wrote:
> Notes:
> 
> - Did not convert {num,max}_insns, since the corresponding code
>   will go away in the next patch.
> 
> - ctx->pc becomes ctx->base.pc_next, and ctx->next_pc becomes ctx->pc_tmp.
> 
> While at it, convert the remaining tb->cflags readers to tb_cflags().
> 
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/riscv/translate.c | 129 +++++++++++++++++++++++------------------------
>  1 file changed, 64 insertions(+), 65 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
