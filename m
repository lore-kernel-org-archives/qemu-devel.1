Received: from eggs.gnu.org ([2001:4830:134:3::10]:55680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cei4A-0005JJ-9p
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cei49-0004KD-Is
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:55:14 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cei49-0004K1-D8
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:55:13 -0500
Received: by mail-wr0-x22d.google.com with SMTP id i10so29439640wrb.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 04:55:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210210857.47893-1-marcinch7@gmail.com>
References: <20170210210857.47893-1-marcinch7@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 12:54:51 +0000
Message-ID: <CAFEAcA-i6xqsik1=hMk9N0w-rCa8JxZD9VF7h==hjYJokx1fCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] target-arm: Implement BCM2835 hardware
 RNG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcin Chojnacki <marcinch7@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 February 2017 at 21:08, Marcin Chojnacki <marcinch7@gmail.com> wrote:
> Recent vanilla Raspberry Pi kernels started to make use of
> the hardware random number generator in BCM2835 SoC. As a
> result, those kernels wouldn't work anymore under QEMU
> but rather just freeze during the boot process.
>
> This patch implements a trivial BCM2835 compatible RNG,
> and adds it as a peripheral to BCM2835 platform, which
> allows to boot a vanilla Raspberry Pi kernel under Qemu.

So this looks good to me (other than the rand issue which
I just posted a patch for). My testing shows that it
definitely helps for the raspbian image I just downloaded.
However although the kernel boots OK it hangs indefinitely
because it can't find a root filesystem -- presumably
it doesn't see the sd card. Do you see that, or does it
work for you?

thanks
-- PMM
