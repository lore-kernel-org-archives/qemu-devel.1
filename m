Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUacL-0002lD-UR
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 12:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fUacL-0006w8-5d
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 12:33:29 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fUacK-0006uV-Vu
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 12:33:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id a141-v6so12821740oii.8
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 09:33:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <826808f0-4dc4-261d-4c54-46c807bb75c9@linaro.org>
References: <20180612204632.28780-1-jusual@mail.ru>
	<CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
	<826808f0-4dc4-261d-4c54-46c807bb75c9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 17 Jun 2018 17:33:07 +0100
Message-ID: <CAFEAcA9BVi_yzA6wPjrE62mdd21d9QtVixc1OvB9PWLN2ydq+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Julia Suvorova <jusual@mail.ru>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>

On 17 June 2018 at 06:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/15/2018 12:55 AM, Peter Maydell wrote:
>>> +    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
>>> +                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
>>> +                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
>>> +    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
>>> +                              0xfff0d0f0, 0xffe0d000, 0xf800d000};
>> I think these arrays should be 'const'; we can also move them closer
>> to their point of use, inside the scope of the if() below.
>
> static as well.

Mmm; commit is already in master though, will need a followup patch.

thanks
-- PMM
