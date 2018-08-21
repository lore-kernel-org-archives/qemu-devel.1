Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fs9yJ-0004zx-6e
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fs9yB-0005jH-60
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 12:57:32 -0400
Date: Tue, 21 Aug 2018 18:57:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180821165712.22orutfo4ucemca3@toto>
References: <20180820153020.21478-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target/arm: Some pieces of support
 for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Luc Michel <luc.michel@greensocs.com>

On Mon, Aug 20, 2018 at 04:30:14PM +0100, Peter Maydell wrote:
> Now we have virtualization support in the GICv2 emulation,
> I thought I'd have a look at how much we were still missing
> for being able to enable EL2 support for AArch32.
> This set of patches fixes some minor missing pieces:
>  * AArch32 HACTLR2
>  * AArch32 HCR, HCR2
>  * support for taking exceptions to Hyp mode
>  * boot AArch32 kernels in Hyp mode where available
> and I threw in a trivial bugfix:
>  * Clear CPSR.IL and CPSR.J on 32-bit exception entry
> since it would otherwise have a conflict with the refactoring
> of exception entry.
> 
> Changes v1->v2:
>  * some patches are now upstream
>  * v8-only registers no longer created for v7 CPUs
>  * split the "factor out exception-entry code" into
>    its own patch
>  * new patch: clear CPSR.IL and CPSR.J
>  * new patch: boot kernels in Hyp mode if possible
> 
> (I still have the same "guest EL0 segv" issue as for v1
> if I actually enable the EL2 feature on Cortex-A15.)


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> thanks
> -- PMM
> 
> Peter Maydell (6):
>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Factor out code for taking an AArch32 exception
>   target/arm: Implement support for taking exceptions to Hyp mode
>   target/arm: Clear CPSR.IL and CPSR.J on 32-bit exception entry
>   hw/arm/boot: AArch32 kernels should be started in Hyp mode if
>     available
> 
>  hw/arm/boot.c       |  11 +++
>  target/arm/helper.c | 212 ++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 196 insertions(+), 27 deletions(-)
> 
> -- 
> 2.18.0
> 
