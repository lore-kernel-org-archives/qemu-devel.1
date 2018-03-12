Received: from eggs.gnu.org ([2001:4830:134:3::10]:50539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNOy-0007Nl-Bb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNOs-0003xm-OA
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:22:08 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNOs-0003wp-Hs
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:22:02 -0400
Received: by mail-ot0-x243.google.com with SMTP id r30so15233517otr.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:22:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309172622.4277-1-peter.maydell@linaro.org>
References: <20180309172622.4277-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:21:41 +0000
Message-ID: <CAFEAcA9Lwnoytzzr2kKpBE-XQCJ0HweC0Q6OjDtWddjvWZ3dxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 17:25, Peter Maydell <peter.maydell@linaro.org> wrote:
> Arm pullreq for the 2.12 codefreeze...
>
> thanks
> -- PMM
>
> The following changes since commit b39b61e410022f96ceb53d4381d25cba5126ac44:
>
>   memory: fix flatview_access_valid RCU read lock/unlock imbalance (2018-03-09 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180309
>
> for you to fetch changes up to 076a0fc32a73a9b960e0f73f04a531bc1bd94308:
>
>   MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard) (2018-03-09 17:09:45 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * i.MX: Add i.MX7 SOC implementation and i.MX7 Sabre board
>  * Report the correct core count in A53 L2CTLR on the ZynqMP board
>  * linux-user: preliminary SVE support work (signal handling)
>  * hw/arm/boot: fix memory leak in case of error loading ELF file
>  * hw/arm/boot: avoid reading off end of buffer if passed very
>    small image file
>  * hw/arm: Use more CONFIG switches for the object files
>  * target/arm: Add "-cpu max" support
>  * hw/arm/virt: Support -machine gic-version=max
>  * hw/sd: improve debug tracing
>  * hw/sd: sdcard: Add the Tuning Command (CMD 19)
>  * MAINTAINERS: add Philippe as odd-fixes maintainer for SD
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
