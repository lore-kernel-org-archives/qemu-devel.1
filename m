Received: from eggs.gnu.org ([2001:4830:134:3::10]:45165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er3Fa-0000sE-D4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1er3FV-0001H3-SV
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:02:34 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:39250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1er3FV-0001GM-NL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 10:02:29 -0500
Received: by mail-ot0-x233.google.com with SMTP id h8so2474645oti.6
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 07:02:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87woyxutms.fsf@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<CAFEAcA8LEG=bzXrj3etTdf_q3-AcMVfCCqSGQ2OkXUPGBHkMBQ@mail.gmail.com>
	<87woyxutms.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2018 15:02:07 +0000
Message-ID: <CAFEAcA9LGHjneP9qi0s2jyQE=hz=fa6fadgv-0Znujr62H-0NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 00/31] Add ARMv8.2
 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 28 February 2018 at 13:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> (3) Is this complete fp16 support or are there still more pieces to come=
?
>> I'm assuming it's all done...
>
> All AArch64 is done. I'm not sure how much AArch32 is needed for SVE
> support. The ARM ARM says "When this feature is implemented it is
> implemented in both Advanced SIMD and floating-point, and in AArch64 and
> AArch32 states." but I think it is legal to have a 64 bit only CPU
> without AArch32?

64-bit only is legal, but none of our current implemented CPUs
(including the proposed "max") are 64-bit only :-)
For linux-user it doesn't matter, because the code will only
run as AArch64 anyway, but before we advertise it in the ID
registers for system emulation I would definitely prefer to have
the AArch32 instructions.

Do you have a feel for how much work the AArch32 side is?

thanks
-- PMM
