Received: from eggs.gnu.org ([2001:4830:134:3::10]:37761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d44j3-00087s-DX
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d44j2-0007N4-LC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:10:17 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d44j2-0007MD-Ds
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:10:16 -0400
Received: by mail-wm0-x235.google.com with SMTP id r190so11031091wme.1
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 05:10:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
References: <1493314727-6951-1-git-send-email-wei@redhat.com>
	<CAFEAcA-KKvhspYza=8TNNuFtqzco=ChhtS6Aa5hnn8=Cb036-Q@mail.gmail.com>
	<4dbaaea9-7576-9acf-5327-b22db6f00ed2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Apr 2017 13:09:54 +0100
Message-ID: <CAFEAcA8K9DENSPqJD2Okqjqyi7T8RhSBmhCa3ztooJK5xdcZVg@mail.gmail.com>
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

On 28 April 2017 at 01:10, Wei Huang <wei@redhat.com> wrote:
> In our downstream code, we try to minimize the number of supported
> devices to reduce the maintenance effort. ARM v7M is not in the
> supported list.
>
> For most unsupported devices, we can remove them by configuring
> default-configs file, except for CONFIG_ARM_V7M=y. This is because the
> ARMv7m code in target/arm/helper.c intertwines with NVIC code. As a
> result we have to keep NVIC and SysTick in order to compile helper.c,
> which is not desirable.
>
> This patchset tries to address the problem by making NVIC and SysTick
> removable.

I think that's the wrong way to do it. If you want to not compile
in ARMv7M support then you need more ifdeffery in the target/arm
code to disable the v7M code and CPUs entirely. NVIC and systick
are required core parts of v7M CPUs and so if they are not
present then QEMU will claim to support the v7M cores but not
in fact correctly do so.

thanks
-- PMM
