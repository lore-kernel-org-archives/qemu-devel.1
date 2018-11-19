Received: from eggs.gnu.org ([2001:4830:134:3::10]:57698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOo0y-0005RG-CC
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOo0x-0001Wg-CV
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:11:16 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:35044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOo0x-0001WF-6K
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 13:11:15 -0500
Received: by mail-ot1-x331.google.com with SMTP id 81so28534301otj.2
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 10:11:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 18:10:53 +0000
Message-ID: <CAFEAcA_Nr10Oxx-AtgZALUAnVOcuXUbarbWuWD3H6ahf=mJ8ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 19 November 2018 at 15:57, Peter Maydell <peter.maydell@linaro.org> wrote:
> Some Arm bugfixes for rc2...
>
> thanks
> -- PMM
>
> The following changes since commit e6ebbd46b6e539f3613136111977721d212c2812:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-11-19 14:31:48 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20181119
>
> for you to fetch changes up to a00d7f2048c2a1a6a4487ac195c804c78adcf60e:
>
>   MAINTAINERS: list myself as maintainer for various Arm boards (2018-11-19 15:55:11 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * various MAINTAINERS file updates
>  * hw/block/onenand: use qemu_log_mask() for reporting
>  * hw/block/onenand: Fix off-by-one error allowing out-of-bounds read
>    on the n800 and n810 machine models
>  * target/arm: fix smc incorrectly trapping to EL3 when secure is off
>  * hw/arm/stm32f205: Fix the UART and Timer region size
>  * target/arm: read ID registers for KVM guests so they can be
>    used to gate "is feature X present" checks
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
