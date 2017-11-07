Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC4vz-0001HX-Ha
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC4vv-0000IE-K2
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:32:59 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC4vv-0000I3-Dj
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:32:55 -0500
Received: by mail-wr0-x22f.google.com with SMTP id y9so12031625wrb.2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 06:32:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
References: <1510061722-14092-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 14:32:33 +0000
Message-ID: <CAFEAcA94JR8M+grizndroTnei2L66+GUtOWsUkAdjPVcz91CuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 7 November 2017 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> A small set of arm bugfixes for rc0.
>
>
>
> The following changes since commit 5853e92207193e967abf5e4c25b4a551c7604725:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20171107' into staging (2017-11-07 12:19:48 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171107
>
> for you to fetch changes up to 8a7348b5d62d7ea16807e6bea54b448a0184bb0f:
>
>   hw/intc/arm_gicv3_its: Don't abort on table save failure (2017-11-07 13:03:52 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * arm_gicv3_its: Don't abort on table save failure
>  * arm_gicv3_its: Fix the VM termination in vm_change_state_handler()
>  * translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD
>  * hw/arm: Mark the "fsl,imx31/25/6" devices with user_creatable = false
>  * arm: implement cache/shareability attribute bits for PAR registers
>
> ----------------------------------------------------------------
> Andrew Baumann (1):
>       arm: implement cache/shareability attribute bits for PAR registers
>
> Eric Auger (1):
>       hw/intc/arm_gicv3_its: Don't abort on table save failure
>
> Peter Maydell (1):
>       translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD
>
> Shanker Donthineni (1):
>       hw/intc/arm_gicv3_its: Fix the VM termination in vm_change_state_handler()
>
> Thomas Huth (3):
>       hw/arm: Mark the "fsl,imx6" device with user_creatable = false
>       hw/arm: Mark the "fsl,imx25" device with user_creatable = false
>       hw/arm: Mark the "fsl,imx31" device with user_creatable = false

Applied, thanks.

-- PMM
