Received: from eggs.gnu.org ([209.51.188.92]:35523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6Wv-0001hs-HT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr6Wu-0003cK-Kz
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:37:13 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:33715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr6Wu-0003bU-Dr
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:37:12 -0500
Received: by mail-ot1-x32f.google.com with SMTP id i20so7877306otl.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:37:12 -0800 (PST)
MIME-Version: 1.0
References: <20190205170510.21984-1-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 19:36:59 +0000
Message-ID: <CAFEAcA82xHJ0oM8fYRf77VgVpY3uwCQiWOcDV8L7ZJPNjkRZRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Feb 2019 at 17:05, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Arm stuff, mostly patches from RTH.
>
> thanks
> -- PMM
>
> The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e159d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-request' into staging (2019-02-05 14:01:29 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190205
>
> for you to fetch changes up to a15945d98d3a3390c3da344d1b47218e91e49d8b:
>
>   target/arm: Make FPSCR/FPCR trapped-exception bits RAZ/WI (2019-02-05 16:52:42 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Implement Armv8.5-BTI extension for system emulation mode
>  * Implement the PR_PAC_RESET_KEYS prctl() for linux-user mode's Armv8.3-PAuth support
>  * Support TBI (top-byte-ignore) properly for linux-user mode
>  * gdbstub: allow killing QEMU via vKill command
>  * hw/arm/boot: Support DTB autoload for firmware-only boots
>  * target/arm: Make FPSCR/FPCR trapped-exception bits RAZ/WI
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
