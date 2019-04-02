Received: from eggs.gnu.org ([209.51.188.92]:45704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hB7FE-0006Ee-RY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hB7FC-0003B1-Js
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:25:39 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hB7F8-00031c-Dg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 20:25:38 -0400
Received: by mail-pg1-x52f.google.com with SMTP id k3so5599686pga.6
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:25:34 -0700 (PDT)
References: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3b820a9d-a807-d3d9-b574-a6de2c5d29d1@linaro.org>
Date: Tue, 2 Apr 2019 07:25:25 +0700
MIME-Version: 1.0
In-Reply-To: <CANnJOVHadZt5Vho5sy6FGVgUW_yvYZg7BGDiGJFtRBCquyOXZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Do not allow sfence.vma from
 user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Behrens <fintelia@gmail.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 4/2/19 2:12 AM, Jonathan Behrens wrote:
> The 'sfence.vma' instruction is privileged, and should only ever be allowed
> when executing in supervisor mode or higher.
> 
> Jonathan
> 
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
> ---
>  target/riscv/op_helper.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
