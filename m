Received: from eggs.gnu.org ([208.118.235.92]:38602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gcXq6-0002AH-Vw
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 10:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gcXq6-00068i-5D
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 10:44:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gcXq5-00068P-VU
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 10:44:50 -0500
Received: by mail-ot1-x344.google.com with SMTP id 40so16569016oth.4
	for <qemu-devel@nongnu.org>; Thu, 27 Dec 2018 07:44:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5887a794-7e88-0904-4e35-64234233eb72@redhat.com>
References: <20181205221126.16220-1-paul.burton@mips.com>
	<5887a794-7e88-0904-4e35-64234233eb72@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 27 Dec 2018 16:44:48 +0100
Message-ID: <CAL1e-=gCUoQrh8D=7ttzAptJN920d2cq7pwb19uDfUBvSn7BmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] atomic.h: Set ATOMIC_REG_SIZE=8 for MIPS
 n32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Paul Burton <paul.burton@mips.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

> On 12/5/18 11:11 PM, Paul Burton wrote:
> ATOMIC_REG_SIZE is currently defined as the default sizeof(void *) for
> all MIPS host builds, including those using the n32 ABI. n32 is the
> MIPS64 ILP32 ABI and as such tcg/mips/tcg-target.h defines
> TCG_TARGET_REG_BITS as 64 for n32 builds. If we attempt to build QEMU
> for an n32 host with support for a 64b target architecture then
> TCG_OVERSIZED_GUEST is 0 and accel/tcg/cputlb.c attempts to use atomic_*
> functions. This fails because ATOMIC_REG_SIZE is 4, causing the calls to
> QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE) in the various
> atomic_* functions to generate errors.
>
> Fix this by defining ATOMIC_REG_SIZE as 8 for all MIPS64 builds, which
> will cover both n32 (ILP32) & n64 (LP64) ABIs in much the same was as we
> already do for x86_64/x32.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

I am going to include this patch in next mips pull request scheduled for
today or tomorrow.

Aleksandar
