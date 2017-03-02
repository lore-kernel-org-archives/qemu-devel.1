Received: from eggs.gnu.org ([2001:4830:134:3::10]:57421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTk3-0000At-SP
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjTk3-0007Bj-1D
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:38:11 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjTk2-0007Ad-Qk
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:38:10 -0500
Received: by mail-wr0-x233.google.com with SMTP id u48so56546272wrc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 08:38:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170301182618.22395-3-krzk@kernel.org>
References: <20170301182618.22395-1-krzk@kernel.org>
	<20170301182618.22395-3-krzk@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 16:37:49 +0000
Message-ID: <CAFEAcA-wgPqejWpNC-nQSG564ABP4G+J5AeVW37aEqqSa+LHmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/5] hw/intc/exynos4210_gic: Use more
 meaningful name for local variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>

On 1 March 2017 at 18:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> There are to SysBusDevice variables in exynos4210_gic_realize()
> function: one for the device itself and second for arm_gic device.  Add
> a prefix "gic" to the second one so it will be easier to understand the
> code.
>
> While at it, put local uninitialized 'i' variable at the end, next to
> other uninitialized ones.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  hw/intc/exynos4210_gic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
