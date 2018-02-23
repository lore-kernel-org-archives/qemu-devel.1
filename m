Received: from eggs.gnu.org ([2001:4830:134:3::10]:35427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epAE6-0001c0-AL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epAE5-0000gd-0T
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:05:14 -0500
Received: from mail-pl0-x231.google.com ([2607:f8b0:400e:c01::231]:45135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epAE4-0000fg-Pu
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:05:12 -0500
Received: by mail-pl0-x231.google.com with SMTP id v9-v6so2636920plp.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 02:05:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 10:04:51 +0000
Message-ID: <CAFEAcA9kHfD_o+5k+_id4dPMbm+nTdN74AUOkWYBw+MH2XwY2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/32] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 22 February 2018 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
> Latest run of arm patches -- most of these are Philippe's SD card
> cleanups. I have more in my queue to review, but 32 is enough
> patches to warrant sending out.
>
> thanks
> -- PMM
>
> The following changes since commit ff8689611a1d954897d857b28f7ef404e11cfa2c:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-signed' into staging (2018-02-22 11:37:05 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180222
>
> for you to fetch changes up to 4e5cc6756586e967993187657dfcdde4e00288d9:
>
>   sdcard: simplify SD_SEND_OP_COND (ACMD41) (2018-02-22 15:12:54 +0000)
>
> ----------------------------------------------------------------
>  * New "raspi3" machine emulating RaspberryPi 3
>  * Fix bad register definitions for VMIDR and VMPIDR (which caused
>    assertions for 64-bit guest CPUs with EL2 on big-endian hosts)
>  * hw/char/stm32f2xx_usart: fix TXE/TC bit handling
>  * Fix ast2500 protection register emulation
>  * Lots of SD card emulation cleanups and bugfixes
>

Applied, thanks.

-- PMM
