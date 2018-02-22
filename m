Received: from eggs.gnu.org ([2001:4830:134:3::10]:35243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowY5-0005Iz-LZ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eowY4-0008FT-PT
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:28:57 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eowY4-0008F7-JA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 14:28:56 -0500
Received: by mail-pl0-x243.google.com with SMTP id d4so3445670pll.5
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 11:28:56 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-5-richard.henderson@linaro.org>
	<CAFEAcA9Xy8z85KRuVUFLJtEwpUgu+cHGYe_A6ymxurWZL-N+RQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <374e47e7-4d6d-0c77-0cbd-b2b665b41157@linaro.org>
Date: Thu, 22 Feb 2018 11:28:52 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Xy8z85KRuVUFLJtEwpUgu+cHGYe_A6ymxurWZL-N+RQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 04/67] target/arm: Implement
 SVE Bitwise Logical - Unpredicated Group
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

On 02/22/2018 10:04 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> These were the instructions that were stubbed out when
>> introducing the decode skeleton.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate-sve.c | 50 +++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
>> index 2c9e4733cb..50cf2a1fdd 100644
>> --- a/target/arm/translate-sve.c
>> +++ b/target/arm/translate-sve.c
>> @@ -32,6 +32,10 @@
>>  #include "trace-tcg.h"
>>  #include "translate-a64.h"
>>
>> +typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
>> +typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
>> +                        uint32_t, uint32_t, uint32_t);
> 
> I see we already have these in translate-a64.c -- put them in
> translate-a64.h ?

Good plan, thanks.


r~
