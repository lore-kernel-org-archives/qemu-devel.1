Received: from eggs.gnu.org ([2001:4830:134:3::10]:41337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLtOF-0001as-1w
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLtOD-0005j5-VV
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:46:59 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:32882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLtOD-0005ij-Fq
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:46:57 -0400
Received: by mail-ot0-x242.google.com with SMTP id l22-v6so2739206otj.0
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 09:46:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0d3fb5f8-a8b1-57b8-2f16-294e1f824aab@vivier.eu>
References: <20180519092956.15134-1-laurent@vivier.eu>
	<20180519092956.15134-7-laurent@vivier.eu>
	<CAFEAcA8Wc2boEtJQC2feZ_N07no-ErGGk-Hhwyyuo91kGaTc2w@mail.gmail.com>
	<a423df2b-02a1-07f9-075f-55e68607f357@vivier.eu>
	<0d3fb5f8-a8b1-57b8-2f16-294e1f824aab@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 17:46:36 +0100
Message-ID: <CAFEAcA9sTRXt2EQvarSwUXwL_moPSYZ7vC_y-odRC4QoTZfSPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/8] linux-user: update
 ARCH_HAS_SOCKET_TYPES use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@mips.com>, Richard Henderson <rth@twiddle.net>

On 24 May 2018 at 16:50, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 24/05/2018 =C3=A0 17:29, Laurent Vivier a =C3=A9crit :
>> Le 21/05/2018 =C3=A0 11:19, Peter Maydell a =C3=A9crit :
>>> On 19 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
>>>> to be like in the kernel and rename it TARGET_ARCH_HAS_SOCKET_TYPES
>>>
>>> You could note in the commit message that this fixes our
>>> incorrect definition of TARGET_SOCK_CLOEXEC for SPARC.
>>
>> I agree
>
> In fact it doesn't change the value of TARGET_SOCK_CLOEXEC for SPARC,
> because original value is 020000000 (0x400000) and the new value from
> linux-user/socket.h is TARGET_O_CLOEXEC which is also 0x400000 for SPARC.

Argh, octal vs hex. Thanks for checking that.

-- PMM
