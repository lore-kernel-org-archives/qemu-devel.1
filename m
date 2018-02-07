Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejOPC-0005av-QA
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ejOP9-0000pe-0I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:50 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:42002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ejOP8-0000pL-RK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:46 -0500
Received: by mail-io0-x244.google.com with SMTP id 25so1727316ioj.9
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:00:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CABoDooMmKtM5Kwr2Vwp9=jPLBHkYUFDGfdee6TFn8uC-NetLFA@mail.gmail.com>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
	<20180207111729.15737-6-ard.biesheuvel@linaro.org>
	<874lmtvx2l.fsf@linaro.org>
	<CAKv+Gu8Gh-unEST2RB5bchq5jX9OSV=z=CAGGzBWWdAQYuAySQ@mail.gmail.com>
	<CABoDooMmKtM5Kwr2Vwp9=jPLBHkYUFDGfdee6TFn8uC-NetLFA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 7 Feb 2018 12:00:45 +0000
Message-ID: <CAKv+Gu9QobkROEknP3Nu72nBYxW4Cnu3qC8iEYt4TuQ9i+JY0A@mail.gmail.com>
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
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 11:57, Laurent Desnogues
<laurent.desnogues@gmail.com> wrote:
> On Wed, Feb 7, 2018 at 12:53 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 7 February 2018 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>
>>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>>
>>>> Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instructio=
ns to
>>>> AArch64 user mode emulation.
>>>
>>> Are you aware of any processors with ARMv8.2 available yet? It might be
>>> nice to have a more recent model for system emulation and the pieces
>>> seems to be coming together.
>>>
>>
>> I think Peter's idea was to have so kind of 'max' cpu type that
>> enables all optional extensions in system emulation mode.
>> AFAIK none of the Cortex-Axx cores that are public are available with
>> these crypto features.
>
> Cortex-A75 is ARMv8.2.  It should be available in devices this year.
>

Yeah, but according to the docs on infocenter.arm.com, it does not
implement the newer crypto instructions.
