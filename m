Received: from eggs.gnu.org ([2001:4830:134:3::10]:40722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kPT-0006iy-C0
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kPO-000660-I6
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:51 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:51144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2kPO-00065k-Bm
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 16:48:46 -0400
Received: by mail-pf0-x236.google.com with SMTP id m63so6581158pfk.7
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:48:46 -0700 (PDT)
References: <cover.1503467674.git.shorne@gmail.com>
	<ededad1a3abe4ca8dc25fc6eb368fe15a4ccfe12.1503467674.git.shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aedb9d6c-6123-9628-0630-21810a1e3f2e@linaro.org>
Date: Thu, 12 Oct 2017 13:48:42 -0700
MIME-Version: 1.0
In-Reply-To: <ededad1a3abe4ca8dc25fc6eb368fe15a4ccfe12.1503467674.git.shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] openrisc/ompic: Add OpenRISC Multicore
 PIC (OMPIC)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Openrisc <openrisc@lists.librecores.org>, Richard Henderson <rth@twiddle.net>

On 08/22/2017 10:57 PM, Stafford Horne wrote:
> Add OpenRISC Multicore PIC which handles inter processor interrupts
> (IPI) between cores.  In OpenRISC all device interrupts are routed to
> each core enabling this device to be simple.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  default-configs/or1k-softmmu.mak |   1 +
>  hw/intc/Makefile.objs            |   1 +
>  hw/intc/ompic.c                  | 179 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 hw/intc/ompic.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
