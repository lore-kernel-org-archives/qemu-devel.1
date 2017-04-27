Received: from eggs.gnu.org ([2001:4830:134:3::10]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3qjI-0004RG-H7
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3qjH-0007Sx-OH
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:13:36 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3qjH-0007Ri-H2
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:13:35 -0400
Received: by mail-wm0-x22f.google.com with SMTP id u65so27380627wmu.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:13:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493314727-6951-1-git-send-email-wei@redhat.com>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Apr 2017 22:13:13 +0100
Message-ID: <CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix compilation dependency issues of
 CONFIG_ARM_V7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 April 2017 at 18:38, Wei Huang <wei@redhat.com> wrote:
> CONFIG_ARM_V7M is used to control the compilation of NVIC and SysTick
> Timer in QEMU. These two devices are not available when CONFIG_ARM_V7M
> is un-defined. This can cause problems with ARMv7M code as it is tightly
> integrated with NVIC for processing IRQ and exception.
>
> This patchset addresses the problem by introducing stub functions when
> CONFIG_ARM_V7M is not defined. It also makes the compilation of several
> existing v7M-profile SoCs depedent on CONFIG_ARM_V7M.

Can you explain in what situation this causes a problem?
It's not clear to me what you're trying to fix...

thanks
-- PMM
