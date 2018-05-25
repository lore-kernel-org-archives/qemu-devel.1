Received: from eggs.gnu.org ([2001:4830:134:3::10]:56220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMERa-0008Ju-S0
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fMERX-0002eU-LW
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:50 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fMERX-0002e9-Gw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:47 -0400
Received: by mail-qk0-x243.google.com with SMTP id j12-v6so974009qkk.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 08:15:47 -0700 (PDT)
References: <1527034517-7851-1-git-send-email-mjc@sifive.com>
	<1527034517-7851-5-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb6f5ca0-35d1-e9d8-b7ef-754edae46d2a@linaro.org>
Date: Fri, 25 May 2018 08:15:41 -0700
MIME-Version: 1.0
In-Reply-To: <1527034517-7851-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/30] RISC-V: Simplify
 riscv_cpu_local_irqs_pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 05/22/2018 05:14 PM, Michael Clark wrote:
> This commit is intended to improve readability.
> There is no change to the logic.
> 
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/helper.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
