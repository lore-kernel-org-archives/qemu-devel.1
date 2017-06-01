Received: from eggs.gnu.org ([2001:4830:134:3::10]:39301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGTor-0004bA-Bu
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGToq-0005MI-Ee
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:23:33 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGToq-0005Lz-8z
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:23:32 -0400
Received: by mail-wm0-x235.google.com with SMTP id b84so167131572wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 10:23:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170601171019.j7ist5qnuvllvfhi@kozik-lap>
References: <20170521152949.15338-1-krzk@kernel.org>
	<CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
	<CAJKOXPebX4GFh06NmAfkt3Vt5D-xwbeJ3UPA-Z+vMc8BtQZcZw@mail.gmail.com>
	<CAFEAcA8Q8-U9aocQgbUTt2WP4S9Tj_K_iXZuP08x9Ck0LszS3Q@mail.gmail.com>
	<20170601171019.j7ist5qnuvllvfhi@kozik-lap>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 18:23:10 +0100
Message-ID: <CAFEAcA_3+S8jWsKUjzivBLcJhan1mfBo7o1WzMaG6wo6qa6LuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/11] hw: arm: exynos: Bring up
 secondary CPU, QOM-ify Soc, other improvements
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

On 1 June 2017 at 18:10, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Jun 01, 2017 at 05:31:41PM +0100, Peter Maydell wrote:
>> It sounds like it breaks a key thing, ie "boot a single cpu kernel
>> built from a defconfig", though. That's a regression I'd rather
>> not have.
>
> I am not sure if I understand you correctly... the system previously
> booted into one CPU mode because second CPU just could not boot. Now by
> default, second CPU succeeds and this means that *default* settings are
> indeed more broken than before.
>
> On the other hand, after removing a line from hw/arm/exynos4210.c:
>         qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
> and running qemu with "-accel tcg -smp cpus=1,maxcpus=1,cores=1"
> everything is okay. Booting of one CPU is unaffected.

Ah, I see now.

>> If there's a subset of these patches which don't break
>> that I'm happy to take those. Otherwise we need to investigate
>> and fix whatever the problem is that causes that unresponsiveness
>> before we can apply them.
>
> Yes, you can take everything except first patch
> ("hw/intc/exynos4210_gic: Fix GIC memory mappings for secondary CPU")
> and it should be fine. Rest of patches are just independent.

Can you send a series which has just the patches that don't break,
please? I think this series needs a respin anyway because of the
make check problems (noted on the other thread).

thanks
-- PMM
