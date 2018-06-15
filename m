Received: from eggs.gnu.org ([2001:4830:134:3::10]:43377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fTmha-0004IT-8I
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fTmhX-0002j9-31
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:15:34 -0400
Received: from smtp16.mail.ru ([94.100.176.153]:41600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fTmhW-0002hg-H3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:15:30 -0400
References: <20180612204632.28780-1-jusual@mail.ru>
	<CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <53c12f1b-6bd8-5f6d-dc9d-7b3116392d1c@mail.ru>
Date: Fri, 15 Jun 2018 14:15:18 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-p5A4S=+ncW42KU2ivBHyALJdUswLUYhh=By6rKYstZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>

On 15.06.2018 13:55, Peter Maydell wrote:
> On 12 June 2018 at 21:46, Julia Suvorova <jusual@mail.ru> wrote:
>> ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
>> instructions and allows their execution.
>> Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.
>>
>> This patch is required for future Cortex-M0 support.
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> @@ -10075,6 +10076,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>>   {
>>       uint32_t imm, shift, offset;
>>       uint32_t rd, rn, rm, rs;
>> +    uint32_t armv6m_insn[] = {0xf3808000 /* msr */, 0xf3b08040 /* dsb */,
>> +                              0xf3b08050 /* dmb */, 0xf3b08060 /* isb */,
>> +                              0xf3e08000 /* mrs */, 0xf000d000 /* bl */};
>> +    uint32_t armv6m_mask[] = {0xffe0d000, 0xfff0d0f0, 0xfff0d0f0,
>> +                              0xfff0d0f0, 0xffe0d000, 0xf800d000};
> 
> I think these arrays should be 'const'; we can also move them closer
> to their point of use, inside the scope of the if() below.
> 
> Since those are trivial tweaks, I'm going to put this into
> target-arm.next with those changes made, if that's OK.

Sure, thanks.

Best regards, Julia Suvorova.
