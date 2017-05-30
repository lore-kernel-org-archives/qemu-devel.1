Received: from eggs.gnu.org ([2001:4830:134:3::10]:49948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjLR-0002Nu-3F
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjLQ-0001jO-3m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:46:05 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFjLP-0001ix-KP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:46:03 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g76so3130187wrd.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:46:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170507113540.8687-4-krzk@kernel.org>
References: <20170507113540.8687-1-krzk@kernel.org>
	<20170507113540.8687-4-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 16:45:41 +0100
Message-ID: <CAFEAcA9Erpv3x2x6eRtJL7tSHv+Fm9Tmomi18n8QwmkWU5sJcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: Add support for system
 poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 7 May 2017 at 12:35, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On all Exynos-based boards, the system powers down itself by driving
> PS_HOLD signal low.  Handle writing to respective PMU register to fix
> power off failure:
>
>     reboot: Power down
>     Unable to poweroff system
>     shutdown: 31 output lines suppressed due to ratelimiting
>     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
>
>     CPU: 0 PID: 1 Comm: shutdown Not tainted 4.11.0-rc8 #846
>     Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>     [<c031050c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/0x14)
>     [<c030ba6c>] (show_stack) from [<c05b2800>] (dump_stack+0x88/0x9c)
>     [<c05b2800>] (dump_stack) from [<c03d3140>] (panic+0xdc/0x268)
>     [<c03d3140>] (panic) from [<c0343614>] (do_exit+0xa90/0xab4)
>     [<c0343614>] (do_exit) from [<c035f2dc>] (SyS_reboot+0x164/0x1d0)
>     [<c035f2dc>] (SyS_reboot) from [<c0307c80>] (ret_fast_syscall+0x0/0x3c)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

give or take the minor change mentioned by Eric if needed.

thanks
-- PMM
