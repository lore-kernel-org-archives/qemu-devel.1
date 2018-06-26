Received: from eggs.gnu.org ([2001:4830:134:3::10]:54634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXpjJ-0008Jr-Dq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXpjI-0002Xn-Ho
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:18:05 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXpjI-0002XS-2y
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:18:04 -0400
Received: by mail-oi0-x243.google.com with SMTP id 21-v6so5689818oip.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:18:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d46ca09e-f014-d5b9-570b-0d52010cd068@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-30-richard.henderson@linaro.org>
	<CAFEAcA8n=SWOAO7S_-Uf3aLn+0cAd4ocgXufQnAB4PU3WACy0w@mail.gmail.com>
	<d46ca09e-f014-d5b9-570b-0d52010cd068@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 16:17:42 +0100
Message-ID: <CAFEAcA-18gesxkKeDQALZenw62v6zPw_opU0B1UPGfFpQ6ZBsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 29/35] target/arm: Implement SVE fp
 complex multiply add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 June 2018 at 16:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 06/26/2018 06:29 AM, Peter Maydell wrote:
>>> +            e2 = (flip ? ni : nr);
>>> +            e1 = (flip ? mi : mr) ^ neg_real;
>>> +            e4 = e2;
>>> +            e3 = (flip ? mr : mi) ^ neg_imag;
>>
>> These don't seem to match up with the pseudocode, which
>> applies the neg_real or neg_imag negations to element2,
>> not element1/3. I think the operations are correct but the
>> variable names are confusingly swapped.
>
> Yes, I know.  They have different names between the SVE document and the main
> ARM ARM.  You swapped them to match the ARM when you applied the ARMv8.3-FCMA
> patch set, and I copied code from vec_helper.c to write this.
>
> Which is least confusing?

Oh, right. Let's use the same numbering in vec_helper.c as this
code, so we're at least internally consistent.

thanks
-- PMM
