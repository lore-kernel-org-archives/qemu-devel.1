Received: from eggs.gnu.org ([2001:4830:134:3::10]:48487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXr2N-00020T-Lh
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXr2I-0006Yj-MF
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:41:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXr2I-0006YW-7I
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:41:46 -0400
Received: by mail-pf0-x243.google.com with SMTP id a11-v6so8337019pff.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:41:46 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-17-richard.henderson@linaro.org>
	<CAFEAcA_-cZ6gqRf+dz1EXQthXo7bgKHzYxvVGh1HxmUVEaCRhg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3953f266-9f15-cd58-5def-2ef7e164ca8c@linaro.org>
Date: Tue, 26 Jun 2018 09:41:41 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_-cZ6gqRf+dz1EXQthXo7bgKHzYxvVGh1HxmUVEaCRhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 16/35] target/arm: Implement SVE
 floating-point compare vectors
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

On 06/25/2018 10:20 AM, Peter Maydell wrote:
>> +#define DO_FCMGE(TYPE, X, Y, ST)  TYPE##_compare(Y, X, ST) <= 0
> 
> I was expecting the RHS of this to be TYPE##_le(Y, X, ST).
> This prompted me to notice that softfloat has as well as
> the generic 'compare' routines also specialized _le/lt/unordered
> etc functions for float64 and float32 but not float16, which is
> a bit inconsistent...

Yes.  I have a mild preference to using floatN_compare everywhere and removing
the other functions entirely.  But that's a medium sized job across multiple
targets.  I also agree that in the meantime the inconsistency is surprising.


r~
