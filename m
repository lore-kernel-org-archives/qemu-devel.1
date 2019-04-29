Received: from eggs.gnu.org ([209.51.188.92]:50572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAkA-00048c-CO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLAk9-0004bx-Bj
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:10 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:40610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLAk9-0004ak-5A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:11:09 -0400
Received: by mail-oi1-x22b.google.com with SMTP id y64so3544188oia.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 11:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190429170030.11323-1-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 19:10:56 +0100
Message-ID: <CAFEAcA_8mp6k+jQUjtcwKxKEFq3wcvqAFwiOpnLw8nRg+tQexQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 29 Apr 2019 at 18:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First pullreq for arm of the 4.1 series, since I'm back from
> holiday now. This is mostly my M-profile FPU series and Philippe's
> devices.h cleanup. I have a pile of other patchsets to work through
> in my to-review folder, but 42 patches is definitely quite
> big enough to send now...
>
> thanks
> -- PMM
>
> The following changes since commit 413a99a92c13ec408dcf2adaa87918dc81e890c8:
>
>   Add Nios II semihosting support. (2019-04-29 16:09:51 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190429
>
> for you to fetch changes up to 437cc27ddfded3bbab6afd5ac1761e0e195edba7:
>
>   hw/devices: Move SMSC 91C111 declaration into a new header (2019-04-29 17:57:21 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * remove "bag of random stuff" hw/devices.h header
>  * implement FPU for Cortex-M and enable it for Cortex-M4 and -M33
>  * hw/dma: Compile the bcm2835_dma device as common object
>  * configure: Remove --source-path option
>  * hw/ssi/xilinx_spips: Avoid variable length array
>  * hw/arm/smmuv3: Remove SMMUNotifierNode
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
