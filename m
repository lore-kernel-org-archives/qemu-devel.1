Received: from eggs.gnu.org ([2001:4830:134:3::10]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOlT9-0002WW-FZ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOlT8-0004x3-Lk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:28:11 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOlT6-0004w6-LZ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:28:08 -0500
Received: by mail-ot1-x341.google.com with SMTP id s5so27969225oth.7
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 07:28:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108134139.31666-1-peter.maydell@linaro.org>
References: <20181108134139.31666-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:27:45 +0000
Message-ID: <CAFEAcA9ndGv+UPuH3EQ6jHAxN8Oon-9suGOYxAp=L+VWJY+CvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: list myself as maintainer for
 various Arm boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Rob Herring <robh@kernel.org>, Thomas Huth <thuth@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Antony Pavlov <antonynpavlov@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 8 November 2018 at 13:41, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> In practice for most of the more-or-less orphan Arm board models,
> I will review patches and put them in via the target-arm tree.
> So list myself as an "Odd Fixes" status maintainer for them.
>
> This commit downgrades these boards to "Odd Fixes":
>  * Allwinner-A10
>  * Exynos
>  * Calxeda Highbank
>  * Canon DIGIC
>  * Musicpal
>  * nSeries
>  * Palm
>  * PXA2xx
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Applied to target-arm.next for 3.1, with Philippe moved to
"R:" status from "M:" for Gumstix, and the following improved
commit message:

    MAINTAINERS: list myself as maintainer for various Arm boards

    In practice for most of the more-or-less orphan Arm board models,
    I will review patches and put them in via the target-arm tree.
    So list myself as an "Odd Fixes" status maintainer for them.

    This commit downgrades these boards to "Odd Fixes":
     * Allwinner-A10
     * Exynos
     * Calxeda Highbank
     * Canon DIGIC
     * Musicpal
     * nSeries
     * Palm
     * PXA2xx

    These boards were already "Odd Fixes":
     * Gumstix
     * i.MX31 (kzm)

    Philippe Mathieu-Daud=C3=A9 has requested to be moved to R:
    status for Gumstix now that I am listed as the M: contact.

    Some boards are maintained, but their patches still go
    via the target-arm tree, so add myself as a secondary
    maintainer contact for those:
     * Xilinx Zynq
     * Xilinx ZynqMP
     * STM32F205
     * Netduino 2
     * SmartFusion2
     * Mecraft M2S-FG484
     * ASPEED BMCs
     * NRF51


(We can think about the "tag for who to cc to get patches
into a pull request" idea separately I think.)

thanks
-- PMM
