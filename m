Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1d0lVS-0007e8-5M
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1d0lVP-00038y-0u
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:34 -0400
Received: from mout.web.de ([217.72.192.78]:61328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1d0lVO-00038K-Mb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:02:30 -0400
References: <1856afd9-6c92-4309-8e92-8da478864752@googlegroups.com>
	<2ab0912c-9581-7656-5a21-d7a261e62a90@siemens.com>
	<CAOT14F66-BXb4KvgvSuebFLoPL=kZPoqAZ5dqhx+ftn7886m4A@mail.gmail.com>
	<b5af41e1-d6cf-48ae-b758-a957bdb60391@googlegroups.com>
	<cf570bb4-7b1b-9788-7e89-faff52ad4502@siemens.com>
	<498d9e2d-e025-4aa1-9a47-76a9c94d8a5f@googlegroups.com>
	<5acf6dd8-4ec5-0c57-9645-3615beb755af@siemens.com>
	<CAOT14F6f2rHB4Adqo1p-VDgn4dMPUbyuRo8XPa9s7Yin_xK8rQ@mail.gmail.com>
	<29858b5d-edb6-bc5e-73df-84e8adfd2a61@web.de>
	<7d43790d-b6ac-c997-69c3-8d0249c7b7be@web.de>
	<4126cc24-3237-49fd-b28a-7d5583e1b2d4@googlegroups.com>
	<1d51b078-d8e4-bea2-064b-2d7a8e41e9eb@web.de>
	<CAOT14F6XqnYaKmNry-SN3uXzmm0Sv8RUM48074=t2d2Qmi+bkA@mail.gmail.com>
	<CAOT14F77f3tdWDHMyVj1itUiyRPwp2GYgJwKuHF+WM1a-grbjQ@mail.gmail.com>
	<363c3493-f7f4-25de-d679-3726651706c1@web.de>
	<CAFEAcA9p0OuKt9yKsmB9qDnqR-EuVR8qzS9oENAW=MGkVE4CcA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <4c587382-b690-5011-6571-9361c30b2384@web.de>
Date: Wed, 19 Apr 2017 11:02:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9p0OuKt9yKsmB9qDnqR-EuVR8qzS9oENAW=MGkVE4CcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Jailhouse on Ultrascale+ (ZCU102)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Constantin Petra <constantin.petra@gmail.com>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel <qemu-devel@nongnu.org>

On 2017-04-19 10:45, Peter Maydell wrote:
> On 19 April 2017 at 05:37, Jan Kiszka <jan.kiszka@web.de> wrote:
>> On 2017-04-19 05:48, Constantin Petra wrote:
>>> So from some reason, under QEMU something is not in place, but what can
>>> that be? It would be convenient from our perspective, if it would work...
>>
>> I fully agree, and I'm waiting for official EL2 support in QEMU in order
>> to introduce a virtual target for ARM[64], just like we have on x86 already.
> 
> This has been in upstream QEMU for a little while now,
> and will be in the upcoming 2.9 release. (Applies only for
> AArch64 hosts using GICv3, needs some board support changes
> which have currently only been done for 'virt'.)

Ah, v3 - oversaw this "minor" detail. Too bad that there is still no
GICv3 silicon in our hands that we could test against (do you know some
recommendable board?). I'm pretty sure Jailhouse's GICv3 support is
broken by now (due to lacking tests), plus it is not yet enabled for our
ARM64 port. But I'm a bit reluctant to enable this only over QEMU...

Jan
