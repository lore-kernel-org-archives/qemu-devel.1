Received: from eggs.gnu.org ([2001:4830:134:3::10]:54402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQN1-0005fs-IM
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUQMw-0006J7-Mq
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:36:59 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUQMw-0006Im-Go
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 01:36:54 -0400
Received: by mail-pl0-x244.google.com with SMTP id 31-v6so7357873plc.4
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 22:36:54 -0700 (PDT)
References: <20180612204632.28780-1-jusual@mail.ru>
	<CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <826808f0-4dc4-261d-4c54-46c807bb75c9@linaro.org>
Date: Sat, 16 Jun 2018 19:36:47 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Julia Suvorova <jusual@mail.ru>
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>

On 06/15/2018 12:55 AM, Peter Maydell wrote:
>> +    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
>> +                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
>> +                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
>> +    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
>> +                              0xfff0d0f0, 0xffe0d000, 0xf800d000};
> I think these arrays should be 'const'; we can also move them closer
> to their point of use, inside the scope of the if() below.

static as well.


r~
