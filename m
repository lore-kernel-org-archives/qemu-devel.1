Received: from eggs.gnu.org ([2001:4830:134:3::10]:58495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdvt-0002AU-I0
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdvp-0003xx-KB
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:17 -0500
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:38934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZdvp-0003we-Dw
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:34:13 -0500
Received: by mail-pf0-x22e.google.com with SMTP id e11so1769793pff.6
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 06:34:13 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-5-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03b3105c-e095-960e-6f08-6a018e2fc172@linaro.org>
Date: Thu, 11 Jan 2018 06:34:09 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-5-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/21] RISC-V Disassembler
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
> The RISC-V disassembler has no dependencies outside of the 'disas'
> directory so it can be applied independently. The majority of the
> disassembler is machine-generated from instruction set metadata:
> 
> - https://github.com/michaeljclark/riscv-meta
> 
> Expected checkpatch errors for consistency and brevity reasons:
> 
> ERROR: line over 90 characters
> ERROR: trailing statements should be on next line
> ERROR: space prohibited between function name and open parenthesis '('
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  disas.c             |    2 +
>  disas/Makefile.objs |    1 +
>  disas/riscv.c       | 3054 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/disas/bfd.h |    2 +
>  4 files changed, 3059 insertions(+)
>  create mode 100644 disas/riscv.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
