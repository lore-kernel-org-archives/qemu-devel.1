Received: from eggs.gnu.org ([2001:4830:134:3::10]:39856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRTm-0004JN-Hy
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:17:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ejRTj-0005aT-Ch
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:17:46 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ejRTj-0005a9-4s
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:17:43 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so4003104wmd.5
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 07:17:43 -0800 (PST)
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
	<20180207111729.15737-6-ard.biesheuvel@linaro.org>
	<87372cx2y2.fsf@linaro.org>
	<CAFEAcA_y3kzwHc8g5q4+xtDpuOggSiVGm=gVgndVA1dxdG1KTQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_y3kzwHc8g5q4+xtDpuOggSiVGm=gVgndVA1dxdG1KTQ@mail.gmail.com>
Date: Wed, 07 Feb 2018 15:17:40 +0000
Message-ID: <871shwx20b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 7 February 2018 at 14:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>
>>> Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instruction=
s to
>>> AArch64 user mode emulation.
>>
>> So another problem I've come across is I can't turn this off. I ended up
>> doing that in my FP16 series because otherwise existing RISU tests get
>> broken. However having an optional flag for each little set of
>> instructions seems overkill.
>
> Why do the existing tests break? Are they checking UNDEF
> for previously-reserved bits of the encoding space?

Yeah. Maybe the easiest solution is to find the undefs and re-generate
everything.

>
>> Have you run any RISU tests? If you want you can add this to the
>> aarch64.risu to generate some test patterns.
>
> I wrote some risu patterns for testing these. I was going
> to send the patch out tomorrow...
>
> (I used the tag A64_C82 rather than A64_V.)

Ohh that is a useful use for that tag...

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
