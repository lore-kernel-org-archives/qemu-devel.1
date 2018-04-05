Received: from eggs.gnu.org ([2001:4830:134:3::10]:52703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f446p-0006Cd-9q
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:35:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f446o-0005wl-Bq
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:35:19 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:38669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f446o-0005wd-5S
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:35:18 -0400
Received: by mail-ot0-x244.google.com with SMTP id o9-v6so26993149otj.5
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:35:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180404142505.4mpvautvlqemjlpp@sirius.home.kraxel.org>
References: <20180319161556.16446-1-peter.maydell@linaro.org>
	<CAFEAcA8trs8tMKBqbOLaNx4OR9H9+xO4jJQjY2+yeCNdsdCBCA@mail.gmail.com>
	<20180404142505.4mpvautvlqemjlpp@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Apr 2018 13:34:57 +0100
Message-ID: <CAFEAcA_psOOs6f+hgdcB0qT1M+O+X2P1aBKysPfdAqSc6nAMyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12 0/2] bcm2835_sdhost:
 fix interrupt handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Pekka Enberg <penberg@iki.fi>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "patches@linaro.org" <patches@linaro.org>

On 4 April 2018 at 15:25, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Wed, Apr 04, 2018 at 11:18:23AM +0100, Peter Maydell wrote:
>> Ping for code review, please? It would be nice if our 'raspi3'
>> model for 2.12 was one we could say actually booted a known
>> Linux image...
>
> The Fedora 27 image kernel (aarch64, 4.13) boots and mounts the root
> filesystem.  This is an improvement, so:
>
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>
> It doesn't finish boot though, at some point the kernel starts to
> complain about timeouts and xfs throws io errors, so things are not
> perfect yet.
>
> raspi2 doesn't boot the fedora 27 armhfp kernel.  Looks unrelated
> though, it fails with "Division by zero in kernel" before even loading
> the sdhost driver.  I suspect the kernel tries to access some hardware
> not emulated by qemu ...
>
> Trying to run u-boot as boot-loader (so I don't have to copy the kernel
> from the image) doesn't work too.

Thanks for the testing. I've applied this series to target-arm.next
for 2.12 (with minor tweaks as per code review).

I have a blog post pending which describes how to boot a Debian
image on the raspi3 model, which I'll publish once this hits
master.

thanks
-- PMM
