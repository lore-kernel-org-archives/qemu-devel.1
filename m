Received: from eggs.gnu.org ([2001:4830:134:3::10]:54586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKpi-0001Qd-12
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKpd-0000ae-Gq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:24:46 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:46395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKpd-0000Zj-9s
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:24:41 -0500
Received: by mail-pf0-x241.google.com with SMTP id z24so4018386pfh.13
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:24:41 -0800 (PST)
References: <1519344729-73482-1-git-send-email-mjc@sifive.com>
	<1519344729-73482-13-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2343d5ed-2531-b13a-3dd2-3f943cfaf0b5@linaro.org>
Date: Fri, 23 Feb 2018 13:24:37 -0800
MIME-Version: 1.0
In-Reply-To: <1519344729-73482-13-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 12/23] RISC-V HTIF Console
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

On 02/22/2018 04:11 PM, Michael Clark wrote:
> HTIF (Host Target Interface) provides console emulation for QEMU. HTIF
> allows identical copies of BBL (Berkeley Boot Loader) and linux to run
> on both Spike and QEMU. BBL provides HTIF console access via the
> SBI (Supervisor Binary Interface) and the linux kernel SBI console.
> 
> The HTIT chardev implements the pre qom legacy interface consistent
> with the 16550a UART in 'hw/char/serial.c'.
> 
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  hw/riscv/riscv_htif.c         | 263 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/riscv_htif.h |  64 ++++++++++
>  2 files changed, 327 insertions(+)
>  create mode 100644 hw/riscv/riscv_htif.c
>  create mode 100644 include/hw/riscv/riscv_htif.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
