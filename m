Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRmGN-0006xs-Hm
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cRmGM-0000iz-Hk
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:46:23 -0500
Date: Thu, 12 Jan 2017 21:46:14 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170112204613.GZ9606@toto>
References: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] target/arm: Support EL1 AArch32 guest
 under AArch64 EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, Jan 10, 2017 at 06:44:06PM +0000, Peter Maydell wrote:
> The GICv3 virt patchset is sufficient to run a 64-bit guest under
> a 64-bit host kernel. To run 32-bit guests under the 64-bit host
> you need a few more things:
>  * data aborts from AArch32 need to provide instruction syndrome info
>    to the hypervisor
>  * the AArch32 interrupt code needs to handle VIRQ and VFIQ
>  * we need a DBGVCR32_EL2 register, because Linux's EL2 code uses
>    it to context-switch AArch32 DBGVCR between guests
> 
> This patchset sits on top of the gicv3-virt patchset and is
> sufficient to run a Linux 32-bit guest under 64-bit Linux host.

Cool stuff Peter, I didn't think we were this close for this to work!

32bit hypervisors would be cool too but I'm guessing there's quite a bit
of work before that works...

Cheers,
Edgar

> 
> Git branch with the whole lot:
>  https://git.linaro.org/people/peter.maydell/qemu-arm.git aarch32-guest
> 
> 
> Peter Maydell (3):
>   target/arm: A32, T32: Create Instruction Syndromes for Data Aborts
>   target/arm: Handle VIRQ and VFIQ in arm_cpu_do_interrupt_aarch32()
>   target/arm: Implement DBGVCR32_EL2 system register
> 
>  target/arm/helper.c    |  21 +++++
>  target/arm/translate.c | 213 ++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 178 insertions(+), 56 deletions(-)
> 
> -- 
> 2.7.4
> 
