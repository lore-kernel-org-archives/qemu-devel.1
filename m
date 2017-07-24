Received: from eggs.gnu.org ([2001:4830:134:3::10]:34024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZknM-0004tR-H6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZknL-0002uy-PJ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:21:40 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZknL-0002ul-Ig
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:21:39 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t201so29865657wmt.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:21:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPTzt1DoAyZ3bCD3JDrt2-7UckQQ9dzG5mTrNBApoPpQ1GpV-g@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAFEAcA-R5DJUgT=fLDM4uYcRFyDWVm6hnJiPuS55jg=1AThZ6Q@mail.gmail.com>
	<CAPTzt1DoAyZ3bCD3JDrt2-7UckQQ9dzG5mTrNBApoPpQ1GpV-g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:21:17 +0100
Message-ID: <CAFEAcA8oqwPav4gU-Gk=JHnMfgzz8pdgFEPs-=u=MTVmJpP3KQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hua Yanghao <huayanghao@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 24 July 2017 at 21:03, Hua Yanghao <huayanghao@gmail.com> wrote:
> Sounds good PPM! currently I am working around this by
> objcopy a pure binary and it looks like qemu-system-arm is
> loading a binary at loader address + 0x10000. From man page
> it claims it also supports multiboot image which I thought I could
> remove this loader address + 0x10000 limiation however with
> no luck. but the binary works pretty fine though at the fixed address.
> not as convenient as elf image which I can run from any address.

If you give -kernel on ARM (non-M-profile) systems something
that isn't an ELF file this means "I am a Linux kernel and
want the calling convention documented for the kernel" (which
includes that load address, among other things). If you're
not a Linux kernel then don't do that.

You probably want the "-device loader" documented in
docs/generic-loader.txt, which is (as the name suggests)
a generic way to load an arbitrary binary into memory,
and lets you specify whatever load address you want.

thanks
-- PMM
