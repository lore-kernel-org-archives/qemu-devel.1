Received: from eggs.gnu.org ([2001:4830:134:3::10]:46146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eqfwa-0006zm-2c
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eqfwU-0002sL-E9
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:09:24 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:49524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eqfwU-0002s5-44
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:09:18 -0500
References: <1519683480-33201-1-git-send-email-mjc@sifive.com>
	<1519683480-33201-9-git-send-email-mjc@sifive.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <9c743e0d-73f6-5972-77dc-ed07ed86953c@mail.uni-paderborn.de>
Date: Tue, 27 Feb 2018 15:06:24 +0100
MIME-Version: 1.0
In-Reply-To: <1519683480-33201-9-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 08/23] RISC-V TCG Code Generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 02/26/2018 11:17 PM, Michael Clark wrote:
> TCG code generation for the RV32IMAFDC and RV64IMAFDC. The QEMU
> RISC-V code generator has complete coverage for the Base ISA v2.2,
> Privileged ISA v1.9.1 and Privileged ISA v1.10:
> 
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/instmap.h   |  364 +++++++++
>  target/riscv/translate.c | 1974 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2338 insertions(+)
>  create mode 100644 target/riscv/instmap.h
>  create mode 100644 target/riscv/translate.c
> 

Since I contributed here and Peter wants all the relevant SoB's, here is
mine:

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cheers,
Bastian
