Received: from eggs.gnu.org ([2001:4830:134:3::10]:48113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1ejOLv-0002nD-GG
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1ejOLu-0005Nu-Sg
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:57:27 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1ejOLu-0005NN-NF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:57:26 -0500
Received: by mail-oi0-x243.google.com with SMTP id t78so454521oih.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:57:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8Gh-unEST2RB5bchq5jX9OSV=z=CAGGzBWWdAQYuAySQ@mail.gmail.com>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
	<20180207111729.15737-6-ard.biesheuvel@linaro.org>
	<874lmtvx2l.fsf@linaro.org>
	<CAKv+Gu8Gh-unEST2RB5bchq5jX9OSV=z=CAGGzBWWdAQYuAySQ@mail.gmail.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 7 Feb 2018 12:57:25 +0100
Message-ID: <CABoDooMmKtM5Kwr2Vwp9=jPLBHkYUFDGfdee6TFn8uC-NetLFA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Feb 7, 2018 at 12:53 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 7 February 2018 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>>
>>> Add support for the new ARMv8.2 SHA-3, SM3, SM4 and SHA-512 instruction=
s to
>>> AArch64 user mode emulation.
>>
>> Are you aware of any processors with ARMv8.2 available yet? It might be
>> nice to have a more recent model for system emulation and the pieces
>> seems to be coming together.
>>
>
> I think Peter's idea was to have so kind of 'max' cpu type that
> enables all optional extensions in system emulation mode.
> AFAIK none of the Cortex-Axx cores that are public are available with
> these crypto features.

Cortex-A75 is ARMv8.2.  It should be available in devices this year.

HTH,

Laurent
