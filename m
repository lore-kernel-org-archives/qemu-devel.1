Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5WAr-0002O2-Jz
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 08:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5WAo-0000Vs-Et
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 08:45:29 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5WAo-0000Un-4P
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 08:45:26 -0400
Received: by mail-wm0-x243.google.com with SMTP id 66so12562907wmd.3
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 05:45:25 -0700 (PDT)
References: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
Date: Mon, 09 Apr 2018 13:45:22 +0100
Message-ID: <87efjov999.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Crash when running hello-world unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, rumpkernel-users@freelists.org


Ajay Garg <ajaygargnsit@gmail.com> writes:

> Hi All.
>
> We did the following :
>
> a)
> Cross-compile rumprun for ARM on a linux x86_64 :
>
> ajay@latitude-3480:~/rumprun-arm-hw/rumprun$
> CC=3Darm-linux-gnueabihf-gcc ./build-rr.sh hw
<snip>
>
> c)
> Tried running on x86_64, via qemu, but got the crash :
>
> ######################################################################
> ajay@latitude-3480:~/rumprun-arm-hw/rumprun$ qemu-system-x86_64
> -nographic -kernel helloer.bin
> warning: TCG doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
> qemu: fatal: Trying to execute code outside RAM or ROM at 0x00000000000a0=
1f1
>
<snip>
>
>
> Where should we be looking to start to fix?

qemu-system-x86_64 is expecting an x86 binary blob. I assume you need
qemu-system-arm. More importantly you need to specify a -M machine type
that matches whatever rumprun is expecting.

--
Alex Benn=C3=A9e
