Received: from eggs.gnu.org ([209.51.188.92]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1Xk-0001KR-E0
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1Xi-0002Eo-FN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:40:40 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj1Xi-00029Q-88
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:40:38 -0500
Received: by mail-ot1-x343.google.com with SMTP id k98so19139926otk.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20190111180630.6433-1-palmer@sifive.com>
In-Reply-To: <20190111180630.6433-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 12:40:06 +0000
Message-ID: <CAFEAcA-yeQSbbhKXXJ0f961MJKC-v46DWgoaXcQUt64DZcdzqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] RISC-V Updates for 3.2, Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: qemu-riscv@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 11 Jan 2019 at 18:06, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-request' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-3.2-part2
>
> for you to fetch changes up to f7cdfa38f37e0985457ac03c3238861144a58b4c:
>
>   default-configs: Enable USB support for RISC-V machines (2019-01-09 17:34:10 -0800)
>
> ----------------------------------------------------------------
> RISC-V Updates for 3.2, Part 2
>
> This patch set contains a handful of Michael's CSR-related cleanups,
> which should allow us to proceed with more outstanding bug fixes that
> depend on them.
>
> Additionally, there is a patch that turns on USB.  This works for me
> when the kernel has the appropriate drivers (which will soon be in
> defconfig) and I pass
>
>     -device usb-ehci
>     -drive id=my_usb_disk,file=usbdisk.img,if=none,format=raw
>     -device usb-storage,drive=my_usb_disk
>
> to QEMU.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
