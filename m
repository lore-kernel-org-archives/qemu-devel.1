Received: from eggs.gnu.org ([2001:4830:134:3::10]:41646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cikBz-0007VK-6c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cikBy-0004m0-Jq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:59:59 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cikBy-0004lh-DW
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:59:58 -0500
Received: by mail-wm0-x230.google.com with SMTP id u199so15438384wmd.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 07:59:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488285698-21781-1-git-send-email-peter.maydell@linaro.org>
References: <1488285698-21781-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 15:59:36 +0000
Message-ID: <CAFEAcA-+v+t-Bjj7d0hbTDO-KmyA5nvKvpDJOpuOE4ZDYWpYhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/27] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2017 at 12:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> v1->v2 changes: drop the sd card-reparenting patch
> and the 2 raspi2 patches that depend on it.
>
> -- PMM
>
> The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170228
>
> for you to fetch changes up to f3a6339a5bbc160d327299c67bb68c6d07fa4a61:
>
>   hw/arm/exynos: Fix proper mapping of CPUs by providing real cluster ID (2017-02-28 12:08:20 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * raspi2: implement RNG module
>  * raspi2: implement new SD card controller (but don't wire it up)
>  * sdhci: bugfixes for block transfers
>  * virt: fix cpu object reference leak
>  * Add missing fp_access_check() to aarch64 crypto instructions
>  * cputlb: Don't assume do_unassigned_access() never returns
>  * virt: Add a user option to disallow ITS instantiation
>  * i.MX timers: fix reset handling
>  * ARMv7M NVIC: rewrite to fix broken priority handling and masking
>  * exynos: Fix proper mapping of CPUs by providing real cluster ID
>  * exynos: Fix Linux kernel division by zero for PLLs
>

Applied, thanks.

-- PMM
