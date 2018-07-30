Received: from eggs.gnu.org ([2001:4830:134:3::10]:54790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCeG-0006dj-TT
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkCeG-0002hq-2O
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:12:00 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkCeF-0002hm-TE
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:12:00 -0400
Received: by mail-oi0-x243.google.com with SMTP id k81-v6so22970773oib.4
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:11:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730141748.430-1-peter.maydell@linaro.org>
References: <20180730141748.430-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Jul 2018 19:11:38 +0100
Message-ID: <CAFEAcA9kdFbz+ceaMD6s-1ZhcaLZYZHatxTNf6nsGWKauSBKhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 30 July 2018 at 15:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> A set of small bugfixes for arm for 3.0; the "migration was
> broken" fixes for SMMUv3 and v7M NVIC with security extensions
> are the most significant.
>
> thanks
> -- PMM
>
> The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180730
>
> for you to fetch changes up to 0261fb805c00a6f97d143235e7b06b0906bdf898:
>
>   target/arm: Remove duplicate 'host' entry in '-cpu ?' output (2018-07-30 15:07:08 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * arm/smmuv3: Fix broken VM state migration
>  * armv7m_nvic: Fix broken VM state migration
>  * hw/arm/sysbus-fdt: Fix assertion in copy_properties_from_host()
>  * hw/arm/iotkit: Fix IRQ number for timer1
>  * hw/misc/tz-mpc: Zero the LUT on initialization, not just reset
>  * target/arm: Remove duplicate 'host' entry in '-cpu ?' output
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
