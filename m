Received: from eggs.gnu.org ([209.51.188.92]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaM4-0005Zc-Bv
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBaLz-0001Hm-NL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:30:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBaLu-0001Dg-0g
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 03:30:32 -0400
Received: by mail-pg1-x542.google.com with SMTP id j26so7866842pgl.5
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 00:30:26 -0700 (PDT)
References: <20190403034358.21999-1-richard.henderson@linaro.org>
	<20190403034358.21999-2-richard.henderson@linaro.org>
	<CAFEAcA99NgExCLYzwfw1sWAmKr7PHGZSY6_+=etnV74NSjz1qA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <562a38e6-9d18-6bff-1f40-3042e968f378@linaro.org>
Date: Wed, 3 Apr 2019 14:30:20 +0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99NgExCLYzwfw1sWAmKr7PHGZSY6_+=etnV74NSjz1qA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] tcg: Assert h2g_valid for 32-bit
 guest on 64-bit host
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

On 4/3/19 11:59 AM, Peter Maydell wrote:
>> +#if TARGET_LONG_BITS == 32 && HOST_LONG_BITS == 64
>> +    g_assert(h2g_valid(address));
>> +#endif
> 
> I'm not sure this is right. h2g_valid() will check whether the guest address is
> below GUEST_ADDR_MAX. For architectures which set
> TARGET_VIRT_ADDR_SPACE_BITS to something less than 32 there are
> address values which aren't h2g_valid() but which we still want to cause
> a guest exception rather than asserting, aren't there ?

Hmm, you're right, this should test something else.
I'll drop this for now...


r~
