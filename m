Received: from eggs.gnu.org ([2001:4830:134:3::10]:36027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH62w-00030U-AM
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:44:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH62v-0002FU-GT
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:44:54 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH62v-0002F7-8V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:44:53 -0500
Received: by mail-wm0-x230.google.com with SMTP id b189so2305073wmd.5
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 02:44:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
References: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 10:44:31 +0000
Message-ID: <CAFEAcA9_fRAu3i9QsWRbvmZrqGqM9RLsTUBjgSyG1ndOuuNP6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 20 November 2017 at 17:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> A small set of bugfixes for rc2. (Some are patches I
> should have put into rc1 but forgot about; oops.)
>
> thanks
> -- PMM
>
>
> The following changes since commit b11ce33fe0266f8ede18cfcf961536f6a209b02b:
>
>   Revert "cpu-exec: don't overwrite exception_index" (2017-11-20 10:58:27 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171120
>
> for you to fetch changes up to b350ae138fcb062f49904f5115cc5fe188a02906:
>
>   hw/arm: Silence xlnx-ep108 deprecation warning during tests (2017-11-20 13:48:27 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm: Silence xlnx-ep108 deprecation warning during tests
>  * hw/arm/aspeed: Unlock SCU when running kernel
>  * arm: check regime, not current state, for ATS write PAR format
>  * nvic: Fix ARMv7M MPU_RBAR reads
>  * target/arm: Report GICv3 sysregs present in ID registers if needed
>
> ----------------------------------------------------------------
> Joel Stanley (1):
>       hw/arm/aspeed: Unlock SCU when running kernel
>
> Peter Maydell (3):
>       target/arm: Report GICv3 sysregs present in ID registers if needed
>       nvic: Fix ARMv7M MPU_RBAR reads
>       arm: check regime, not current state, for ATS write PAR format
>
> Thomas Huth (1):
>       hw/arm: Silence xlnx-ep108 deprecation warning during tests

Applied, thanks.

-- PMM
