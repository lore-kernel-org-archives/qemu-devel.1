Received: from eggs.gnu.org ([2001:4830:134:3::10]:51239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpWW-0001E4-4l
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXpWS-0005d0-UG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:04:52 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXpWS-0005ch-Fl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:04:48 -0400
Received: by mail-pl0-x244.google.com with SMTP id w8-v6so8683216ply.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:04:48 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-30-richard.henderson@linaro.org>
	<CAFEAcA8n=SWOAO7S_-Uf3aLn+0cAd4ocgXufQnAB4PU3WACy0w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d46ca09e-f014-d5b9-570b-0d52010cd068@linaro.org>
Date: Tue, 26 Jun 2018 08:04:44 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8n=SWOAO7S_-Uf3aLn+0cAd4ocgXufQnAB4PU3WACy0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/26/2018 06:29 AM, Peter Maydell wrote:
>> +            e2 = (flip ? ni : nr);
>> +            e1 = (flip ? mi : mr) ^ neg_real;
>> +            e4 = e2;
>> +            e3 = (flip ? mr : mi) ^ neg_imag;
> 
> These don't seem to match up with the pseudocode, which
> applies the neg_real or neg_imag negations to element2,
> not element1/3. I think the operations are correct but the
> variable names are confusingly swapped.

Yes, I know.  They have different names between the SVE document and the main
ARM ARM.  You swapped them to match the ARM when you applied the ARMv8.3-FCMA
patch set, and I copied code from vec_helper.c to write this.

Which is least confusing?


r~
