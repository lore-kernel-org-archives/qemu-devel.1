Received: from eggs.gnu.org ([2001:4830:134:3::10]:39008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgDQ-0006D0-TX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgDP-0003YO-TL
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:56:01 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:33264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgDP-0003YB-Lo
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:55:59 -0500
Received: by mail-wm0-x230.google.com with SMTP id t18so15850704wmt.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 07:55:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <129304e20fcdc1ca7b9022c7c2c73fd9a7d5cb4a.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<129304e20fcdc1ca7b9022c7c2c73fd9a7d5cb4a.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 15:55:38 +0000
Message-ID: <CAFEAcA94_Ev2n1XB0WPgqzYtKebNGyo_a9V+-+_jhkrS+kQROg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/7] Honour reset_sctlr EE/B bits during
 reset.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:30, Julian Brown <julian@codesourcery.com> wrote:
> This patch uses the reset value of the SCTLR register (e.g. as modified
> by the "cfgend" parameter introduced by the previous patch) to set the
> endianness used by QEMU when it is invoked without a kernel or firmware
> image. The intended use case is loading code via GDB as follows:
>
>   (gdb) target remote | qemu-arm-system [options] -cpu=cortex-a15,cfgend=yes
>   (gdb) load
>   (gdb) [...]
>
> The idea being to start a board in a "reset" state in the selected
> endianness so that communication with GDB works properly. (The previous
> version of the patch used "-kernel /dev/null" for the same purpose:
> this version avoids that, and also avoids fiddling with info->endianness
> setting.)
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---

This patch is just working around the bug in patch 1 that I
mention in my comments there, so we can drop it entirely.

thanks
-- PMM
