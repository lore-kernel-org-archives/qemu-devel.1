Received: from eggs.gnu.org ([2001:4830:134:3::10]:52565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHU8U-0003ns-3S
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHU8T-0004rg-3C
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHU8S-0004mZ-Rn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:32:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id o14so11069755oth.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:32:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030132343.22658-1-peter.maydell@linaro.org>
References: <20181030132343.22658-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 13:32:20 +0000
Message-ID: <CAFEAcA9x7E_krWUxj7d7kOm5RE0vkarnDdcs9HXH0THz0Tu7NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/6] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2018 at 13:23, Peter Maydell <peter.maydell@linaro.org> wrote:
> Respin to fix some accidental wrong Author lines, no content
> changes.
>
> -- PMM
>
> The following changes since commit 0bbba1665ca2e7f1c80d4797077fe57bad58898e:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-october-2018-part-4' into staging (2018-10-30 10:45:49 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181030
>
> for you to fetch changes up to 1f5a65a188210509bfb0c025fc91635c8436b98a:
>
>   tests/boot-serial-test: Add microbit board testcase (2018-10-30 13:20:18 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * microbit: Add the UART to our nRF51 SoC model
>  * Add a virtual Xilinx Versal board "xlnx-versal-virt"
>  * hw/arm/virt: Set VIRT_COMPAT_3_0 compat
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (2):
>       hw/arm: versal: Add a model of Xilinx Versal SoC
>       hw/arm: versal: Add a virtual Xilinx Versal board
>
> Eric Auger (1):
>       hw/arm/virt: Set VIRT_COMPAT_3_0 compat
>
> Julia Suvorova (3):
>       hw/char: Implement nRF51 SoC UART
>       hw/arm/nrf51_soc: Connect UART to nRF51 SoC
>       tests/boot-serial-test: Add microbit board testcase

Bah, and now I find a compile failure in the versal board patches.

v3 coming up at some point.

thanks
-- PMM
