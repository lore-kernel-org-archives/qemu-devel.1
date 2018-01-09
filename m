Received: from eggs.gnu.org ([2001:4830:134:3::10]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYupY-0001yX-LJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYupX-0008Tx-IY
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:44 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYupX-0008Tm-DK
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:24:43 -0500
Received: by mail-ot0-x242.google.com with SMTP id x15so11456627ote.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:24:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:24:22 +0000
Message-ID: <CAFEAcA8NbL7ROZs99hWhpAF2Rdi2qEiWLNo3hr_9W7gmgXyw4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>, "patches@linaro.org" <patches@linaro.org>

Ping for code review?

thanks
-- PMM

On 13 December 2017 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> The GICv2 and GICv3 specifications say that reserved register
> addresses should RAZ/WI.  This means we need to return MEMTX_OK, not
> MEMTX_ERROR, because now that we support generating external aborts
> the latter will cause an abort on new board models.
>
> In particular, at least some versions of UEFI try to
> access a reserved address in the GICv3 redistributor
> (at SGI_base + 0x184) and fail to boot on the virt board
> without this.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   hw/intc/arm_gicv3: Make reserved register addresses RAZ/WI
>   hw/intc/arm_gic: reserved register addresses are RAZ/WI
>
>  hw/intc/arm_gic.c              |  5 +++--
>  hw/intc/arm_gicv3_dist.c       | 13 +++++++++++++
>  hw/intc/arm_gicv3_its_common.c |  8 +++-----
>  hw/intc/arm_gicv3_redist.c     | 13 +++++++++++++
>  4 files changed, 32 insertions(+), 7 deletions(-)
