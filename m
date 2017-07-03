Received: from eggs.gnu.org ([2001:4830:134:3::10]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRx5d-0006FL-QY
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRx5d-0005wu-2S
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:52:17 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dRx5c-0005u5-Rb
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:52:16 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so47078940wmh.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 01:52:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5287ef7-748a-7d77-041e-03fcea607bf9@adacore.com>
References: <1498728533-23160-1-git-send-email-frederic.konrad@adacore.com>
	<1498728533-23160-3-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA-tuehYiJkYo148N0VPJ3hwhcxYDDersmbs4TOqxQCEKw@mail.gmail.com>
	<7e7d94ce-a33c-6253-8dcf-475e93fe388f@adacore.com>
	<CAFEAcA_EcMOQ6afbmZK1jYUuWGzAUzj8AKRLvoDEsezsQkPYzA@mail.gmail.com>
	<f7ff9307-f341-f7df-3c80-374626f7631a@adacore.com>
	<CAFEAcA89iy-r0OQ1T_znZ7EHZxGMZS0p=F_O5nygOVYzC_Dwgw@mail.gmail.com>
	<d5287ef7-748a-7d77-041e-03fcea607bf9@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 09:51:53 +0100
Message-ID: <CAFEAcA-C3zJ6yqsbMm8a0XM-i9Ew_OtukjGgCR5aRKzF5-0bFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/3] arm: fix the armv7m reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, alistair@alistair23.me

On 3 July 2017 at 08:31, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
> On 06/30/2017 11:06 AM, Peter Maydell wrote:
>> On 30 June 2017 at 09:24, KONRAD Frederic <frederic.konrad@adacore.com>
>> wrote:
>>> If I choose (b) I won't be able to load it to SRAM and it is
>>> basically the same result I'll need to move or modify the config.
>>
>>
>> I don't understand this, though. Option (b) is probably painful
>> to implement (I don't have a good idea of how to do it) but
>> it ought to mean that the ELF files that work on the board
>> also work for QEMU (regardless of how the board model
>> implemented the aliased flash).
>>
>
> Yes that's exactly what I want.
>
> Basically the 0x00000000 alias can point to the SRAM or the ROM
> during the reset depending on some boot config. The ELF is
> directly loaded in the ROM or in the SRAM and my patch allows to
> fetch the two first words in the reset handler to make it work
> for any boot config.

Yes, but it only works if you implemented it that way
round, and not for board implementations which put the
real device at 0 and the alias at high memory. I'd like a fix
which deals with all of this, not just with the particular
arrangement your board implementation has.

thanks
-- PMM
