Received: from eggs.gnu.org ([2001:4830:134:3::10]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cigZ5-0005ZV-5l
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cigZ2-0005u3-Vp
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:07:35 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cigZ2-0005tG-Os
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 07:07:32 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v77so83405493wmv.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 04:07:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
References: <1488218699-31035-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 12:07:10 +0000
Message-ID: <CAFEAcA9z1ftc17BSP1wox-cjkd6SCNa7ywdrwMdi5_OhUbprVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/30] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 18:04, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queu; includes all the NVIC rewrite patches.
> The QOMify-armv7m patchset hasn't got enough review just
> yet but I may be able to sneak it in before freeze
> tomorrow if it gets review. Didn't want to hold this lot
> up waiting, anyway.
>
> thanks
> -- PMM
>
>
> The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170227
>
> for you to fetch changes up to 94d5bcf5a7f3799660b62098a5183f161aad0601:
>
>   hw/arm/exynos: Fix proper mapping of CPUs by providing real cluster ID (2017-02-27 17:23:16 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * raspi2: implement RNG module, GPIO and new SD card controller
>    (sufficient to boot new raspbian kernels)
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

Unfortunately I see crashes or assert failures on the raspi2
model on OSX hosts. Not sure why OSX only, probably just that
the malloc/free has different patterns of reusing freed memory.
In any case we clearly didn't get the reparent-the-sdcard code
right, so I'm going to have to drop those patches for the moment :-(

thanks
-- PMM
