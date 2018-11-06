Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJyjl-0005QJ-UZ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJyf7-0007BS-Nu
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:32:47 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJyf7-00074T-6s
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:32:45 -0500
Received: by mail-oi1-x230.google.com with SMTP id 192-v6so9503924oii.6
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 02:32:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1d1c0473-cd71-c7de-9d56-072596501e4c@redhat.com>
References: <1d1c0473-cd71-c7de-9d56-072596501e4c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 10:32:14 +0000
Message-ID: <CAFEAcA-6hMmfQuiA-23fgzYyp7bz0yb+t-rhD0wt_h0UMH=CgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to use the 'canon-a1100' machine?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>

On 6 November 2018 at 09:40, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi,
>
> does anybody know whether the "canon-a1100" machine in QEMU is still
> usable, or rather how it can be used at all?
>
> According to
> http://lists.infradead.org/pipermail/barebox/2014-July/020327.html there
> should be support for "-serial stdio" and on
> https://lists.gnu.org/archive/html/qemu-devel/2013-10/msg02969.html
> there is a link to a firmware image ... but when I try to use it, there
> is simply no output on stdio...
>
> Is there a way this machine can still be tested in QEMU?

I have an image in my test set:
$ ~/test-images/digic/runme ./build/x86/arm-softmmu/qemu-system-arm
Switch to console [cs0]


barebox 2013.12.0-00160-g2e82c4a #507 Thu Dec 12 12:42:43 MSK 2013


Board: Canon PowerShot A1100 IS
digic-gpio c0220000.gpio: probed gpiochip-1 with base 0
cfi_flash f8000000.flash: found cfi flash at f8000000, size 4194304
malloc space: 0x00100000 -> 0x002fffff (size 2 MiB)
Open /dev/env0 No such file or directory
no valid environment found on /dev/env0. Using default environment
running /env/bin/init...
canon> /

Command line is:

${QEMU} \
  -M canon-a1100 -serial stdio -display none \
  --machine firmware="$TESTDIR"/canon-a1100-rom1.bin

filename suggests that's the same firmware image you link to?

$ md5sum ~/test-images/digic/canon-a1100-rom1.bin
66e76691cbd8b140549c878ae3849147
/home/petmay01/test-images/digic/canon-a1100-rom1.bin

thanks
-- PMM
