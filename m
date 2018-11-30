Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl9V-0001Mw-BX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gSl9T-0000A5-On
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:56:25 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gSl9T-000091-I0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:56:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so5541134otk.1
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 07:56:23 -0800 (PST)
MIME-Version: 1.0
References: <1543407172-16175-1-git-send-email-peng.hao2@zte.com.cn>
	<1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1543407172-16175-8-git-send-email-peng.hao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Nov 2018 15:56:10 +0000
Message-ID: <CAFEAcA83C_Eic3K4yY5bGeEKJpY2uf26diFtDJ5r+W71jcX2DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V10 7/9] hw/misc/pvpanic: preparing for
 adding configure interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Wed, 28 Nov 2018 at 03:50, Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> Prepare for pvpanic-mmio configure interface.
>
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  hw/arm/sysbus-fdt.c |  2 ++
>  hw/arm/virt.c       |  2 ++
>  hw/misc/pvpanic.c   | 11 +++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)

This looks rather odd. The sysbus-fdt.c code is for
handling devices that we must pass through from the
host system (including pulling in device tree fragments
from the host). The pvpanic device isn't a host pass
through device so I don't think it should be touching
that code at all. It's just a simple MMIO device.

I suspect the reason you've done this is that you're
trying to get "-device pvpanic" to work on the command
line. I recommend not trying to get that to work.
MMIO devices are not pluggable devices, and -device
is not expected to work with them.

thanks
-- PMM
