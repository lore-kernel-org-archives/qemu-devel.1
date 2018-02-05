Received: from eggs.gnu.org ([2001:4830:134:3::10]:60840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihZr-0002T1-6O
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eihZn-0007o6-VT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:16:59 -0500
Received: from mail-pl0-x233.google.com ([2607:f8b0:400e:c01::233]:44086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eihZn-0007nu-Mm
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:16:55 -0500
Received: by mail-pl0-x233.google.com with SMTP id f8so11858361plk.11
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 06:16:55 -0800 (PST)
References: <1517811767-75958-1-git-send-email-mjc@sifive.com>
	<1517811767-75958-8-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7f35516-c1b0-b322-804a-4ac3e919b0d1@linaro.org>
Date: Mon, 5 Feb 2018 06:16:52 -0800
MIME-Version: 1.0
In-Reply-To: <1517811767-75958-8-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/22] RISC-V TCG Code Generation
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

On 02/04/2018 10:22 PM, Michael Clark wrote:
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
>  target/riscv/instmap.h   |  366 +++++++++
>  target/riscv/translate.c | 1964 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 2330 insertions(+)
>  create mode 100644 target/riscv/instmap.h
>  create mode 100644 target/riscv/translate.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
