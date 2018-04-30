Received: from eggs.gnu.org ([2001:4830:134:3::10]:48500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDBTz-0006So-LQ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDBTy-0003F9-S3
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:16:55 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDBTy-0003EO-M3
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 12:16:54 -0400
Received: by mail-ot0-x242.google.com with SMTP id 77-v6so10071388otd.4
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 09:16:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430150837.20470-1-edgar.iglesias@gmail.com>
References: <20180430150837.20470-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 17:16:33 +0100
Message-ID: <CAFEAcA8vGJZ5fBcB4C4=kmu6GB2XPkr0=rNGg=h2KkVfYfv0FA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/5] Xilinx queue 2018-04-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Francisco Iglesias <frasse.iglesias@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 30 April 2018 at 16:08, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit 6f0c4706b35dead265509115ddbd2a8d1af516c1:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180427-pull-request' into staging (2018-04-27 12:27:59 +0100)
>
> are available in the git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-04-30.for-upstream
>
> for you to fetch changes up to fce6a8eceb07e27f0cdea87427f4e560dfa0b1c8:
>
>   target-microblaze: mmu: Make the TLBX MISS bit read-only (2018-04-30 16:43:20 +0200)
>
> ----------------------------------------------------------------
> edgar/xilinx-next-2018-01.for-upstream
>
> ----------------------------------------------------------------
> Edgar E. Iglesias (5):
>       target-microblaze: Respect MSR.PVR as read-only
>       target-microblaze: Fix trap checks for FPU insns
>       target-microblaze: Don't clobber the IMM reg for ld/st reversed
>       target-microblaze: mmu: Make TLBSX write-only
>       target-microblaze: mmu: Make the TLBX MISS bit read-only
>
>  target/microblaze/mmu.c       | 9 ++++++++-
>  target/microblaze/translate.c | 6 ++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> Edgar E. Iglesias (5):
>   target-microblaze: Respect MSR.PVR as read-only
>   target-microblaze: Fix trap checks for FPU insns
>   target-microblaze: Don't clobber the IMM reg for ld/st reversed
>   target-microblaze: mmu: Make TLBSX write-only
>   target-microblaze: mmu: Make the TLBX MISS bit read-only
>
>  target/microblaze/mmu.c       | 9 ++++++++-
>  target/microblaze/translate.c | 6 ++----
>  2 files changed, 10 insertions(+), 5 deletions(-)

Applied, thanks.

-- PMM
