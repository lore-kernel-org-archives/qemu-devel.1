Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelv2-0004uF-Ct
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eelv1-0000GA-Dk
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:06:36 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:40872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eelv1-0000F1-7y
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:06:35 -0500
Received: by mail-ot0-x235.google.com with SMTP id x4so7474088otg.7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:06:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 18:06:13 +0000
Message-ID: <CAFEAcA8eq_o7YCi+X+qdfM_URH+5iZTAX8Bs1kFaG857HZj4qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2018 at 13:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm queue built up to a point where it seems worth sending:
> various bug fixes, plus RTH's refactoring in preparation for SVE.
>
> thanks
> -- PMM
>
>
> The following changes since commit 0f79bfe38a2cf0f43c7ea4959da7f8ebd7858f3d:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-01-25 09:53:53 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180125
>
> for you to fetch changes up to 24da047af0e99a83fcc0d50b86c0f2627f7418b3:
>
>   pl110: Implement vertical compare/next base interrupts (2018-01-25 11:45:30 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Fix address truncation in 64-bit pagetable walks
>  * i.MX: Fix FEC/ENET receive functions
>  * target/arm: preparatory refactoring for SVE emulation
>  * hw/intc/arm_gic: Prevent the GIC from signaling an IRQ when it's "active and pending"
>  * hw/intc/arm_gic: Fix C_RPR value on idle priority
>  * hw/intc/arm_gic: Fix group priority computation for group 1 IRQs
>  * hw/intc/arm_gic: Fix the NS view of C_BPR when C_CTRL.CBPR is 1
>  * hw/arm/virt: Check that the CPU realize method succeeded
>  * sdhci: fix a NULL pointer dereference due to uninitialized AddressSpace object
>  * xilinx_spips: Correct usage of an uninitialized local variable
>  * pl110: Implement vertical compare/next base interrupts
>

Applied, thanks.

-- PMM
