Received: from eggs.gnu.org ([2001:4830:134:3::10]:51415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGT13-0006xE-0C
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGT12-0005II-5x
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:32:05 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGT11-0005I5-Vp
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:32:04 -0400
Received: by mail-wm0-x22d.google.com with SMTP id d127so67187612wmf.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 09:32:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJKOXPebX4GFh06NmAfkt3Vt5D-xwbeJ3UPA-Z+vMc8BtQZcZw@mail.gmail.com>
References: <20170521152949.15338-1-krzk@kernel.org>
	<CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
	<CAJKOXPebX4GFh06NmAfkt3Vt5D-xwbeJ3UPA-Z+vMc8BtQZcZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 17:31:41 +0100
Message-ID: <CAFEAcA8Q8-U9aocQgbUTt2WP4S9Tj_K_iXZuP08x9Ck0LszS3Q@mail.gmail.com>
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

On 31 May 2017 at 09:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, May 30, 2017 at 2:04 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> So is this a regression compared to our current model? I was
>> under the impression from the previous thread that it was,
>> which is why I didn't apply that patchset.
>
> It depends how wide understanding of regression you have. :)
> 1. Before this patch, second CPU could not boot. System was usable but
> worked on only one CPU.
> 2. Before this patch, kernel's IRQ work is broken. None of IRQ work
> are executed which is mostly visible during poweroff - system hangs on
> syncing IRQ works.
> 3. With this patch, second CPU boots and IRQ works properly (so
> poweroff is possible).
> 4. However with this patch, Linux kernel with cpuidle enabled (which
> is also included in many kernel defconfigs), the system is very
> unresponsive.
>
> So overall... a lot of things were broken already. This patches fixes
> them... but breaks different thing.

It sounds like it breaks a key thing, ie "boot a single cpu kernel
built from a defconfig", though. That's a regression I'd rather
not have. If there's a subset of these patches which don't break
that I'm happy to take those. Otherwise we need to investigate
and fix whatever the problem is that causes that unresponsiveness
before we can apply them.

thanks
-- PMM
