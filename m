Received: from eggs.gnu.org ([2001:4830:134:3::10]:33148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1d0zZ2-0004aA-O8
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1d0zYz-0004my-L9
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:03:12 -0400
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com
	([104.47.38.73]:59103
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1d0zYz-0004mH-6N
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 20:03:09 -0400
Date: Wed, 19 Apr 2017 22:30:05 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20170419203005.GG19639@toto>
References: <CAOT14F6f2rHB4Adqo1p-VDgn4dMPUbyuRo8XPa9s7Yin_xK8rQ@mail.gmail.com>
	<29858b5d-edb6-bc5e-73df-84e8adfd2a61@web.de>
	<7d43790d-b6ac-c997-69c3-8d0249c7b7be@web.de>
	<4126cc24-3237-49fd-b28a-7d5583e1b2d4@googlegroups.com>
	<1d51b078-d8e4-bea2-064b-2d7a8e41e9eb@web.de>
	<CAOT14F6XqnYaKmNry-SN3uXzmm0Sv8RUM48074=t2d2Qmi+bkA@mail.gmail.com>
	<CAOT14F77f3tdWDHMyVj1itUiyRPwp2GYgJwKuHF+WM1a-grbjQ@mail.gmail.com>
	<363c3493-f7f4-25de-d679-3726651706c1@web.de>
	<CAFEAcA9p0OuKt9yKsmB9qDnqR-EuVR8qzS9oENAW=MGkVE4CcA@mail.gmail.com>
	<4c587382-b690-5011-6571-9361c30b2384@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4c587382-b690-5011-6571-9361c30b2384@web.de>
Subject: Re: [Qemu-devel] Jailhouse on Ultrascale+ (ZCU102)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Constantin Petra <constantin.petra@gmail.com>, Jailhouse <jailhouse-dev@googlegroups.com>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Apr 19, 2017 at 11:02:21AM +0200, Jan Kiszka wrote:
> On 2017-04-19 10:45, Peter Maydell wrote:
> > On 19 April 2017 at 05:37, Jan Kiszka <jan.kiszka@web.de> wrote:
> >> On 2017-04-19 05:48, Constantin Petra wrote:
> >>> So from some reason, under QEMU something is not in place, but what can
> >>> that be? It would be convenient from our perspective, if it would work...
> >>
> >> I fully agree, and I'm waiting for official EL2 support in QEMU in order
> >> to introduce a virtual target for ARM[64], just like we have on x86 already.
> > 
> > This has been in upstream QEMU for a little while now,
> > and will be in the upcoming 2.9 release. (Applies only for
> > AArch64 hosts using GICv3, needs some board support changes
> > which have currently only been done for 'virt'.)
> 
> Ah, v3 - oversaw this "minor" detail. Too bad that there is still no
> GICv3 silicon in our hands that we could test against (do you know some
> recommendable board?). I'm pretty sure Jailhouse's GICv3 support is
> broken by now (due to lacking tests), plus it is not yet enabled for our
> ARM64 port. But I'm a bit reluctant to enable this only over QEMU...

Hi,

Xilinx QEMU has support for the virtualization extensions in the GICv2 but
we're seeing issues with running hypervisors in multi-core setups.
It seems like guest migration between cores is causing trouble but we
haven't pinpointed the exact cause.

I'd be interested in debugging the problem seen with Jailhouse.
Can the images and instructions on howto run be shared with me?

Thanks,
Edgar
