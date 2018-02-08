Received: from eggs.gnu.org ([2001:4830:134:3::10]:39373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnNI-0005dp-Cw
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejnNC-0001fi-UE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:40:32 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:32840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejnNC-0001fO-LV
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:40:26 -0500
Received: by mail-pg0-x244.google.com with SMTP id u1so1676000pgr.0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:40:26 -0800 (PST)
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
	<1518053328-34687-11-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <14a6a58c-6c0c-10de-888e-fcf528bf0728@linaro.org>
Date: Thu, 8 Feb 2018 06:40:22 -0800
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-11-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/23] RISC-V Physical Memory Protection
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

On 02/07/2018 05:28 PM, Michael Clark wrote:
> Implements the physical memory protection extension as specified in
> Privileged ISA Version 1.10.
> 
> PMP (Physical Memory Protection) is as-of-yet unused and needs testing.
> The SiFive verification team have PMP test cases that will be run.
> 
> Nothing currently depends on PMP support. It would be preferable to keep
> the code in-tree for folk that are interested in RISC-V PMP support.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/pmp.c | 386 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/riscv/pmp.h |  70 ++++++++++
>  2 files changed, 456 insertions(+)
>  create mode 100644 target/riscv/pmp.c
>  create mode 100644 target/riscv/pmp.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
