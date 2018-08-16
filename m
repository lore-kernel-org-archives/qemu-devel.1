Received: from eggs.gnu.org ([2001:4830:134:3::10]:53409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKyh-0007g3-Ac
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:18:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqKyg-0004RG-I9
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:18:27 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqKyg-0004R3-DC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:18:26 -0400
Received: by mail-oi0-x242.google.com with SMTP id 8-v6so9051638oip.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:18:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:18:05 +0100
Message-ID: <CAFEAcA8OiSNqnuwPqudexNunsBQrxKFiaqG9AkTpptZirY5ArQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/30] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 16 August 2018 at 14:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> Less than a day of post-3.0 code review and already enough
> patches for another pullreq :-)
>
> thanks
> -- PMM
>
> The following changes since commit c542a9f9794ec8e0bc3fcf5956d3cc8bce667789:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-tests-2018-08-16' into staging (2018-08-16 09:50:54 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180816
>
> for you to fetch changes up to fcf13ca556f462b52956059bf8fa622bc8575edb:
>
>   hw/arm/mps2-tz: Replace init_sysbus_child() with sysbus_init_child_obj() (2018-08-16 14:29:58 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fixes for various bugs in SVE instructions
>  * Add model of Freescale i.MX6 UltraLite 14x14 EVK Board
>  * hw/arm: make bitbanded IO optional on ARMv7-M
>  * Add model of Cortex-M0 CPU
>  * Add support for loading Intel HEX files to the generic loader
>  * imx_spi: Unset XCH when TX FIFO becomes empty
>  * aspeed_sdmc: fix various bugs
>  * Fix bugs in Arm FP16 instruction support
>  * Fix aa64 FCADD and FCMLA decode
>  * softfloat: Fix missing inexact for floating-point add
>  * hw/arm/mps2-tz: Replace init_sysbus_child() with sysbus_init_child_obj()
>

Applied, thanks.

-- PMM
