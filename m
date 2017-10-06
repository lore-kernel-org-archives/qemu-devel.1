Received: from eggs.gnu.org ([2001:4830:134:3::10]:59582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TuI-0001vD-Uw
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TuH-00008l-Op
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:47:18 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:52685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TuH-00007A-Hd
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:47:17 -0400
Received: by mail-wm0-x233.google.com with SMTP id k4so8403811wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:47:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-1-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:46:55 +0100
Message-ID: <CAFEAcA9nAK8RJmb5RHpw1xPv6HZp_E-YWztahfNPtg2_yjfY2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/17] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Hi everyone,
>
> This patch series contains the work that I've done in order to enable
> support for i.MX7 emulation in QEMU. Majority of the set are just odd
> fixes and small features implementation that I had to do to already
> exisitng code but last 5 commits contain new emulation code.
>
> As the one before last commit in the series states the supported i.MX7
> features are:
>
>     * up to 2 Cortex A9 cores (SMP works with PSCI)
>     * A7 MPCORE (identical to A15 MPCORE)
>     * 7 i.MX UARTs
>     * 1 CCM device
>     * 2 Ethernet controllers (FEC)
>     * 3 SD controllers (USDHC)
>     * 1 SNVS device
>     * 1 WDT device
>
> I also have a follow up series that implements bit needes for PCIe
> emulation support (DesignWare IP emulation + supporting code) which
> I'll be submitting after this series is accepted.

Hi; thanks for these patches. I've now reviewed most of them. Hopefully
somebody else can get to the sdhci patches, as sdhci is not an
area I know much about and I don't think I have the specs.

Please also run your patches through scripts/checkpatch.pl and fix
those issues as necessary (the script does occasionally have false
positives so you need not follow it blindly if it suggests something
ridiculous).

thanks
-- PMM
