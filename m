Received: from eggs.gnu.org ([209.51.188.92]:43013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gubN6-0005FM-MK
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gubMr-0005oU-C6
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:09:23 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:44735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gubMq-0005lD-PT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:09:17 -0500
Received: by mail-ot1-x32a.google.com with SMTP id g1so15813949otj.11
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 03:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20190215101948.13893-1-peter.maydell@linaro.org>
In-Reply-To: <20190215101948.13893-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 11:09:03 +0000
Message-ID: <CAFEAcA-sibPqKRq3PdPCU=rK15=6r9BgVM6AvBtd9GToVAytkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 15 Feb 2019 at 10:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: drop a couple of RTH's patches that he wants to rework.
>
> The following changes since commit 0266c739abbed804deabb4ccde2aa449466ac3b4:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-feb-14-2019' into staging (2019-02-14 18:33:00 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190215
>
> for you to fetch changes up to 0f8b09b22234460cb5b8766a25066cf6b5f06842:
>
>   gdbstub: Send a reply to the vKill packet. (2019-02-15 09:56:41 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * gdbstub: Send a reply to the vKill packet
>  * Improve codegen for neon min/max and saturating arithmetic
>  * Fix a bug in clearing FPSCR exception status bits
>  * hw/arm/armsse: Fix miswiring of expansion IRQs
>  * hw/intc/armv7m_nvic: Allow byte accesses to SHPR1
>  * MAINTAINERS: Remove Peter Crosthwaite from various entries
>  * arm: Allow system registers for KVM guests to be changed by QEMU code
>  * linux-user: support HWCAP_CPUID which exposes ID registers to user code
>  * Fix bug in 128-bit cmpxchg for BE Arm guests
>  * Implement (no-op) HACR_EL2
>  * Fix CRn to be 14 for PMEVTYPER/PMEVCNTR
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
