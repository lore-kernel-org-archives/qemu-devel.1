Received: from eggs.gnu.org ([2001:4830:134:3::10]:49812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFftH-00045l-7J
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFftG-00019z-E7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:04:47 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFftG-00019l-7l
	for qemu-devel@nongnu.org; Tue, 30 May 2017 08:04:46 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e127so97632966wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 05:04:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170521152949.15338-1-krzk@kernel.org>
References: <20170521152949.15338-1-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 13:04:24 +0100
Message-ID: <CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
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

On 21 May 2017 at 16:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> This is a collection of three already sent patchsets [1] [2] [3].
>
>
> Changes since previous versions (v2):
> 1. Patch 11/11: set BIT(8) in PS_HOLD to fix power off on Linux v4.12-rc1.
> 2. Add reviewed-by tags.
>
>
> The first patch in set is a bugfix which also exposes problem of cpuidle.
> Kernel compiled with disabled CPU_IDLE works fine (two CPUs, coming SGIs,
> poweroff working) but with CPU_IDLE it behaves bad due to low-power
> mode (AFTR). This was discussed at [1].

So is this a regression compared to our current model? I was
under the impression from the previous thread that it was,
which is why I didn't apply that patchset.

thanks
-- PMM
