Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRcc3-0005jM-2s
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRcc2-0007CY-Be
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRcc2-0007CO-38
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:37:10 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so19944751otj.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 04:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127121724.19755-1-sw@weilnetz.de>
In-Reply-To: <20181127121724.19755-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 12:36:57 +0000
Message-ID: <CAFEAcA_gWYGnD2cAdGRWKKZRfddPvgQoS89nxM8=ro++fO+Gmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/2] Fix disas/nanomips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>

On Tue, 27 Nov 2018 at 12:17, Stefan Weil <sw@weilnetz.de> wrote:
>
> These two patches fix wrong format strings used in disas/nanomips.
>
> The first patch replaces proprietary data types by POSIX data types,
> because otherwise the PRI... macros cannot be used in the second patch.

I think this is a good idea, but that first patch is a huge patch for
this point in the 3.1 release cycle. Can we fix the warnings
by just casting the arguments to the img::format() function ?

> Those patches are only relevant for 3.1 if full nanomips support is considered
> important enought and if QEMU is used on big endian machines (I think
> the old code will work on little endian hosts even with wrong format
> strings).

It only affects the disassembler, which is a debug tool.
A week ago this would have been a fairly definite "yes, fix it"
issue; at this point, with rc3 due to go out today, it's a bit
trickier to justify. (rc3 will be the last rc unless any showstopper
issues turn up.)

> I use those patches for QEMU for Windows because that is compiled with
> more compiler warnings, so compilation would fail without the fix.

My Windows cross-compiler builds work OK, FWIW, and -Werror is
only enabled by default for Linux builds, so warnings shouldn't
result in build failures.

thanks
-- PMM
