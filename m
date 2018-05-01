Received: from eggs.gnu.org ([2001:4830:134:3::10]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDaDb-0001SZ-Vp
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDaDY-0002i3-Q8
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:41:39 -0400
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:36964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDaDY-0002hg-IF
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:41:36 -0400
Received: by mail-pg0-x22c.google.com with SMTP id a13-v6so8837762pgu.4
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:41:36 -0700 (PDT)
References: <1525043888-90983-1-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d2446c1c-0142-37ae-9f43-ddb48d7a29b9@linaro.org>
Date: Tue, 1 May 2018 11:41:32 -0700
MIME-Version: 1.0
In-Reply-To: <1525043888-90983-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix missing break statement in
 disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, patches@groups.riscv.org

On 04/29/2018 04:18 PM, Michael Clark wrote:
> This fixes an issue when disassembling rv128 c.sqsp,
> where the code erroneously fell through to c.swsp.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  disas/riscv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
