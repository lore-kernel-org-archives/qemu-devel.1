Received: from eggs.gnu.org ([2001:4830:134:3::10]:57564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dFzTA-00029p-Ai
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dFzT9-0005ub-JY
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:59:08 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
References: <20170521152949.15338-1-krzk@kernel.org>
	<CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 31 May 2017 10:58:54 +0200
Message-ID: <CAJKOXPebX4GFh06NmAfkt3Vt5D-xwbeJ3UPA-Z+vMc8BtQZcZw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Tue, May 30, 2017 at 2:04 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 21 May 2017 at 16:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> This is a collection of three already sent patchsets [1] [2] [3].
>>
>>
>> Changes since previous versions (v2):
>> 1. Patch 11/11: set BIT(8) in PS_HOLD to fix power off on Linux v4.12-rc1.
>> 2. Add reviewed-by tags.
>>
>>
>> The first patch in set is a bugfix which also exposes problem of cpuidle.
>> Kernel compiled with disabled CPU_IDLE works fine (two CPUs, coming SGIs,
>> poweroff working) but with CPU_IDLE it behaves bad due to low-power
>> mode (AFTR). This was discussed at [1].
>
> So is this a regression compared to our current model? I was
> under the impression from the previous thread that it was,
> which is why I didn't apply that patchset.

It depends how wide understanding of regression you have. :)
1. Before this patch, second CPU could not boot. System was usable but
worked on only one CPU.
2. Before this patch, kernel's IRQ work is broken. None of IRQ work
are executed which is mostly visible during poweroff - system hangs on
syncing IRQ works.
3. With this patch, second CPU boots and IRQ works properly (so
poweroff is possible).
4. However with this patch, Linux kernel with cpuidle enabled (which
is also included in many kernel defconfigs), the system is very
unresponsive.

So overall... a lot of things were broken already. This patches fixes
them... but breaks different thing.

Best regards,
Krzysztof
