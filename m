Received: from eggs.gnu.org ([2001:4830:134:3::10]:36654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eri2z-0006Yf-Gd
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eri2y-0001re-Np
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:36:17 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eri2y-0001rS-IW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:36:16 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 108so8320637otv.3
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 02:36:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__BbzvYOxOEQ0iydLJf0WQDDTnaivMWyY2UJeLAcy7HQ@mail.gmail.com>
References: <e2a29860b0eb2591e16a83178e305828d1b0b730.1519950018.git.alistair.francis@xilinx.com>
	<CAKmqyKOcSA0wqWrsRMXMv2E+Jb+MnYkD_h16NbEmxYohVJoj-w@mail.gmail.com>
	<CAFEAcA__BbzvYOxOEQ0iydLJf0WQDDTnaivMWyY2UJeLAcy7HQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 10:35:55 +0000
Message-ID: <CAFEAcA-RUbtzQSSvyqbG=-PD3kbui1=OdTiY2=rjWtrSVOg2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/arm: Fix the A53 L2CTLR typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 2 March 2018 at 10:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 2 March 2018 at 04:34, Alistair Francis <alistair23@gmail.com> wrote:
>>     target/arm: Report the number of cores in the cluster
>>
>>     Previously we assumed that we only has a single cluster, which meant we
>>     could get away with reporting smp_cpus to the guest. There are cases
>>     where we have two clusters (Xilinx's ZynqMP is a good example) so
>>     reporting the number of smp_cpus is incorrect. Instead count the cores
>>     in the cluster.

> This seems a bit ad-hoc (it will give the wrong answer if we have
> two clusters both of the same kind of CPU, for instance).
> Maybe it would be better to have a "cluster-size" property on
> the CPU (with the default being number of cores in whole system) ?

...though I think "cluster size" isn't quite the right name --
if you have a big.LITTLE cluster with 2xA57 and 2xA53, there are
4 cores in the cluster but I think reading the TRM that the cores
will report 2 in the L2CTLR.

thanks
-- PMM
