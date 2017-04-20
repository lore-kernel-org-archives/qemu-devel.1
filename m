Received: from eggs.gnu.org ([2001:4830:134:3::10]:59076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1FvJ-0006FE-Qh
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 13:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1FvI-00049s-T3
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 13:31:17 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1FvI-00049c-MA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 13:31:16 -0400
Received: by mail-wm0-x22e.google.com with SMTP id m123so43786122wma.0
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 10:31:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 18:30:54 +0100
Message-ID: <CAFEAcA_QnBuv5qR=BR0f=SY6CCcT-Bo_=EmFCDMLivyhYPqW_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 20 April 2017 at 17:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> First ARM pullreq of the 2.10 cycle...
>
> thanks
> -- PMM
>
> The following changes since commit 64c8ed97cceabac4fafe17fca8d88ef08183f439:
>
>   Open 2.10 development tree (2017-04-20 15:42:31 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170420
>
> for you to fetch changes up to f4e8e4edda875cab9df91dc4ae9767f7cb1f50aa:
>
>   arm: Remove workarounds for old M-profile exception return implementation (2017-04-20 17:39:17 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * implement M profile exception return properly
>  * cadence GEM: fix multiqueue handling bugs
>  * pxa2xx.c: QOMify a device
>  * arm/kvm: Remove trailing newlines from error_report()
>  * stellaris: Don't hw_error() on bad register accesses
>  * Add assertion about FSC format for syndrome registers
>  * Move excnames[] array into arm_log_exceptions()
>  * exynos: minor code cleanups
>  * hw/arm/boot: take Linux/arm64 TEXT_OFFSET header field into account
>  * Fix APSR writes via M profile MSR
>
> ----------------------------------------------------------------
> Alistair Francis (5):
>       cadence_gem: Read the correct queue descriptor
>       cadence_gem: Correct the multi-queue can rx logic
>       cadence_gem: Correct the interupt logic
>       cadence_gem: Make the revision a property
>       xlnx-zynqmp: Set the Cadence GEM revision
>
> Ard Biesheuvel (1):
>       hw/arm/boot: take Linux/arm64 TEXT_OFFSET header field into account
>
> Ishani Chugh (1):
>       arm/kvm: Remove trailing newlines from error_report()
>
> Krzysztof Kozlowski (3):
>       hw/arm/exynos: Convert fprintf to qemu_log_mask/error_report
>       hw/char/exynos4210_uart: Constify static array and few arguments
>       hw/misc/exynos4210_pmu: Reorder local variables for readability
>
> Peter Maydell (13):
>       target/arm: Add missing entries to excnames[] for log strings
>       arm: Move excnames[] array into arm_log_exceptions()
>       target/arm: Add assertion about FSC format for syndrome registers
>       stellaris: Don't hw_error() on bad register accesses
>       arm: Don't implement BXJ on M-profile CPUs
>       arm: Thumb shift operations should not permit interworking branches
>       arm: Factor out "generate right kind of step exception"
>       arm: Move gen_set_condexec() and gen_set_pc_im() up in the file
>       arm: Move condition-failed codepath generation out of if()
>       arm: Abstract out "are we singlestepping" test to utility function
>       arm: Track M profile handler mode state in TB flags
>       arm: Implement M profile exception return properly
>       arm: Remove workarounds for old M-profile exception return implementation
>
> Suramya Shah (1):
>       hw/arm: Qomify pxa2xx.c
>

Applied, thanks.

-- PMM
