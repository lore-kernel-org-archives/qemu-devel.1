Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhdOM-0005IA-Pz
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhdOL-0005sU-Nc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:08:58 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:47012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhdOL-0005sB-HJ
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:08:57 -0400
Received: by mail-oi0-x243.google.com with SMTP id y207-v6so2064169oie.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:08:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723144152.13885-1-peter.maydell@linaro.org>
References: <20180723144152.13885-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 17:08:36 +0100
Message-ID: <CAFEAcA_v=pdZwVCjSk+u39Fp2cZBdx3AJvhf-QjwcDe=iiQizQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 23 July 2018 at 15:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue for 3.0:
>
> Thomas' fixes for instrospection issues with a handful of
> devices (including one microblaze one that I include in this
> pullreq for convenience's sake), plus my bugfix for a
> corner case of small MPU region support.
>
> thanks
> -- PMM
>
> The following changes since commit 55b1f14cefcb19ce6d5e28c4c83404230888aa7e:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-07-23 14:03:14 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180723
>
> for you to fetch changes up to 1ddc9b98c3cb89fe23a55ba924000fd645253e87:
>
>   hw/intc/exynos4210_gic: Turn instance_init into realize function (2018-07-23 15:21:27 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * spitz, exynos: fix bugs when introspecting some devices
>  * hw/microblaze/xlnx-zynqmp-pmu: Fix introspection problem in 'xlnx, zynqmp-pmu-soc'
>  * target/arm: Correctly handle overlapping small MPU regions
>  * hw/sd/bcm2835_sdhost: Fix PIO mode writes
>

Applied, thanks.

-- PMM
