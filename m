Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gRtgB-0005c9-5z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 01:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gRtgA-0002MB-6Z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 01:50:35 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gRtgA-0002Kc-1P
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 01:50:34 -0500
Received: by mail-oi1-x241.google.com with SMTP id b141so21642300oii.12
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 22:50:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181127121724.19755-1-sw@weilnetz.de>
References: <20181127121724.19755-1-sw@weilnetz.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 28 Nov 2018 07:50:32 +0100
Message-ID: <CAL1e-=hqEy3zuEeh12UiqLaw9uxJLvq2ndTjoOg-sE1YHNNBgA@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-devel@nongnu.org, Stefan Markovic <smarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Stefan Weil wrote:

> These two patches fix wrong format strings used in disas/nanomips.

Stefan,

I truly appreciate your interest in nanoMIPS dissasembler.

In my opinion, this series comes too late in 3.1 development cycle to be
accepted. The described severity of undesired behavior is just way too low
for rc3 phase.

Also, as a general remark, in this series, there is no example of wrong
output for big endian host, only some belief or opinion - referent test
example would be helpful, and much better justification for the series.
Some build errors are mentioned, but they are not a part for official
builds. Related to these errors, certain additional build options are said
to cause build warnings, but such build options were not identified.

All in all, my judgement is that we should deal with these issues after 3.1
release.

However, I am still grateful to you for bringing these issues up, and you
are welcome to participate in any way in future development of this and
other segments of QEMU for MIPS.

Yours,
Aleksandar
On Nov 27, 2018 1:19 PM, "Stefan Weil" <sw@weilnetz.de> wrote:

> These two patches fix wrong format strings used in disas/nanomips.
>
> The first patch replaces proprietary data types by POSIX data types,
> because otherwise the PRI... macros cannot be used in the second patch.
>
> Those patches are only relevant for 3.1 if full nanomips support is
> considered
> important enought and if QEMU is used on big endian machines (I think
> the old code will work on little endian hosts even with wrong format
> strings).
>
> I use those patches for QEMU for Windows because that is compiled with
> more compiler warnings, so compilation would fail without the fix.
>
> Regards
> Stefan
>
>
>
