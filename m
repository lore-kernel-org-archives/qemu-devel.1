Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emPPR-0001o2-6w
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emPPQ-00078H-7m
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:41:33 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emPPQ-00077B-2x
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:41:32 -0500
Received: by mail-oi0-x241.google.com with SMTP id r144so663813oie.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 11:41:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180215183700.26101-1-peter.maydell@linaro.org>
References: <20180215183700.26101-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 19:41:10 +0000
Message-ID: <CAFEAcA_EP6TwDJY4N5zeyFwAN8wk+AmY8rqWSAyhjkHwJh8G5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 15 February 2018 at 18:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> Changes v1->v2: it turns out that the raspi3 support exposes a
> preexisting bug in our register definitions for VMPIDR/VMIDR:
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04181.html
>
> So I've dropped the final "enable raspi3 board" patch for the
> moment. When that VMIDR/VMPIDR patch gets reviewed we can
> put the raspi3 patch in with it.
>
>
> thanks
> -- PMM
>
> The following changes since commit f003d07337a6d4d02c43429b26a4270459afb51a:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2018-02-15 15:45:33 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180215-1
>
> for you to fetch changes up to bade58166f4466546600d824a2695a00269d10eb:
>
>   raspi: Raspberry Pi 3 support (2018-02-15 18:33:46 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * aspeed: code cleanup to use unimplemented_device
>  * preparatory work for 'raspi3' RaspberryPi 3 machine model
>  * more SVE prep work
>  * v8M: add minor missing registers
>  * v7M: fix bug where we weren't migrating v7m.other_sp
>  * v7M: fix bugs in handling of interrupt registers for
>    external interrupts beyond 32
>

Applied this version, thanks.

-- PMM
