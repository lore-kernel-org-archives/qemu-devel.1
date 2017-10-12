Received: from eggs.gnu.org ([2001:4830:134:3::10]:51084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2l1W-0005AA-B1
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2l1T-0001y5-56
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:10 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:56063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2l1S-0001wr-Uk
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:28:07 -0400
Received: by mail-pf0-x231.google.com with SMTP id 17so6705278pfn.12
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 14:28:06 -0700 (PDT)
References: <cover.1503467674.git.shorne@gmail.com>
	<b12db1e3daefa777fe0025c71ac30a816a126653.1503467674.git.shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54bd0b51-0e47-c8b8-b423-ff9d599b1d61@linaro.org>
Date: Thu, 12 Oct 2017 14:28:03 -0700
MIME-Version: 1.0
In-Reply-To: <b12db1e3daefa777fe0025c71ac30a816a126653.1503467674.git.shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] openrisc: Initial SMP support
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
> Wire in ompic and add basic support for SMP.  The OpenRISC is special in
> that interrupts for devices are routed to each core's PIC.  This is
> achieved using the qemu_irq_split utility, but this currently limits
> OpenRISC to 2 cores.
> 
> This models the reference architecture described in the OpenRISC spec
> 1.2 proposal.
> 
>   https://github.com/stffrdhrn/doc/raw/arch-1.2-proposal/openrisc-arch-1.2-rev0.pdf
> 
> The changes to the intialization of the sim include:
> 
> CPU Reset
>  o Reset each cpu to the bootstrap PC rather than only a single cpu as
>    done before.
>  o During Kernel loading the bootstrap PC is saved in a static global.
> 
> Network Initialization
>  o Connect the interrupt to each CPU
>  o Use more simple sysbus_mmio_map() rather than memory_region_add_subregion()
> 
> Sim Initialization
>  o Initialize the pic and tick timer per cpu
>  o Wire in the OMPIC if SMP is enabled
>  o Wire the serial irq to each CPU using qemu_irq_split()
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  hw/openrisc/openrisc_sim.c | 84 +++++++++++++++++++++++++++++++++-------------
>  1 file changed, 61 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
