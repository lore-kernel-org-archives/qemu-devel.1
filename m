Received: from eggs.gnu.org ([2001:4830:134:3::10]:37826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejRKX-0007KF-Pr
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejRKT-0000Or-Rs
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:08:13 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:38572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejRKT-0000My-MK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:08:09 -0500
Received: by mail-oi0-x22e.google.com with SMTP id j15so875382oii.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:08:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87372cx2y2.fsf@linaro.org>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
	<20180207111729.15737-6-ard.biesheuvel@linaro.org>
	<87372cx2y2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 15:07:48 +0000
Message-ID: <CAFEAcA_y3kzwHc8g5q4+xtDpuOggSiVGm=gVgndVA1dxdG1KTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/5] target/arm: enable user-mode SHA-3,
 SM3, SM4 and SHA-512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 14:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instructions=
 to
>> AArch64 user mode emulation.
>
> So another problem I've come across is I can't turn this off. I ended up
> doing that in my FP16 series because otherwise existing RISU tests get
> broken. However having an optional flag for each little set of
> instructions seems overkill.

Why do the existing tests break? Are they checking UNDEF
for previously-reserved bits of the encoding space?

> Have you run any RISU tests? If you want you can add this to the
> aarch64.risu to generate some test patterns.

I wrote some risu patterns for testing these. I was going
to send the patch out tomorrow...

(I used the tag A64_C82 rather than A64_V.)

thanks
-- PMM
