Received: from eggs.gnu.org ([2001:4830:134:3::10]:56097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f44O5-0005l9-1i
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f44O4-0005g5-BA
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:09 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:39806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f44O4-0005fp-6P
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 08:53:08 -0400
Received: by mail-yb0-x244.google.com with SMTP id g197-v6so6499888ybf.6
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 05:53:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e1b21f62-098d-405d-40b8-fac6bdf941df@linaro.org>
References: <20180405014135.3235-1-jcmvbkbc@gmail.com>
	<e1b21f62-098d-405d-40b8-fac6bdf941df@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 5 Apr 2018 05:53:06 -0700
Message-ID: <CAMo8BfLXdomti0MDeUtjLLV7XwHPYSCmnQsdOdiK3m0hsz1g=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On Wed, Apr 4, 2018 at 8:43 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/05/2018 11:41 AM, Max Filippov wrote:
>> +static void target_low_high_to_host_low_high(abi_ulong tlow,
>> +                                             abi_ulong thigh,
>> +                                             unsigned long *hlow,
>> +                                             unsigned long *hhigh)
>> +{
>> +#if TARGET_LONG_BITS == HOST_LONG_BITS
>> +        *hlow = tlow;
>> +        *hhigh = thigh;
>> +#elif TARGET_LONG_BITS < HOST_LONG_BITS
>> +        *hlow = tlow | (unsigned long)thigh << TARGET_LONG_BITS;
>> +        *hhigh = 0;
>> +#else
>> +        *hlow = (unsigned long)tlow;
>> +        *hhigh = (unsigned long)(tlow >> HOST_LONG_BITS);
>> +#endif
>
> It might still be worth a check for HOST_LONG_BITS >= 2 * TARGET_LONG_BITS and
> #error otherwise.  Or explicit checks vs 32 & 64 if you like.

Ok, will do in v3.

-- 
Thanks.
-- Max
