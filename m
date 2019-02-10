Received: from eggs.gnu.org ([209.51.188.92]:56916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gscdT-0005TU-Ah
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 19:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gscdS-0006Fq-Bh
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 19:06:15 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gscdR-0006F6-Sn
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 19:06:14 -0500
Received: by mail-pf1-x443.google.com with SMTP id z9so3457494pfi.2
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 16:06:13 -0800 (PST)
References: <20190114011122.5995-1-richard.henderson@linaro.org>
	<20190114011122.5995-2-richard.henderson@linaro.org>
	<CAFEAcA9Kj5fXB6fe_hJAGbqG0ftjh9+VrqQQEy4bEQ6iFB508A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56022fc3-4061-4f5a-bb22-e9205e2fc34d@linaro.org>
Date: Sat, 9 Feb 2019 16:06:08 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Kj5fXB6fe_hJAGbqG0ftjh9+VrqQQEy4bEQ6iFB508A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/17] target/arm: Add MTE_ACTIVE to
 tb_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2/5/19 11:06 AM, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 01:11, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> When MTE is fully enabled, i.e. access to tags are enabled and
>> tag checks affect the PE, then arrange to perform the check
>> while stripping the TBI.
>>
>> The check is not yet implemented, just the plumbing to that point.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> @@ -0,0 +1,32 @@
>> +/*
>> + * ARM v8.5-MemTag Operations
>> + *
>> + * Copyright (c) 2019 Linaro, Ltd.
>> + *
>> + * This library is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public
>> + * License as published by the Free Software Foundation; either
>> + * version 2 of the License, or (at your option) any later version.
> 
> Do you mean LGPL version 2.1 here, or GPL version 2?

Exactly the same as all of the other Linaro contributed
files -- a confused mix.  ;-)

>> +uint64_t HELPER(mte_check)(CPUARMState *env, uint64_t ptr)
>> +{
>> +    /* Only unchecked implemented so far.  */
>> +    return sextract64(ptr, 0, 55);
> 
> Are you sure this is right?

Not exactly right, no.  I thought I had a fixme here, but that was the other
one you point out later.  Will fix.


r~
