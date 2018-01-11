Received: from eggs.gnu.org ([2001:4830:134:3::10]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZf5B-0000nC-Bu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZf58-0003RZ-8n
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:47:57 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38769)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZf58-0003Q5-1r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:47:54 -0500
Received: by mail-pg0-x243.google.com with SMTP id t67so2426349pgc.5
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 07:47:53 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-9-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b8162d6-f20e-270c-2aad-9c34eb00759d@linaro.org>
Date: Thu, 11 Jan 2018 07:47:50 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-9-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/21] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/10/2018 06:21 PM, Michael Clark wrote:
> TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
> RISC-V code generator has complete coverage for the Base ISA v2.2,
> Privileged ISA v1.9.1 and Privileged ISA v1.10:
> 
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/instmap.h   |  377 +++++++++
>  target/riscv/translate.c | 1982 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2359 insertions(+)
>  create mode 100644 target/riscv/instmap.h
>  create mode 100644 target/riscv/translate.c

While there is forward progress within translate.c, it would seem that quite a
lot of my v1 comments are not yet addressed.

Also,

> +        if (!riscv_has_ext(env, RVC)) {

You may not access env in this way.  Any code generation differences must be
computable from either unchanging values on the cpu or tb->flags.  MISA is not
unchanging -- you allow runtime modification.

Again, the partial patch I saw from Stefan would fix this.


r~
