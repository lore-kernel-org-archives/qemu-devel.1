Received: from eggs.gnu.org ([2001:4830:134:3::10]:57041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0lF3-0004a9-9p
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d0lF2-0002df-KU
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:45:37 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d0lF2-0002dM-Ew
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 04:45:36 -0400
Received: by mail-wm0-x236.google.com with SMTP id r190so16147347wme.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 01:45:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <363c3493-f7f4-25de-d679-3726651706c1@web.de>
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
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Apr 2017 09:45:14 +0100
Message-ID: <CAFEAcA9p0OuKt9yKsmB9qDnqR-EuVR8qzS9oENAW=MGkVE4CcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Constantin Petra <constantin.petra@gmail.com>, Jailhouse <jailhouse-dev@googlegroups.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel <qemu-devel@nongnu.org>

On 19 April 2017 at 05:37, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2017-04-19 05:48, Constantin Petra wrote:
>> So from some reason, under QEMU something is not in place, but what can
>> that be? It would be convenient from our perspective, if it would work...
>
> I fully agree, and I'm waiting for official EL2 support in QEMU in order
> to introduce a virtual target for ARM[64], just like we have on x86 already.

This has been in upstream QEMU for a little while now,
and will be in the upcoming 2.9 release. (Applies only for
AArch64 hosts using GICv3, needs some board support changes
which have currently only been done for 'virt'.)

thanks
-- PMM
